Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267101AbTA0CKx>; Sun, 26 Jan 2003 21:10:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267102AbTA0CKx>; Sun, 26 Jan 2003 21:10:53 -0500
Received: from hughes-fe01.direcway.com ([66.82.20.91]:41165 "EHLO
	hughes-fe01.direcway.com") by vger.kernel.org with ESMTP
	id <S267101AbTA0CKw>; Sun, 26 Jan 2003 21:10:52 -0500
Subject: Re: Dell Latitude CPi keyboard problems since 2.5.42
From: Tom Sightler <ttsig@tuxyturvy.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Cc: vojtech@suse.cz
In-Reply-To: <15924.30711.312462.624886@charged.uio.no>
References: <20030124184951.A23608@blackjesus.async.com.br>
	<15922.2657.267195.355147@notabene.cse.unsw.edu.au>
	<20030126140200.A25438@blackjesus.async.com.br>
	<shs8yx7lgyt.fsf@charged.uio.no>
	<20030126204711.A25997@blackjesus.async.com.br>
	<15924.26856.298449.357899@charged.uio.no>
	<20030126215650.A26147@blackjesus.async.com.br> 
	<15924.30711.312462.624886@charged.uio.no>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 26 Jan 2003 21:19:52 -0500
Message-Id: <1043634004.1588.65.camel@iso-2146-l1.zeusinc.com>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmm, interesting. Can you try disabling some of the probes for
> extended keyboards in atkbd.c to see if some of them could confuse
> your keyboard so that the BIOS doesn't like it after boot? Also you
> may want to kill the keyboard reset on reboot ... (atkbd_cleanup) ...

I've been following this because my Dell Latitude C810 has the
"keyboard/mouse doesn't work after reboot" with all of the recent 2.5.x
kernel that I have tried.

When I saw the suggestion above to try removing the keyboard reset I
thought that was just too easy to pass up giving it a try.  Sure enough,
removing just the one line that preforms the keyboard reset from
atkbd_cleanup solves the problem for me.  Now I guess it's time to try
to determine why, and what the real fix should likely be.

Just thought it might be valuable to have another report about the
problem.

Later,
Tom


