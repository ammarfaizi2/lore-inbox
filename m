Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317194AbSHTTMQ>; Tue, 20 Aug 2002 15:12:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317257AbSHTTMQ>; Tue, 20 Aug 2002 15:12:16 -0400
Received: from krynn.axis.se ([193.13.178.10]:42917 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S317194AbSHTTMP>;
	Tue, 20 Aug 2002 15:12:15 -0400
From: johan.adolfsson@axis.com
Message-ID: <05da01c2487e$b2321120$b9b270d5@homeip.net>
Reply-To: <johan.adolfsson@axis.com>
To: "Oliver Xymoron" <oxymoron@waste.org>, <johan.adolfsson@axis.com>
Cc: <linux-kernel@vger.kernel.org>
References: <01a301c2482c$51a00e40$b9b270d5@homeip.net> <20020820140346.GC19225@waste.org> <03f401c24867$2d5260c0$b9b270d5@homeip.net> <20020820170601.GD19225@waste.org> <050b01c2486f$c6701880$b9b270d5@homeip.net> <20020820180257.GF19225@waste.org>
Subject: Re: [RFC] Improved add_timer_randomness for __CRIS__ (instead of rdtsc())
Date: Tue, 20 Aug 2002 21:20:50 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > Perhaps something like:
> > > 
> > > speed=get_timestamp_khz;
> > > lowbits=get_hires_timestamp();
> > 
> > But isn't the "num ^= high;" a way to improve the randomness
> > and the high value doesn't really need to be linear to the time?
> 
> No, the high order bits aren't very interesting at all. Don't worry
> about that bit, it's just cuteness.

ok:-)
But if the the timestamp doesn't have to be entirely accurate
the name should perhaps reflect that, since at least on the cris arch
you can save some cycles if you can accept a glitch now and then.
We want to be able to separate it from similar functions used
for high-res timers etc. which need a more accurate function.

/Johan


