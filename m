Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265140AbSKJUKd>; Sun, 10 Nov 2002 15:10:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265150AbSKJUKd>; Sun, 10 Nov 2002 15:10:33 -0500
Received: from gate.in-addr.de ([212.8.193.158]:28691 "HELO mx.in-addr.de")
	by vger.kernel.org with SMTP id <S265140AbSKJUKc>;
	Sun, 10 Nov 2002 15:10:32 -0500
Date: Sun, 10 Nov 2002 21:16:46 +0100
From: Lars Marowsky-Bree <lmb@suse.de>
To: linux-kernel@vger.kernel.org
Subject: Re: Voyager subarchitecture for 2.5.46
Message-ID: <20021110201645.GI835@marowsky-bree.de>
References: <20021110191822.GA1237@elf.ucw.cz> <Pine.LNX.4.44.0211101127460.9581-100000@home.transmeta.com> <20021110194204.GF3068@atrey.karlin.mff.cuni.cz> <6usmy99osn.fsf@zork.zork.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <6usmy99osn.fsf@zork.zork.net>
User-Agent: Mutt/1.4i
X-Ctuhulu: HASTUR
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-11-10T20:02:00,
   Sean Neakums <sneakums@zork.net> said:

> > I believe you need it system-global. If task A tells task B "its
> > 10:30:00" and than task B does gettimeofday and gets "10:29:59", it
> > will be confused for sure.
> Hence the requirement that it be monotonically increasing.

Processes expecting time to increase strictly monotonically across process
boundaries will enjoy life in cluster settings or when the admin adjusts the
time.

In short, those programs are already broken.

Of course, physically that should be true, Star Trek or not ;), but it is a
really hard promise to keep across multiple nodes (think Mosix, CC/NC-NUMA or
even real clusters which distributed processing).

Serializing all gettimeofday() calls via a single counter at least is a rather
bad idea.


Sincerely,
    Lars Marowsky-Brée <lmb@suse.de>

-- 
Principal Squirrel 
SuSE Labs - Research & Development, SuSE Linux AG
  
"If anything can go wrong, it will." "Chance favors the prepared (mind)."
  -- Capt. Edward A. Murphy            -- Louis Pasteur
