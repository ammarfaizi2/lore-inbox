Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318767AbSIGQGg>; Sat, 7 Sep 2002 12:06:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318769AbSIGQGg>; Sat, 7 Sep 2002 12:06:36 -0400
Received: from subnet.sub.net ([212.227.14.21]:57618 "EHLO subnet.sub.net")
	by vger.kernel.org with ESMTP id <S318767AbSIGQGg>;
	Sat, 7 Sep 2002 12:06:36 -0400
Message-ID: <3D7A2133.EB157AC@lubitz.org>
Date: Sat, 07 Sep 2002 17:54:27 +0200
From: Holger Lubitz <holger@lubitz.org>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.19 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: ide drive dying?
References: <200209061722.g86HMuPp004452@darkstar.example.net> <200209062122.31597.devilkin-lkml@blindguardian.org> <3D79C719.8020706@fugmann.dhs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Anders Fugmann wrote:
> I have had sucess in firmware-upgrading these drives, after which all
> problems were gone forever.

Which firmware version do your drives show? I ran the firmware upgrade
on my two DTLA half a year ago, and ended up with this:

Model=IBM-DTLA-307045, FwRev=TX6OA59A
Model=IBM-DTLA-305040, FwRev=TW4OA69A

(from hdparm -i output - the former 0A changed to 9A after the upgrade,
rest stayed the same)

Both work fine (they never failed me before the upgrade either).
However, at least the second drive still clicks often enough for me to
notice. I am still worried, though smartsuite says I'm fine - if I read
the output correctly.

It seems to click only when doing lots of write requests for extended
periods of time (like unbatching and spooling several megabytes of news
- one or two usually don't trigger it, larger batches do).

I wonder if it would be possible for the driver to monitor SMART and
lighten the load on the drive when things don't seem normal.

What is normal, anyway? For example, my Seagate Barracuda IV shows
continually increasing raw values for "Raw Read Error Rate", "Seek Error
Rate" and "Hardware ECC Recovered". It works fine, though. The older U5
I still have running has a high but pretty constant raw value for the
first, a slower rate of increase for the second and doesn't show the
third.

I don't really believe the 310617 power on hours my Maxtor (the old 60
gig with 4 platters) claims, either.

Holger
