Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265339AbTANWAd>; Tue, 14 Jan 2003 17:00:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265333AbTANWAd>; Tue, 14 Jan 2003 17:00:33 -0500
Received: from mailout03.sul.t-online.com ([194.25.134.81]:59852 "EHLO
	mailout03.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S265339AbTANWAb>; Tue, 14 Jan 2003 17:00:31 -0500
Cc: linux-kernel@vger.kernel.org
References: <Pine.LNX.4.51.0301142044400.6432@dns.toxicfilms.tv>
From: Olaf Dietsche <olaf.dietsche@t-online.de>
To: Maciej Soltysiak <solt@dns.toxicfilms.tv>
Subject: Re: timing an application
Date: Tue, 14 Jan 2003 23:09:16 +0100
Message-ID: <87vg0rjsdv.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Military
 Intelligence, i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maciej Soltysiak <solt@dns.toxicfilms.tv> writes:

> being inspired by some book about optimizing c++ code i decided to do
> timing of functions i wrote. I am using gettimeofday to set
> two timeval structs and calculate the time between them.
> But the results depend heavily on the load, also i reckon that this
> is an innacurate timing.

You will get elapsed time, which is usually not the same as used cpu
time.

> Any ideas on timing a function, or a block of code? Maybe some kernel
> timers or something.

If you're timing/pofiling some user space functions, gprof should be
sufficient. If you want to profile kernel and module functions as
well, try oprofile at <http://oprofile.sourceforge.net/>. It is part
of the kernel since 2.5.43.

Regards, Olaf.
