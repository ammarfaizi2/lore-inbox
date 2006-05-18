Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932165AbWESBN7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932165AbWESBN7 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 May 2006 21:13:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932167AbWESBN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 May 2006 21:13:58 -0400
Received: from smtp.enter.net ([216.193.128.24]:9732 "EHLO smtp.enter.net")
	by vger.kernel.org with ESMTP id S932166AbWESBN6 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 May 2006 21:13:58 -0400
From: "D. Hazelton" <dhazelton@enter.net>
To: Helge Hafting <helge.hafting@aitel.hist.no>
Subject: Re: replacing X Window System !
Date: Thu, 18 May 2006 20:27:28 +0000
User-Agent: KMail/1.8.1
Cc: linux cbon <linuxcbon@yahoo.fr>, Valdis.Kletnieks@vt.edu,
       linux-kernel@vger.kernel.org
References: <20060517123937.75295.qmail@web26605.mail.ukl.yahoo.com> <446C61F8.7080406@aitel.hist.no>
In-Reply-To: <446C61F8.7080406@aitel.hist.no>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200605182027.29184.dhazelton@enter.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linux does provide a system in kernel for accessing the graphics cards. This 
includes both the DRM system and the framebuffer drivers. If the hardware 
drivers, such as the DRM drivers and system and the framebuffer drivers, were 
extended to allow a bit more utility, perhaps by providing a documented API 
(in the framebuffer case) it should be a simple matter to rewrite X so that 
it doesn't require root access. That this *hasn't* been done is both a 
problem with the kernel documentation and the X developers - more the X 
developers than anything.

In the case of the DRM drivers, I, personally, feel they should implement the 
accelerated drawing commands, or perhaps have a passthrough method similar to 
the SG system, then X and Mesa could easily access all features of the 
hardware through the userspace side of the DRM driver, which itself could 
provide the API as a wrapper around an IOCTL interface, or perhaps a sysfs 
interface.

For the Framebuffer drivers I, personally, would like to see its userspace 
accessable bits documented. This is, of course, assuming that there is more 
to it than an interface for setting the video mode and writing the graphics 
data to the device file. Now, if the framebuffer device was extended to 
provide some sort of interface, either via IOCTL or via a set of sysfs files, 
to the full capabilities of the device, then all problems of X needing to be 
root once more disappear.

Note that I am not advocating putting the windowing system in-kernel, just 
expanding the kernel interface to the various graphics devices so that future 
versions of X will not be required to have direct access to the hardware. 

I have no experience with kernel-level programming and no experience in 
graphics programming beyond some simple DOS applications I wrote in the days 
of just using a pointer to 0xB000 and 0xC000. Despite that I would be willing 
to set aside all my private projects and lend any assistance required to make 
any of these suggestions happen if anyone wishes to pick them up.

DRH
