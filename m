Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261779AbUFCHr6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261779AbUFCHr6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 3 Jun 2004 03:47:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261718AbUFCHr6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 3 Jun 2004 03:47:58 -0400
Received: from atlas.informatik.uni-freiburg.de ([132.230.150.3]:32249 "EHLO
	atlas.informatik.uni-freiburg.de") by vger.kernel.org with ESMTP
	id S261779AbUFCHry convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 3 Jun 2004 03:47:54 -0400
To: Dmitry Torokhov <dtor_core@ameritech.net>
Cc: linux-kernel@vger.kernel.org, Tuukka Toivonen <tuukkat@ee.oulu.fi>,
       Andries Brouwer <aeb@cwi.nl>, Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: [PATCH] serio.c: dynamically control serio ports bindings via procfs (Was: [RFC/RFT] Raw access to serio ports)
References: <20040602190927.79289.qmail@web81306.mail.yahoo.com>
	<200406030158.42703.dtor_core@ameritech.net>
	<xb7d64h3y2k.fsf@savona.informatik.uni-freiburg.de>
	<200406030239.40046.dtor_core@ameritech.net>
From: Sau Dan Lee <danlee@informatik.uni-freiburg.de>
Date: 03 Jun 2004 09:47:19 +0200
In-Reply-To: <200406030239.40046.dtor_core@ameritech.net>
Message-ID: <xb78yf53wxk.fsf@savona.informatik.uni-freiburg.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.2
MIME-Version: 1.0
Content-Type: text/plain; charset=big5
Content-Transfer-Encoding: 8BIT
Organization: Universitaet Freiburg, Institut fuer Informatik
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Dmitry" == Dmitry Torokhov <dtor_core@ameritech.net> writes:

    >> The info are binary (shown in 0x????  notation).  Each reflects
    >> directly the binary value of the corresponding 'attribute'.
    >> 
    >> 1) None of these are arrays.  But in the input system, each
    >> device can be attached to _multiple_ handlers, and each handler
    >> can handle _multiple_ devices.  That's an n-to-n relation.

    Dmitry> And when they join together they form a new entity, a new
    Dmitry> device. And that's input system, not serio.

No.  The AT keyboard is still ONE device (cat /proc/bus/input/devices)
after loading 'evbug'.  It is  just connected to two handlers: kbd and
evbug.  No new  device is created just because  the AT keyboard device
is joined to the evbug handler.


    >>  2) I can't find out how to dynamically change the driver of a
    >> PCI device.

    Dmitry> No need really. PCI devices are easily identifiable.

Suppose there  are 2  "competing" drivers for  one device.  I  want to
switch the device to driver 2 at 23:00, and switch it back to driver 1
at 08:00.  How to do that?


    >>  3) PCI device<-->handler is a many-to-one relation.  The input
    >> system is many-to-many.
    >> 
    >> 4) How to display/parse a device<-->handler connection?  You
    >> want to show and accept a pointer value?

    Dmitry> Strings are perfectly valid:

Of course.  What can't be represented as bit-strings?


    Dmitry> $ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_driver
    Dmitry> acpi-cpufreq 
    Dmitry> $ cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_available_governors
    Dmitry> powersave userspace performance

    Dmitry> It just depends on implementation.

Then, go ahead an implement it.  I have no interest in sysfs.


-- 
Sau Dan LEE                     §õ¦u´°(Big5)                    ~{@nJX6X~}(HZ) 

E-mail: danlee@informatik.uni-freiburg.de
Home page: http://www.informatik.uni-freiburg.de/~danlee

