Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261373AbVCHF1Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbVCHF1Q (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Mar 2005 00:27:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261367AbVCHF1Q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Mar 2005 00:27:16 -0500
Received: from mail.kroah.org ([69.55.234.183]:51177 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S261373AbVCHF05 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Mar 2005 00:26:57 -0500
Date: Mon, 7 Mar 2005 21:26:43 -0800
From: Greg KH <greg@kroah.com>
To: alan@redhat.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, luc@saillard.org,
       torvalds@osdl.org
Subject: Re: [PATCH] Restore PWC driver
Message-ID: <20050308052643.GA16222@kroah.com>
References: <200503072216.j27MGLqR024373@hera.kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200503072216.j27MGLqR024373@hera.kernel.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 07, 2005 at 09:49:40PM +0000, Linux Kernel Mailing List wrote:
> ChangeSet 1.1982.132.4, 2005/03/07 13:49:40-08:00, alan@lxorguk.ukuu.org.uk
> 
> 	[PATCH] Restore PWC driver
> 	
> 	PWC has a new maintainer (Luc Saillard) and also the various contentious
> 	binary hooks removed and replaced with reverse engineering work.
> 	
> 	Please restore it to the kernel

Ick, Alan, couldn't you have had the decency to run this through the USB
developers, and at least pinged me on it?  Especially due to all of the
hate-email I have gotten over this driver in the past.

As it is, the coding style sucks in places, and you didn't really need
to make it a new subdirectory (although due to the increased size of the
driver, it's probably better now...)

And, there's no MAINTAINERS entry for who I need to bug about this
thing.

Bleah.

So, who's going to fix up:
	- the MAINTAINERS entry
	- the coding style
	- drop that unneeded changelog file
	- fix the module help text to point to the proper file (or put
	  the file in the proper place.)
	- get rid of the c++ crud in the header file
	- drop the "magic" nonsense
	- the ioctls to work on 64bit machines
?

And I found all of that in just a quick glance over the code...

Double bleah.

greg k-h
