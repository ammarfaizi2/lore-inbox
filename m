Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289809AbSBOO35>; Fri, 15 Feb 2002 09:29:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289811AbSBOO3r>; Fri, 15 Feb 2002 09:29:47 -0500
Received: from c19177.thoms1.vic.optusnet.com.au ([203.164.210.75]:3086 "HELO
	pc.kolivas.net") by vger.kernel.org with SMTP id <S289809AbSBOO3o>;
	Fri, 15 Feb 2002 09:29:44 -0500
Content-Type: text/plain; charset=US-ASCII
From: Con Kolivas <conman@kolivas.net>
Reply-To: conman@kolivas.net
To: linux-kernel@vger.kernel.org
Subject: Wrong priority reporting with new 0(1) scheduler;  USB changes to 2.4.18 pre/rc1 breaks HPOJ
Date: Sat, 16 Feb 2002 01:29:41 +1100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020215142941.79B12942@pc.kolivas.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Priority reporting issue:

I've applied the 0(1) scheduler patch in conjunction with the preemptible 
patch to 2.4.18 pre (sched-O1-2.4.18-pre8-K3.patch and 
preempt-kernel-rml-2.4.18-rc1-ingo-K3-1.patch)

I found that top and other process managers (like kpm) report the priority as 
9 instead of 0 for nice level 0 applications with the preemptible patch, and 
15 with both preemptible and 0(1). Nice'd applications can have their 
priority reported as high as 39. It seems to read it as 15-20 higher than 
the nice value. The kernel appears to work flawlessly otherwise.


USB issue:

The USB changes after 2.4.17 up to and including 2.4.18 rc1 cause the hp 
officejet drivers to fail on my machine. While the usb mouse continues to 
work, the hp ptal-init probe cannot find the device when scanning 
/dev/usb/lp0. The device is still reported correctly in 
/proc/bus/usb/devices. This is with both the usb-uhci and the uhci drivers.

Hardware configuration:
Soltek 65KV apollo pro via motherboard with PIII 933. HP Officejet G55.

Regards,
Con Kolivas

(Please cc: me if any correspondence is appropriate as I am not subscribed to 
lkml)
