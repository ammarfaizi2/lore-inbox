Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263328AbTEOApe (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 20:45:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263338AbTEOApe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 20:45:34 -0400
Received: from 12-234-34-139.client.attbi.com ([12.234.34.139]:62709 "EHLO
	heavens.murgatroid.com") by vger.kernel.org with ESMTP
	id S263328AbTEOApa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 20:45:30 -0400
From: "Christopher Hoover" <ch@murgatroid.com>
To: "'Linus Torvalds'" <torvalds@transmeta.com>,
       "'Ulrich Drepper'" <drepper@redhat.com>
Cc: "'Dave Jones'" <davej@codemonkey.org.uk>, <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] 2.5.68 FUTEX support should be optional
Date: Wed, 14 May 2003 17:58:11 -0700
Organization: Murgatroid.Com
Message-ID: <002201c31a7d$0f3f32a0$175e040f@bergamot>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.2627
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
In-Reply-To: <Pine.LNX.4.44.0305141246180.27329-100000@home.transmeta.com>
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> I don't see the point in dropping futexes except
> perhaps in a very controlled embedded environment,
> but if that is the case,  then a PC config 
> should just force it to "y" and not even ask the user. 

We could do this (et al) under CONFIG_TINY, if you would prefer.


> We absolutely do NOT want the situation where
> a program will not work just because the user forgot
> some config option that mostly isn't needed.

This a specious argument.  There are many ways one can configure a
kernel that will make it fail to boot or run user space properly.
There's no getting around knowing what it is your configuring in and
out.

Note that I set the default to Y.  I also agree that I could have been
more verbose in the help string.

> And futexes _are_ going to be needed. Any sane high-performance
threading 
> implementation _will_ use them. No ifs, buts or maybe's.

All big machines, sure.  All small machines, it depends.  All the (user)
world is not glibc.

-ch

