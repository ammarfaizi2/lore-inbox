Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266647AbUBMAbW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Feb 2004 19:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266658AbUBMAbW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Feb 2004 19:31:22 -0500
Received: from mail019.syd.optusnet.com.au ([211.29.132.73]:52150 "EHLO
	mail019.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S266647AbUBMAbV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Feb 2004 19:31:21 -0500
From: Peter Chubb <peter@chubb.wattle.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16428.6596.169494.822812@wombat.chubb.wattle.id.au>
Date: Fri, 13 Feb 2004 11:26:44 +1100
To: root@chaos.analogic.com
Cc: wdebruij@dds.nl, sting sting <zstingx@hotmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: printk and long long 
In-Reply-To: <Pine.LNX.4.53.0402111021160.18798@chaos>
References: <Sea2-F7mFkwDjKqc3eQ0001c385@hotmail.com>
	<1076506513.402a2f9120fb8@webmail.dds.nl>
	<Pine.LNX.4.53.0402111021160.18798@chaos>
X-Mailer: VM 7.17 under 21.4 (patch 14) "Reasonable Discussion" XEmacs Lucid
Comments: Hyperbole mail buttons accepted, v04.18.
X-Face: GgFg(Z>fx((4\32hvXq<)|jndSniCH~~$D)Ka:P@e@JR1P%Vr}EwUdfwf-4j\rUs#JR{'h#
 !]])6%Jh~b$VA|ALhnpPiHu[-x~@<"@Iv&|%R)Fq[[,(&Z'O)Q)xCqe1\M[F8#9l8~}#u$S$Rm`S9%
 \'T@`:&8>Sb*c5d'=eDYI&GF`+t[LfDH="MP5rwOO]w>ALi7'=QJHz&y&C&TE_3j!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "Richard" == Richard B Johnson <root@chaos.analogic.com> writes:

Richard> On Wed, 11 Feb 2004 wdebruij@dds.nl wrote:
>> how about simply using a shift to output two regular longs, i.e.
>> 
>> printk("%ld%ld",loff_t >> (sizeof(long) * 8), loff_t <<
>> sizeof(long) * 8 >> sizeof(long) * 8);

Why bother?  printk already handles 64-bit types just fine.

Do
	loff_t x;
	printk("%lld\n" (long long)x)

You need the cast, because on 64-bit architectures, loff_t is long not
long long.

Peter c
