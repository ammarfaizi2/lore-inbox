Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261711AbTDBGuO>; Wed, 2 Apr 2003 01:50:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261776AbTDBGuO>; Wed, 2 Apr 2003 01:50:14 -0500
Received: from mail4.bluewin.ch ([195.186.4.74]:1433 "EHLO mail4.bluewin.ch")
	by vger.kernel.org with ESMTP id <S261711AbTDBGuN>;
	Wed, 2 Apr 2003 01:50:13 -0500
Date: Wed, 2 Apr 2003 09:01:15 +0200
From: Roger Luethi <rl@hellgate.ch>
To: Brad Campbell <brad@seme.com.au>
Cc: linux-kernel@vger.kernel.org
Subject: Re: via-rhine problem on EPIAV-1Ghz 2.4.21-pre6
Message-ID: <20030402070115.GA2667@k3.hellgate.ch>
Mail-Followup-To: Brad Campbell <brad@seme.com.au>,
	linux-kernel@vger.kernel.org
References: <3E88FA24.7040406@seme.com.au> <20030401042734.GA21273@gtf.org> <3E89171A.8010506@seme.com.au> <20030401185258.GC3736@arthur.home> <3E8A6298.8060600@seme.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3E8A6298.8060600@seme.com.au>
User-Agent: Mutt/1.3.27i
X-Operating-System: Linux 2.5.65 on i686
X-GPG-Fingerprint: 92 F4 DC 20 57 46 7B 95  24 4E 9E E7 5A 54 DC 1B
X-GPG: 1024/80E744BD wwwkeys.ch.pgp.net
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 02 Apr 2003 12:10:00 +0800, Brad Campbell wrote:
> It solved the timeout propblems, I do get these however.
> 
> Not that they cause any hiccups in throughput.
> 
> eth0: Tx descriptor write-back race.
> eth0: Tx descriptor write-back race.
> eth0: Tx descriptor write-back race.
> eth0: Transmit error, Tx status 00008800.
> eth0: Transmitter underrun, Tx threshold now 40.
> eth0: Tx descriptor write-back race.
> eth0: Transmit error, Tx status 00008800.
> eth0: Transmitter underrun, Tx threshold now 60.
> eth0: Tx descriptor write-back race.

These are only informational messages on errors handled by the new code.
You won't see them at the default debug level. I made a few observations
leading me to believe that the number of those errors can be further
reduced, but that will take quite a bit of work.

And there is still a Tx pause of up to a couple of seconds (net watchdog
kicking in) on every GB or so, especially under high load.

Roger
