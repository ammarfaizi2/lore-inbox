Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261640AbTJHSGu (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Oct 2003 14:06:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261659AbTJHSGu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Oct 2003 14:06:50 -0400
Received: from nika.frontier.iarc.uaf.edu ([137.229.94.16]:29332 "EHLO
	nika.frontier.iarc.uaf.edu") by vger.kernel.org with ESMTP
	id S261640AbTJHSGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Oct 2003 14:06:48 -0400
Date: Wed, 8 Oct 2003 10:08:10 -0800
From: Christopher Swingley <cswingle@iarc.uaf.edu>
To: linux-kernel@vger.kernel.org
Subject: 2.6.0-test6, psmouse.c, lost synchronization
Message-ID: <20031008180810.GE3933@iarc.uaf.edu>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-gpg-fingerprint: B96C 58DC 0643 F8FE C9D0  8F55 1542 1A4F 0698 252E
X-gpg-key: [http://www.frontier.iarc.uaf.edu/~cswingle/gnupgkey.asc]
X-URL: [http://www.frontier.iarc.uaf.edu/~cswingle/]
X-Editor: VIM [http://www.vim.org]
X-message-flag: Consider Linux: fast, reliable, secure & free!
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings!

I recently got a new laptop (Intel Brookdale Chipset, Pentium 4) and I'm 
having trouble with the mouse.

* Short version:  the kernel sees the Synaptics touchpad, but X doesn't 
(using the 0.11.7 userspace synaptics X module).  X (without the 
synaptics module) understands the touchpad and my external PS/2 
trackball, but I periodically get very erratic behavior from the 
external mouse and synchronization errors from psmouse.c.

I don't care about the touchpad, but would like my external PS/2 mouse 
to work properly in X.

* Long version: It has a touchpad, which the kernel reports on bootup 
as:

    Synaptics Touchpad, model: 1
     Firmware: 4.6 \ 180 degree mounted touchpad \ Sensor: 18
     new absolute packet format \ Touchpad has extended capability bits
     -> four buttons \ -> multifinger detection \ -> palm detection
    input: SynPS/2 Synaptics TouchPad on isa0060/serio4

I installed the latest synaptics driver (0.11.7) and configured XF864.1 
according to the INSTALL file.  X reports:

    (II) xfree driver for the synaptics touchpad 0.11.7
    Query no Synaptics: 6003C8
    (EE) no synaptics touchpad detected and no repeater device
    (EE) Unable to query/initialize Synaptics hardware

But I also have a PS/2 mouse config in my XF86Config-4, and it loads 
this pointer.

In X, the touchpad appears to work just fine, but the PS/2 mouse I have 
plugged into the PS/2 port occasionally behaves erratically, and causes 
kernel messages like this:

    kernel: psmouse.c: Mouse at isa0060/serio3/input0 lost 
        synchronization, throwing 2 bytes away

I don't really care too much about the touchpad because I always use an 
external PS/2 trackball anyway, but I would like it to work.

Config / more detail available on request.

Thanks!

Chris
-- 
Christopher S. Swingley          email: cswingle@iarc.uaf.edu
IARC -- Frontier Program         Please use encryption.  GPG key at:
University of Alaska Fairbanks   www.frontier.iarc.uaf.edu/~cswingle/

