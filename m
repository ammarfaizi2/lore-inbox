Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S268497AbRHAW2u>; Wed, 1 Aug 2001 18:28:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268500AbRHAW2k>; Wed, 1 Aug 2001 18:28:40 -0400
Received: from tomts13.bellnexxia.net ([209.226.175.34]:29872 "EHLO
	tomts13-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S268497AbRHAW2X>; Wed, 1 Aug 2001 18:28:23 -0400
Message-ID: <3B68828B.CD08EF9D@yahoo.co.uk>
Date: Wed, 01 Aug 2001 18:28:27 -0400
From: Thomas Hood <jdthoodREMOVETHIS@yahoo.co.uk>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.7-ac3 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org,
        Allan Sandfeld Jensen <snowwolf@one2one-networks.com>
Subject: Re: Wheel mice on thinkpad ps/2
In-Reply-To: <20010801093139Z266133-28344+31@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Allan Sandfeld Jensen wrote:
> I've solved a long standing problem with using an extended mouse over the
> ps/2 port on a thinkpad.  (search deja, I found bugreports dating back to
> 1998, all unanswered)
> I discovered there is a "smart" device called a trackpoint controller, that
> accumulates movement from both the trackpoints and the external mouse.
> Provided it understands the external mouse! (it only understand standard
> mice) A quick hack is disabling the trackpoint controller by sending 0xe2
> 0x4e, but a more general solution would be to write a linux driver that
> autodetected a trackpoint controller with external mouse and disabled it.  In
> that way it would be transparant to userspace drivers.

The TrackPoint can be auto-disabled using tools like PS2.EXE and
tpctl too.  Unfortunately, the current Linux drivers do not
handle wheel data correctly.  Vojtech Pavlik's new input drivers
(the ones that are already used for USB HIDs) do handle wheel data
correctly, but these will only go into Linux 2.5 I'm told.
More info at my site:
    http://panopticon.csustan.edu/thood/tp600lnx.htm#secmouse

> The easiest for my would be writing it into pc_keyb.c but that's not
> appropiate. So where should I place the driver?
> If I want advanced functionality, where I instead demultiplexes the
> trackpoint and the external mouse into a /dev/psaux1 and -2, I need to take
> over the aux interrupthandler. Otherwise I can just speak through the
> standard psaux.
> And what of the new input-class, should all inputdevices eventually move over
> there, or just USB?

If you want to hack the existing drivers, perhaps you
should get in touch will Till Straumann, who has written
TrackPoint utilities for Linux:
    http://www-hft.ee.TU-Berlin.DE/~strauman/tp4utils/

--
Thomas Hood
jdthood_AT_yahoo.co.uk
