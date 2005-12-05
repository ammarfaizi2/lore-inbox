Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751460AbVLEXIE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751460AbVLEXIE (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Dec 2005 18:08:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751495AbVLEXIE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Dec 2005 18:08:04 -0500
Received: from kanga.kvack.org ([66.96.29.28]:40684 "EHLO kanga.kvack.org")
	by vger.kernel.org with ESMTP id S1751460AbVLEXID (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Dec 2005 18:08:03 -0500
Date: Mon, 5 Dec 2005 18:05:02 -0500
From: Benjamin LaHaise <bcrl@kvack.org>
To: Rob Landley <rob@landley.net>
Cc: Greg KH <greg@kroah.com>, linux-kernel@vger.kernel.org
Subject: Re: RFC: Starting a stable kernel series off the 2.6 kernel
Message-ID: <20051205230502.GB12955@kvack.org>
References: <20051203152339.GK31395@stusta.de> <20051203225020.GF25722@merlin.emma.line.org> <20051204002043.GA1879@kroah.com> <200512051647.55395.rob@landley.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200512051647.55395.rob@landley.net>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2005 at 04:47:55PM -0600, Rob Landley wrote:
> So no in-kernel filesystem can get this right without help from userspace 
> (even devfs had devfsd), and as soon as you've got a userspace daemon to tell 
> the kernel who is who you might as well do the whole thing there, now that 
> the kernel is exporting everyting _else_ we need to know via /sys 
> and /sbin/hotplug.

/sbin/hotplug is suboptimal.  Even a pretty fast machine is slowed down 
pretty significantly by the ~thousand fork and exec that take place during 
startup.  For the most common devices -- common tty, pty, floppy, etc that 
every system has, this is a plain waste of resources -- otherwise known as 
bloat.

		-ben
-- 
"You know, I've seen some crystals do some pretty trippy shit, man."
Don't Email: <dont@kvack.org>.
