Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267406AbUHMT63@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267406AbUHMT63 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 13 Aug 2004 15:58:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267452AbUHMT4L
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 13 Aug 2004 15:56:11 -0400
Received: from mail.enyo.de ([212.9.189.167]:2060 "EHLO mail.enyo.de")
	by vger.kernel.org with ESMTP id S267410AbUHMTtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 13 Aug 2004 15:49:15 -0400
To: Linus Torvalds <torvalds@osdl.org>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: SG_IO and security
References: <1092313030.21978.34.camel@localhost.localdomain>
	<Pine.LNX.4.58.0408120929360.1839@ppc970.osdl.org>
	<Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org>
From: Florian Weimer <fw@deneb.enyo.de>
Date: Fri, 13 Aug 2004 21:49:10 +0200
In-Reply-To: <Pine.LNX.4.58.0408120943210.1839@ppc970.osdl.org> (Linus
 Torvalds's message of "Thu, 12 Aug 2004 09:45:46 -0700 (PDT)")
Message-ID: <87fz6qzumh.fsf@deneb.enyo.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Linus Torvalds:

> On Thu, 12 Aug 2004, Linus Torvalds wrote:
>> 
>> Hmm.. This still allows the old "junk" commands (SCSI_IOCTL_SEND_COMMAND).
>
> Btw, I think the _right_ thing to check is the write access of the file 
> descriptor. If you have write access to a block device, you can delete the 
> data, so you might as well be able to do the raw commands. And that would 
> allow things like "disk" groups etc to work and burn CD's.

But wouldn't the ability to burn CDs imply that a user can also
corrupted the firmware of the drive, unless other countermeasures are
in place?
