Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267656AbTAaB1Y>; Thu, 30 Jan 2003 20:27:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267658AbTAaB1Y>; Thu, 30 Jan 2003 20:27:24 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:37986 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S267656AbTAaB1X>; Thu, 30 Jan 2003 20:27:23 -0500
Date: Thu, 30 Jan 2003 20:36:46 -0500
From: Pete Zaitcev <zaitcev@redhat.com>
Message-Id: <200301310136.h0V1ak901476@devserv.devel.redhat.com>
To: David van Hoose <davidvh@cox.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: USB Logitech Trackball
In-Reply-To: <mailman.1043975764.32188.linux-kernel2news@redhat.com>
References: <mailman.1043975764.32188.linux-kernel2news@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I have a USB Logitech cordless trackball with a wheel.
> It works in 2.5.59, but not in 2.4.21-pre4.
> The kernels are setup the exact same. When my system boots up, I see a 
> message about the USB Logitech Receiver, but the trackball doesn't work 
> in the console or in KDE. It works with RedHat's 2.4.18-19.8.0 kernel, 
> but only in KDE (Odd), so I am guessing that they may have partially 
> backported a patch from the beta kernel.

Make sure you get hid and mousedev loaded with the -pre4,
because 2.4.18-19 has autoload code which Vojtech rejected.
If the thing refuses to work with all modules loaded,
you can help by doing a patch bisection from the 2.4.18-19
SRPM and post results to the list. Actually, just try
taking out everything that has *usb* or *input* in the patch name.

-- Pete
