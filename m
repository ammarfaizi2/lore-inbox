Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265637AbTBPCeW>; Sat, 15 Feb 2003 21:34:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265643AbTBPCeW>; Sat, 15 Feb 2003 21:34:22 -0500
Received: from holomorphy.com ([66.224.33.161]:20104 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S265637AbTBPCeW>;
	Sat, 15 Feb 2003 21:34:22 -0500
Date: Sat, 15 Feb 2003 18:43:17 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: Tim Schmielau <tim@physik3.uni-rostock.de>,
       lkml <linux-kernel@vger.kernel.org>, "Randy.Dunlap" <rddunlap@osdl.org>,
       Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Subject: Re: [PATCH] make jiffies wrap 5 min after boot
Message-ID: <20030216024317.GM29983@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Anton Blanchard <anton@samba.org>,
	Tim Schmielau <tim@physik3.uni-rostock.de>,
	lkml <linux-kernel@vger.kernel.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>,
	Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
References: <Pine.LNX.4.33L2.0302040935230.6174-100000@dragon.pdx.osdl.net> <Pine.LNX.4.33.0302160232120.7975-100000@gans.physik3.uni-rostock.de> <20030216020808.GF9833@krispykreme>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030216020808.GF9833@krispykreme>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, someone else wrote:
>> +#define INITIAL_JIFFIES (0xffffffffUL & (unsigned long)(-300*HZ))

On Sun, Feb 16, 2003 at 01:08:08PM +1100, Anton Blanchard wrote:
> In order to make 64bit arches wrap too, you might want to use -1UL here.
> Not that jiffies should wrap on a 64bit machine...

Can I get a vote for ~0UL instead of -1UL?

-- wli
