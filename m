Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265612AbTBPB7V>; Sat, 15 Feb 2003 20:59:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265637AbTBPB7V>; Sat, 15 Feb 2003 20:59:21 -0500
Received: from dp.samba.org ([66.70.73.150]:25061 "EHLO lists.samba.org")
	by vger.kernel.org with ESMTP id <S265612AbTBPB7U>;
	Sat, 15 Feb 2003 20:59:20 -0500
Date: Sun, 16 Feb 2003 13:08:08 +1100
From: Anton Blanchard <anton@samba.org>
To: Tim Schmielau <tim@physik3.uni-rostock.de>
Cc: lkml <linux-kernel@vger.kernel.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [PATCH] make jiffies wrap 5 min after boot
Message-ID: <20030216020808.GF9833@krispykreme>
References: <Pine.LNX.4.33L2.0302040935230.6174-100000@dragon.pdx.osdl.net> <Pine.LNX.4.33.0302160232120.7975-100000@gans.physik3.uni-rostock.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0302160232120.7975-100000@gans.physik3.uni-rostock.de>
User-Agent: Mutt/1.5.3i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Hi,

> +#define INITIAL_JIFFIES (0xffffffffUL & (unsigned long)(-300*HZ))

In order to make 64bit arches wrap too, you might want to use -1UL here.
Not that jiffies should wrap on a 64bit machine...

Anton
