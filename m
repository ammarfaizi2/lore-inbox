Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265051AbUEYTVr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265051AbUEYTVr (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 May 2004 15:21:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265052AbUEYTVr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 May 2004 15:21:47 -0400
Received: from web41301.mail.yahoo.com ([66.218.93.186]:17253 "HELO
	web41301.mail.yahoo.com") by vger.kernel.org with SMTP
	id S265051AbUEYTVo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 May 2004 15:21:44 -0400
Message-ID: <20040525192144.92663.qmail@web41301.mail.yahoo.com>
Date: Tue, 25 May 2004 12:21:44 -0700 (PDT)
From: gb <bakerg3@yahoo.com>
Reply-To: greg@bakers.org
Subject: 2.4.26 agpgart on Tyan K8W 32bit not working?
To: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


...damned yahoo.  Please allow me to finish this
email...

> I have tried booting with:
> 
> kernel /vmlinuz-2.4.26-bangalore4-01 ro
root=/dev/hda2
> hdc=ide-scsi apm=power-off agp_try_unsupported=1

but get the same results.

So the most obvious difference is that lspci returns 

> 04:00.0 Host bridge: Advanced Micro Devices [AMD]
> AMD-8151 System Controller (rev 13)
> 04:01.0 PCI bridge: Advanced Micro Devices [AMD]
> AMD-8151 AGP Bridge (rev 13)

on a 64bit kernel, whereas this is missing on a 32bit
kernel.  This may have something to do with the
agpgart messages spit out on the 32bit kernel.

The .config I am using has these two options:

[root@profit root]# grep AGP /usr/src/linux/.config
CONFIG_AGP=y
CONFIG_AGP_INTEL=y
CONFIG_AGP_I810=y
CONFIG_AGP_VIA=y
CONFIG_AGP_AMD=y
CONFIG_AGP_AMD_K8=y
CONFIG_AGP_SIS=y
CONFIG_AGP_ALI=y
# CONFIG_AGP_SWORKS is not set
CONFIG_AGP_NVIDIA=y
# CONFIG_AGP_ATI is not set

So perusing the agpgart_be.c file appears that this
should work on a 32bit kernel.  What I am missing?

Please let me know if you have any suggestions or
comments.

Thanks,

--Greg


	
		
__________________________________
Do you Yahoo!?
Friends.  Fun.  Try the all-new Yahoo! Messenger.
http://messenger.yahoo.com/ 
