Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265773AbUJVRZW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265773AbUJVRZW (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Oct 2004 13:25:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266186AbUJVRMX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Oct 2004 13:12:23 -0400
Received: from mail.scitechsoft.com ([63.195.13.67]:41904 "EHLO
	mail.scitechsoft.com") by vger.kernel.org with ESMTP
	id S265234AbUJVRKv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Oct 2004 13:10:51 -0400
From: "Kendall Bennett" <KendallB@scitechsoft.com>
Organization: SciTech Software, Inc.
To: "Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com>
Date: Fri, 22 Oct 2004 10:10:43 -0700
MIME-Version: 1.0
Subject: RE: [Linux-fbdev-devel] Re: Generic VESA framebuffer driver and Video card BOOT?
CC: <linux-kernel@vger.kernel.org>, <linux-fbdev-devel@lists.sourceforge.net>
Message-ID: <4178DCA3.681.25909C7A@localhost>
In-reply-to: <88056F38E9E48644A0F562A38C64FB600328792F@scsmsx403.amr.corp.intel.com>
X-mailer: Pegasus Mail for Windows (4.21c)
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Content-description: Mail message body
X-Spam-Flag: NO
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Pallipadi, Venkatesh" <venkatesh.pallipadi@intel.com> wrote:

> I have done some experiments with this video post stuff. I think
> this should be done using x86 emulator rather than doing in real
> mode. The reason being, with an userlevel emulator we can call it
> at different times during resume. The current real mode videopost
> does it before the driver has restored the PCI config space. Some
> systems (mostly the ones with Radeon card) requires this to be
> done after PCI config space is restored. With a userspace
> emulator, we can call it at various places during the driver
> restore. 
> 
> I have seen the SciTech's x86 emulator in X.org. I could seperate
> it out from X into a stand alone application that does x86
> emulation. I use it to get the video back on my laptop (which has
> radeon card), by calling this user level emulator using
> usermodehelper call. I hope we will have x86 emulator sitting in a
> standard place in userspace. That way we can use it in driver
> restore and solve the S3 video restore problem in a more generic
> way. 

We already have all this code completely separate from X and would 
release this as part of the Video Boot package for Linux. The kernel 
module is one part of it, but the code can be compiled as a stand alone 
user land program as well (SNAPBoot we call it right now). 

Regards,

---
Kendall Bennett
Chief Executive Officer
SciTech Software, Inc.
Phone: (530) 894 8400
http://www.scitechsoft.com

~ SciTech SNAP - The future of device driver technology! ~


