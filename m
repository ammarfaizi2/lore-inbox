Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264910AbTL1BWj (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 27 Dec 2003 20:22:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264905AbTL1BWj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 27 Dec 2003 20:22:39 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:62636 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S264910AbTL1BWi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 27 Dec 2003 20:22:38 -0500
Date: Sun, 28 Dec 2003 02:21:55 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: Andrew Morton <akpm@osdl.org>
Cc: dtor_core@ameritech.net, gcs@lsc.hu, linux-kernel@vger.kernel.org,
       petero2@telia.com, john stultz <johnstul@us.ibm.com>
Subject: Re: Synaptics problems in -mm1
Message-ID: <20031228012155.GA13923@louise.pinerecords.com>
References: <20031224095921.GA8147@lsc.hu> <200312271228.59192.dtor_core@ameritech.net> <20031227181120.GC10491@louise.pinerecords.com> <200312271323.22252.dtor_core@ameritech.net> <20031227183704.GD10491@louise.pinerecords.com> <20031227160053.11bcd12d.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031227160053.11bcd12d.akpm@osdl.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-27 2003, Sat, 16:00 -0800
Andrew Morton <akpm@osdl.org> wrote:

> Tomas Szepe <szepe@pinerecords.com> wrote:
> >
> >  > I think it ACPI PM timer if you have it activated - I am having problems
> >  > with it myself but didn't have time to look closer.  Could you try booting
> >  > with clock=tsc or clock=pit and see if it fixes the touchpad.
> > 
> >  clock=tsc		appears to fix the problem.
> >  clock=pit		no change.
> 
> So we've established that it is an interaction between the input code, the
> ACPI PM time code and cpufreq, yes?  That's a bit of a witches brew.

Ok, I have verified this witch is not _that_ cunning.  cpufreq actually
seems to be innocent, I am able to reproduce the problem with CONFIG_CPU_FREQ
unset.

-- 
Tomas Szepe <szepe@pinerecords.com>
