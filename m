Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S285247AbRLSLFh>; Wed, 19 Dec 2001 06:05:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S285246AbRLSLF1>; Wed, 19 Dec 2001 06:05:27 -0500
Received: from hermine.idb.hist.no ([158.38.50.15]:8720 "HELO
	hermine.idb.hist.no") by vger.kernel.org with SMTP
	id <S285243AbRLSLFX>; Wed, 19 Dec 2001 06:05:23 -0500
Message-ID: <3C207473.E7AB9C6B@idb.hist.no>
Date: Wed, 19 Dec 2001 12:05:23 +0100
From: Helge Hafting <helgehaf@idb.hist.no>
X-Mailer: Mozilla 4.76 [no] (X11; U; Linux 2.5.1-pre10 i686)
X-Accept-Language: no, en
MIME-Version: 1.0
To: Doug Ledford <dledford@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: Scheduler ( was: Just a second ) ...
In-Reply-To: <Pine.LNX.4.33.0112181216341.1237-100000@admin> <Pine.LNX.4.33.0112180922500.2867-100000@penguin.transmeta.com> <20011218105459.X855@lynx.no> <3C1F8A9E.3050409@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doug Ledford wrote:

> Weel, evidently esd and artsd both do this (well, I assume esd does now, it
> didn't do this in the past).  Basically, they both transmit silence over the
> sound chip when nothing else is going on.  So even though you don't hear
> anything, the same sound output DMA is taking place.  

Uuurgh. :-(

> That avoids things
> like nasty pops when you start up the sound hardware for a beep and that

Yuk, bad hardware.  Pops when you start or stop writing?  You don't even
have to turn the volume off or something to get a pop?  Toss it.

> sort of thing.  It also maintains state where as dropping output entirely
> could result in things like module auto unloading and then reloading on the
> next beep, etc.  

Much better solved by having the device open, but not writing anything.
Open devices don't unload.

Helge Hafting
