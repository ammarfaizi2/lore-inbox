Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267294AbUJNWOv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267294AbUJNWOv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Oct 2004 18:14:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267994AbUJNWON
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Oct 2004 18:14:13 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:36227 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S267170AbUJNUqo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Oct 2004 16:46:44 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: linux-kernel@vger.kernel.org
Date: Thu, 14 Oct 2004 13:46:10 -0700
MIME-Version: 1.0
Subject: Re: Generic VESA framebuffer driver and Video card BOOT?
Message-ID: <416E8322.25700.29ACC2F1@localhost>
In-reply-to: <m3brf5m5in.fsf@averell.firstfloor.org>
References: <2PjiW-3hl-21@gated-at.bofh.it> (Kendall Bennett's message of "Thu, 14 Oct 2004 21:20:10 +0200")
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@muc.de> wrote:

> "Kendall Bennett" <KendallB@scitechsoft.com> writes:
> >
> > So what do you guys think? 
> 
> How big is the module with emulator etc.? 

About 150K compiled on x86 (before linking so that has symbol information 
etc in it).

> Normally putting such an emulator into kernel space doesn't sound
> very attractive, but if it's small enough it can be perhaps
> considered. Still it might be better to do it in user space. 

It is small, but for the purposes we need it for it wasn't possible to 
put the code into user space. We thought about keeping it in user space 
but unfortunately the code is needed when the framebuffer console driver 
initialises which is very early in the boot sequence. So unless there is 
a way to spawn a user mode process that early in the boot sequence (it 
would have to come from the initrd image I expect) then the only option 
is to compile it into the kernel.

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


