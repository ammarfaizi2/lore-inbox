Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261635AbVAHClw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261635AbVAHClw (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Jan 2005 21:41:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261644AbVAHClw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Jan 2005 21:41:52 -0500
Received: from mail.tyan.com ([66.122.195.4]:11784 "EHLO tyanweb.tyan")
	by vger.kernel.org with ESMTP id S261635AbVAHClr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Jan 2005 21:41:47 -0500
Message-ID: <3174569B9743D511922F00A0C943142307291365@TYANWEB>
From: YhLu <YhLu@tyan.com>
To: Mikael Pettersson <mikpe@csd.uu.se>, ak@muc.de
Cc: Matt_Domsch@dell.com, discuss@x86-64.org, jamesclv@us.ibm.com,
       linux-kernel@vger.kernel.org, suresh.b.siddha@intel.com
Subject: RE: 256 apic id for amd64
Date: Fri, 7 Jan 2005 18:53:24 -0800 
MIME-Version: 1.0
X-Mailer: Internet Mail Service (5.5.2653.19)
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I mean keep the bsp physical apic id using 0.

YH

-----Original Message-----
From: Mikael Pettersson [mailto:mikpe@csd.uu.se] 
Sent: Friday, January 07, 2005 6:38 PM
To: YhLu; ak@muc.de
Cc: Matt_Domsch@dell.com; discuss@x86-64.org; jamesclv@us.ibm.com;
linux-kernel@vger.kernel.org; suresh.b.siddha@intel.com
Subject: Re: 256 apic id for amd64

On Fri, 7 Jan 2005 22:12:00 +0100, Andi Kleen wrote:
>On Fri, Jan 07, 2005 at 01:14:24PM -0800, YhLu wrote:
>> After keep the bsp using 0, the jiffies works well. Werid?
>
>Probably a bug somewhere.  But since BSP should be always 
>0 I'm not sure it is worth tracking down.

I hope by "0" you're referring to a Linux kernel defined
software value and _not_ what the HW or BIOS conjured up!

Case in point: I was involved a while ago in tracking down
and fixing a local APIC enumeration bug in the x86-32 (i386)
kernel code, where the kernel failed miserably on some
dual K7 boxes because (a) only one CPU socket was populated,
(b) the BIOS assigned that CPU a non-zero ID, and (c) the
kernel (apic.c) had a bug which triggered when BSP ID != 0.

Never trust a BIOS to DTRT.

/Mikael
