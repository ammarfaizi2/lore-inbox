Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265691AbUGTGue@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265691AbUGTGue (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Jul 2004 02:50:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265697AbUGTGue
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Jul 2004 02:50:34 -0400
Received: from smtp814.mail.sc5.yahoo.com ([66.163.170.84]:15742 "HELO
	smtp814.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S265691AbUGTGuc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Jul 2004 02:50:32 -0400
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Vojtech Pavlik <vojtech@suse.cz>
Subject: Re: Input patches
Date: Tue, 20 Jul 2004 01:50:14 -0500
User-Agent: KMail/1.6.2
Cc: LKML <linux-kernel@vger.kernel.org>
References: <200407200137.56150.dtor_core@ameritech.net>
In-Reply-To: <200407200137.56150.dtor_core@ameritech.net>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-Id: <200407200150.14854.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 20 July 2004 01:37 am, Dmitry Torokhov wrote:
> Vojtech,
> 
> Now that my driver core patches have been merged in Linus' tree I would
> like finish merging input patches. Please do:
> 
>        bk pull bk//dtor.bkbits.net/input
> 
> You will pull the following patches (along with whatever was in Linus'
> tree as of last evening):
> 

Continuing as for some reason half of the letter went into limbo...

09-mousedev-drop-attribute.packed
        - drop __attribute__ ((packed)) from mousedev as we ca spare couple
          of bytes to get better code readability

10-i8042-platform-device.patch
        - make i8042 a platform device (instead of system) device so its
          ports have a proper parent

11-serio-platform-devices.patch
        - integrate ct82c710, maceps2, q40kbd and rpckbd with sysfs
          as platform devices so their serio ports have proper parents

12-serio-bus-default-attr.patch
        - qwitch to use bus' default device and driver attributes to
          manage serio sysfs attributes

13-serio-manual-bind.patch
        - allow marking serio ports (in addition to serio drivers)
          as manual bind only, export the flag through sysfs:
             echo -n "manual" > /sys/bus/serio/devices/serio0/bind_mode
             echo -n "auto" > /sys/bus/serio/drivers/serio_raw/bind_mode

14-serio-use-driiver-find:
        - use driver_find when doing manual binding, adjust refcounting as
          driver_find takes a reference.

I will not be sending individual patches as they have been posted couple times
already and I'd hate spamming LKML once again.

-- 
Dmitry
