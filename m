Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129826AbRA3QcL>; Tue, 30 Jan 2001 11:32:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129982AbRA3QcA>; Tue, 30 Jan 2001 11:32:00 -0500
Received: from renoir.op.net ([207.29.195.4]:25607 "EHLO renoir.op.net")
	by vger.kernel.org with ESMTP id <S129826AbRA3Qbp>;
	Tue, 30 Jan 2001 11:31:45 -0500
Message-Id: <200101301630.LAA15247@renoir.op.net>
To: Joe deBlaquiere <jadb@redhat.com>
cc: David Woodhouse <dwmw2@infradead.org>, yodaiken@fsmlabs.com,
        Andrew Morton <andrewm@uow.edu.au>, Nigel Gamble <nigel@nrg.org>,
        linux-kernel@vger.kernel.org,
        linux-audio-dev@ginette.musique.umontreal.ca
Subject: Re: [linux-audio-dev] low-latency scheduling patch for 2.4.0 
In-Reply-To: Your message of "Tue, 30 Jan 2001 09:44:21 CST."
             <3A76E155.2030905@redhat.com> 
Date: Tue, 30 Jan 2001 11:29:32 -0500
From: Paul Davis <pbd@Op.Net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>The locical answer is run with HZ=10000 so you get 100us intervals, 
>right ;o). On systems with multiple hardware timers you could kick off a 
>single event at 200us, couldn't you? I've done that before with the 
>extra timer assigned exclusively to a resource. It's not a giant time 
>slice, but at least you feel like you're allowing something to happen, 
>right?

no, thats not the logical answer at all. the logical answer is
something like the excellent but neglected UTIME patch that
continually reprograms the system timer so that you can get precise
event scheduling without the insane overhead of HZ=10000.

--p
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
