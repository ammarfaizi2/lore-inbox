Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267441AbSLEVEm>; Thu, 5 Dec 2002 16:04:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267436AbSLEVES>; Thu, 5 Dec 2002 16:04:18 -0500
Received: from pizda.ninka.net ([216.101.162.242]:64990 "EHLO pizda.ninka.net")
	by vger.kernel.org with ESMTP id <S267442AbSLEVBg>;
	Thu, 5 Dec 2002 16:01:36 -0500
Date: Thu, 05 Dec 2002 13:06:14 -0800 (PST)
Message-Id: <20021205.130614.99253893.davem@redhat.com>
To: pavel@suse.cz
Cc: ak@suse.de, linux-kernel@vger.kernel.org, hubicka@atrey.karlin.mff.cuni.cz
Subject: Re: [PATCH] Start of compat32.h (again)
From: "David S. Miller" <davem@redhat.com>
In-Reply-To: <20021204111947.GB309@elf.ucw.cz>
References: <20021202090756.GA26034@wotan.suse.de>
	<20021202.021629.93360250.davem@redhat.com>
	<20021204111947.GB309@elf.ucw.cz>
X-FalunGong: Information control.
X-Mailer: Mew version 2.1 on Emacs 21.1 / Mule 5.0 (SAKAKI)
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

   From: Pavel Machek <pavel@suse.cz>
   Date: Wed, 4 Dec 2002 12:19:47 +0100

   Actually, it tends to nullify the bloat cost and then make it few
   percent faster... For most of spec2000 modulo two or three cache-bound
   tests that are 50% slower :-(.

How about some test where relocations come into play?
spec2000 is a bad example, it's just crunch code.

Most systems spend their time running quick small executables over and
over, and in such cases relocation overhead shows up very strongly.
This is why I asked for fork, exec et al. latency figures for 32-bit
vs 64-bit on x86_64 but I've been informed in private email that
nobody can send me numbers due to NDAs.

I still think making the simple programs like ls, cat, bash et
al. 64-bit in a dist is a bad idea.
