Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265339AbUBAP4J (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 Feb 2004 10:56:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265354AbUBAP4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 Feb 2004 10:56:09 -0500
Received: from av5-1-sn4.m-sp.skanova.net ([81.228.10.112]:22153 "EHLO
	av5-1-sn4.m-sp.skanova.net") by vger.kernel.org with ESMTP
	id S265339AbUBAP4F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 Feb 2004 10:56:05 -0500
To: Andreas Jellinghaus <aj@dungeon.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6 input drivers FAQ
References: <20040201100644.GA2201@ucw.cz>
	<pan.2004.02.01.15.25.39.951190@dungeon.inka.de>
From: Peter Osterlund <petero2@telia.com>
Date: 01 Feb 2004 16:56:02 +0100
In-Reply-To: <pan.2004.02.01.15.25.39.951190@dungeon.inka.de>
Message-ID: <m2ekte94kt.fsf@p4.localdomain>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Jellinghaus <aj@dungeon.inka.de> writes:

> And what about dell latitude laptops (synaptics touchpad - works fine -
> plus that mouse stick - no reaction at all?
> 
> Usualy I'm fine with the touchpad, but some people prefer to use
> the stick or both. Any idea?

X isn't reading from /dev/input/mouse1, which is where the events for
the stick go in your case. You need to add another InputDevice to your
X config or use the /dev/input/mice device node.

> devices: (plus pcspeaker and keyboard):
> I: Bus=0011 Vendor=0002 Product=0007 Version=0000
> N: Name="SynPS/2 Synaptics TouchPad"
> P: Phys=isa0060/serio1/input0
> H: Handlers=mouse0 event1 
> B: EV=b 
> B: KEY=6420 0 670000 0 0 0 0 0 0 0 0 
> B: ABS=11000003 
> 
> I: Bus=0011 Vendor=0002 Product=0001 Version=0000
> N: Name="PS/2 Generic Mouse"
> P: Phys=synaptics-pt/serio0/input0
> H: Handlers=mouse1 event2 
> B: EV=7 
> B: KEY=70000 0 0 0 0 0 0 0 0 
> B: REL=3 
> 
> XF86Config:
> Section "InputDevice"
>         Identifier  "Mouse0"
>         Driver      "mouse"
>         Option      "Protocol" "ExplorerPS/2"
>         Option      "Device" "/dev/input/mouse0"
>         Option      "Emulate3Buttons" "on"
> EndSection

-- 
Peter Osterlund - petero2@telia.com
http://w1.894.telia.com/~u89404340
