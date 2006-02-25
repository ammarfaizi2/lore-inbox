Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932094AbWBYWXz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932094AbWBYWXz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 25 Feb 2006 17:23:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932096AbWBYWXz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 25 Feb 2006 17:23:55 -0500
Received: from smtp110.sbc.mail.re2.yahoo.com ([68.142.229.95]:44205 "HELO
	smtp110.sbc.mail.re2.yahoo.com") by vger.kernel.org with SMTP
	id S932094AbWBYWXz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 25 Feb 2006 17:23:55 -0500
From: Dmitry Torokhov <dtor_core@ameritech.net>
To: Adrian Bunk <bunk@stusta.de>
Subject: Re: [2.6 patch] make INPUT a bool
Date: Sat, 25 Feb 2006 17:23:52 -0500
User-Agent: KMail/1.9.1
Cc: Jan Engelhardt <jengelh@linux01.gwdg.de>,
       Geert Uytterhoeven <geert@linux-m68k.org>,
       Samuel Masham <samuel.masham@gmail.com>,
       Linux Kernel Development <linux-kernel@vger.kernel.org>,
       linux-input@atrey.karlin.mff.cuni.cz, Andrew Morton <akpm@osdl.org>
References: <20060220132832.GF4971@stusta.de> <Pine.LNX.4.61.0602252300200.7535@yvahk01.tjqt.qr> <20060225220737.GE3674@stusta.de>
In-Reply-To: <20060225220737.GE3674@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200602251723.53349.dtor_core@ameritech.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 25 February 2006 17:07, Adrian Bunk wrote:
> On Sat, Feb 25, 2006 at 11:01:03PM +0100, Jan Engelhardt wrote:
> > >> >> You said that INPUT was not a driver, right. But without it, a keyboard 
> > >> >> won't work, will it?
> > >> >
> > >> >Yes, you do need INPUT for a keyboard.
> > >> >No, INPUT alone does not support any hardware - that's the job of the 
> > >> >drivers depending on INPUT.
> > >> >No, I don't understand what your question wants to achieve.
> > >> 
> > >> Let's look at another subsystem:
> > >> "Yes, you do need SND for a soundcard."
> > >> "No, SND alone does not support any hardware - that's the job of the drivers
> > >> depending on SND."
> > >> Should SND also be made a bool like INPUT?
> > >
> > >No, SND=m is also possible in the EMBEDDED=n case.
> > >
> > This example was to show that INPUT should not be y-only. Except if you plan to
> > make SND y-only too.
> 
> 
> Please try to understand the following:
> - INPUT=m is already only available if EMBEDDED=y

Adrian,

There are requests to move it out of EMBEDDED because sometimes you
just  don't need input layer at all. Dave Jones mentioned that he
feels silly enabling EMBEDDED on iSeries... I am thinking about
changing it to "EMBEDDED || !X86_PC" to safe-guard the most common
platform from accidenially disabling it.

I am still not convinced whether INPUT=m makes sence, especially if
we make ACPI use input layer... Jan's example about input device with
hot-pluggable keyboard is a bit of a stretch. 

-- 
Dmitry
