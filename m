Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945942AbWBCUUO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945942AbWBCUUO (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 15:20:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945944AbWBCUUO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 15:20:14 -0500
Received: from mail.kroah.org ([69.55.234.183]:10674 "EHLO perch.kroah.org")
	by vger.kernel.org with ESMTP id S1945942AbWBCUUM (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 15:20:12 -0500
Date: Fri, 3 Feb 2006 12:19:45 -0800
From: Greg KH <greg@kroah.com>
To: Dave Hansen <haveblue@us.ibm.com>
Cc: Linus Torvalds <torvalds@osdl.org>, Kirill Korotaev <dev@sw.ru>,
       Kirill Korotaev <dev@openvz.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       frankeh@watson.ibm.com, clg@fr.ibm.com, alan@lxorguk.ukuu.org.uk,
       serue@us.ibm.com, arjan@infradead.org, Rik van Riel <riel@redhat.com>,
       Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
       Andrey Savochkin <saw@sawoct.com>, devel@openvz.org,
       Pavel Emelianov <xemul@sw.ru>
Subject: Re: [RFC][PATCH 1/5] Virtualization/containers: startup
Message-ID: <20060203201945.GA18224@kroah.com>
References: <43E38BD1.4070707@openvz.org> <Pine.LNX.4.64.0602030905380.4630@g5.osdl.org> <43E3915A.2080000@sw.ru> <Pine.LNX.4.64.0602030939250.4630@g5.osdl.org> <1138991641.6189.37.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1138991641.6189.37.camel@localhost.localdomain>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2006 at 10:34:01AM -0800, Dave Hansen wrote:
> 
> Lastly, is this a place for krefs?  I don't see a real need for a
> destructor yet, but the idea is fresh in my mind.

Well, what happens when you drop the last reference to this container?
Right now, your patch doesn't cause anything to happen, and if that's
acceptable, then fine, you don't need to use a struct kref.

But if not, then why have a reference count at all?  :)

thanks,

greg k-h
