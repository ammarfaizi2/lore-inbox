Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261245AbTHWCrD (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 22 Aug 2003 22:47:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261360AbTHWCrD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 22 Aug 2003 22:47:03 -0400
Received: from smtp803.mail.sc5.yahoo.com ([66.163.168.182]:35697 "HELO
	smtp803.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261245AbTHWCrA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 22 Aug 2003 22:47:00 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: linux-kernel@vger.kernel.org
Subject: 2.6: Synaptics TouchPad and GPM (GPM patches)
Date: Fri, 22 Aug 2003 21:46:56 -0500
User-Agent: KMail/1.5.1
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200308222146.56381.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Apologies for the semi-offtopic message but ever since support for 
Synaptics' absolute mode went in many people complained that it 
broke GPM. 

I did some work on extending evdev support in GPM, the new protocol
implementation supports following subtypes:

1. relative device - standard relative device like generic PS/2 mouse
   reporting via /dev/input/eventX
2. absolute device - touch screens and tablets.
3. touchpad - device reporting absolute coordinates and pressure via
   /dev/input/event, GPM recognizes normal and corner tapping.
4. synaptics - same as touchpad but also supports multi-finger taps
   (expects MSC_GESTURE messages from the kernel).

Kernel has to support EV_SYNC for touchpad and synaptics support, 
relative and absolute modes can be used with 2.4 kernels by specifying
nosync option.
 
You will find the patches at:
http://www.geocities.com/dt_or/gpm/patches/

RPMs (binary and source) built on RH8 are at:
http://www.geocities.com/dt_or/gpm/RPMS/

The README is at:
http://www.geocities.com/dt_or/gpm/gpm.html

The patches work pretty well for me and I hope they will work for others too.
Because of limited hardware I could not test evdev with touchscreen or a 
tablet.

Dmitry.
