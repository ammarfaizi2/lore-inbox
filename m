Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264901AbTL1Apw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 19:45:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264905AbTL1Apw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 19:45:52 -0500
Received: from smtp813.mail.sc5.yahoo.com ([66.163.170.83]:61368 "HELO
	smtp813.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264901AbTL1Apv convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 19:45:51 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Andrew Morton <akpm@osdl.org>, Tomas Szepe <szepe@pinerecords.com>
Subject: Re: Synaptics problems in -mm1
Date: Sat, 27 Dec 2003 19:45:44 -0500
User-Agent: KMail/1.5.4
Cc: gcs@lsc.hu, linux-kernel@vger.kernel.org, petero2@telia.com,
       john stultz <johnstul@us.ibm.com>
References: <20031224095921.GA8147@lsc.hu> <20031227183704.GD10491@louise.pinerecords.com> <20031227160053.11bcd12d.akpm@osdl.org>
In-Reply-To: <20031227160053.11bcd12d.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Message-Id: <200312271945.44559.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 December 2003 07:00 pm, Andrew Morton wrote:
> Tomas Szepe <szepe@pinerecords.com> wrote:
> >  > I think it ACPI PM timer if you have it activated - I am having
> >  > problems with it myself but didn't have time to look closer. 
> >  > Could you try booting with clock=tsc or clock=pit and see if it
> >  > fixes the touchpad.
> >
> >  clock=tsc		appears to fix the problem.
> >  clock=pit		no change.
>
> So we've established that it is an interaction between the input code,
> the ACPI PM time code and cpufreq, yes?  That's a bit of a witches
> brew.
>
> Does anyone know what aspect of the ACPI PM timer behaviour could cause
> this?

>From my limited experience ACPI PM timer just gets the time wrong.
At least psmouse times out much quicker than 4 seconds when resetting
the touchpad which causes many problems.

Looking at the PM timer was on my TODO list ever since it was included
in -mm... I tried installing cpufreq handler to do the same adjustments
for loops_per_jiffy as in timer_pit but I was still getting pretty much
the same result - time goes too quickly.

Dmitry

