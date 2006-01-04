Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932179AbWADQLT@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932179AbWADQLT (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Jan 2006 11:11:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932204AbWADQLT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Jan 2006 11:11:19 -0500
Received: from cs.rice.edu ([128.42.1.30]:24774 "EHLO cs.rice.edu")
	by vger.kernel.org with ESMTP id S932179AbWADQLS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Jan 2006 11:11:18 -0500
To: petero2@telia.com, Vojtech Pavlik <vojtech@ucw.cz>
Cc: linux-kernel@vger.kernel.org
Subject: tap-drag on laptop touchpad no longer works in 2.6.15 and 2.6.13
From: Scott A Crosby <scrosby@cs.rice.edu>
Organization: Rice University
Date: Wed, 04 Jan 2006 10:09:24 -0600
Message-ID: <oydd5j80ybv.fsf@cs.rice.edu>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) XEmacs/21.4.17 (linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I'm not sure if it was a planned change, but the default behavior for
my touchpad has changed --- I can no longer tap-drag.

It works fine in 2.6.10 and no longer works on 2.6.13 or 2.6.15 on my
Dell Inspiron 8200.

The device is recognized (by 2.6.15) as:

I: Bus=0011 Vendor=0002 Product=0008 Version=0000
N: Name="DualPoint Stick"
P: Phys=isa0060/serio1/input1
S: Sysfs=/class/input/input1
H: Handlers=mouse0 event1 
B: EV=7
B: KEY=70000 0 0 0 0 0 0 0 0
B: REL=3

I: Bus=0011 Vendor=0002 Product=0008 Version=2222
N: Name="AlpsPS/2 ALPS DualPoint TouchPad"
P: Phys=isa0060/serio1/input0
S: Sysfs=/class/input/input2
H: Handlers=mouse1 event2 
B: EV=f
B: KEY=420 0 70000 0 0 0 0 0 0 0 0
B: REL=3
B: ABS=1000003


xorg.conf:

Section "InputDevice"
        Identifier      "Configured Mouse"
        Driver          "mouse"
        Option          "SendCoreEvents"        "true"
        Option          "Device"                "/dev/input/mice"
        Option          "Protocol"              "Auto"
        Option          "Emulate3Buttons"       "true"
        Option          "ZAxisMapping"          "4 5"
EndSection


Thanks,
Scott
