Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264594AbTL0VAg (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 16:00:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264595AbTL0VAf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 16:00:35 -0500
Received: from smtp801.mail.sc5.yahoo.com ([66.163.168.180]:32623 "HELO
	smtp801.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264594AbTL0VAa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 16:00:30 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Tomas Szepe <szepe@pinerecords.com>
Subject: Re: Synaptics problems in -mm1
Date: Sat, 27 Dec 2003 16:00:26 -0500
User-Agent: KMail/1.5.4
Cc: Andrew Morton <akpm@osdl.org>, GCS <gcs@lsc.hu>,
       linux-kernel@vger.kernel.org, Peter Osterlund <petero2@telia.com>
References: <20031224095921.GA8147@lsc.hu> <200312271345.41679.dtor_core@ameritech.net> <20031227190138.GE10491@louise.pinerecords.com>
In-Reply-To: <20031227190138.GE10491@louise.pinerecords.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200312271600.26948.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 27 December 2003 02:01 pm, Tomas Szepe wrote:
> > > Dmitry Torokhov <dtor_core@ameritech.net> wrote:
> > Ok, good. So it is the timer funkiness. I would suggest not using
> > ACPI PM timer for now then. And yes, timer_pit does not have cpufreq
> > hooks either so it probably not the best timesource with cpufreq
> > either, so stick with TSC.
>
> Stupid me, I absolutely forgot that I had enabled CONFIG_X86_PM_TIMER
> (nonexistent in 2.6.0 stock) which indeed seems to be the culprit.
> Please accept my apologies.  -mm1 with that config option unset won't
> lose the stick, either.
>
> Thanks!

Great! Thank you for letting me know.

Dmitry
