Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265422AbUABHxf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 02:53:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265425AbUABHxf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 02:53:35 -0500
Received: from [66.62.77.7] ([66.62.77.7]:10113 "EHLO mail.gurulabs.com")
	by vger.kernel.org with ESMTP id S265422AbUABHxd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 02:53:33 -0500
Subject: Re: Synaptics 3button emulation hosed in 2.6.0-mm2
From: Dax Kelson <dax@gurulabs.com>
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200401020207.39713.dtor_core@ameritech.net>
References: <1073024655.2516.11.camel@mentor.gurulabs.com>
	 <200401020207.39713.dtor_core@ameritech.net>
Content-Type: text/plain
Message-Id: <1073029814.2516.39.camel@mentor.gurulabs.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.5 (1.4.5-7) 
Date: Fri, 02 Jan 2004 00:50:14 -0700
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2004-01-02 at 00:07, Dmitry Torokhov wrote:
> On Friday 02 January 2004 01:24 am, Dax Kelson wrote:
> > Brief summary: 3 button emulation very flaky
> > Linux: Fedora with 2.6.0-mm2
> > Laptop: Dell Inspiron 4150
> >
> > ----------------------------
> > mice: PS/2 mouse device common for all mice
> > serio: i8042 AUX port at 0x60,0x64 irq 12
> > synaptics reset failed
> > synaptics reset failed
> > synaptics reset failed
> 
> First off do not use ACPI PM timer...

OK

> Also, could you please tell me if it's X or GPM and what's in your "InputDevices"
> section of XFConfig and what parameters are you passing to GPM.

I have these two entries (stock Fedora and what worked with 2.4):

Section "InputDevice"
        Identifier  "Mouse0"
        Driver      "mouse"
        Option      "Protocol" "PS/2"
        Option      "Device" "/dev/psaux"
        Option      "ZAxisMapping" "4 5"
        Option      "Emulate3Buttons" "yes"
EndSection                                                                                
Section "InputDevice"
        Identifier  "DevInputMice"
        Driver      "mouse"
        Option      "Protocol" "IMPS/2"
        Option      "Device" "/dev/input/mice"
        Option      "ZAxisMapping" "4 5"
        Option      "Emulate3Buttons" "no"
EndSection

------

My GPM invocation: gpm -m /dev/mouse -t ps/2

(/dev/mouse is symlink to /dev/psaux)

Dax Kelson

