Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262169AbTHYTdw (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Aug 2003 15:33:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262171AbTHYTdw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Aug 2003 15:33:52 -0400
Received: from fw.osdl.org ([65.172.181.6]:17112 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262169AbTHYTdv convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Aug 2003 15:33:51 -0400
Date: Mon, 25 Aug 2003 12:29:06 -0700
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: herbert@13thfloor.at
Cc: linux-kernel@vger.kernel.org
Subject: Re: [OT] sizeof C types ...
Message-Id: <20030825122906.79d755d4.rddunlap@osdl.org>
In-Reply-To: <20030825191339.GA28525@www.13thfloor.at>
References: <20030825191339.GA28525@www.13thfloor.at>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 25 Aug 2003 21:13:39 +0200 Herbert Pötzl <herbert@13thfloor.at> wrote:

| 
| Hi Everyone!
| 
| this time not sooo off topic but ...
| 
| anyway, ist there some kind of overview how
| large the basic C types are on the different
| architectures Linux runs on?
| 
| char, short, int, long, long int, long long, ...

>From gcc mailing list today: <quote>

All GCC targets (except perhaps some specialized targets for certain DSPs
and microcontrollers) support 64-bit integers.

Almost all GCC targets are either "ILP32" or "LP64".

For ILP32:
	short is 16 bits
	int, long, pointers are 32 bits
	"long long" is 64 bits

For LP64:
	short is 16 bits
	int is 32 bits
	long, pointers, and "long long" are 64 bits

None of this requires a specific version, as all these types have been
around for a long time.
</quote>

Also see Ch. 10 of the LDD book:
  http://www.xml.com/ldd/chapter/book/ch10.html

--
~Randy   [mantra:  Always include kernel version.]
"Everything is relative."
