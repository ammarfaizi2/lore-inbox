Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261405AbUDISYX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Apr 2004 14:24:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261582AbUDISYX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Apr 2004 14:24:23 -0400
Received: from adsl-67-65-232-1.dsl.lgvwtx.swbell.net ([67.65.232.1]:13963
	"HELO rooker.dyndns.org") by vger.kernel.org with SMTP
	id S261405AbUDISYS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Apr 2004 14:24:18 -0400
Message-ID: <000901c41e5f$b7288930$6600a8c0@pixl>
From: "Peter Maas" <peter@goquest.com>
To: <linux-kernel@vger.kernel.org>
Subject: Re: 2.6.5-mm3
Date: Fri, 9 Apr 2004 13:23:10 -0500
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I had posted under the topic SMP + EXT3 + AACRAID yesterday about lockups
occuring when I ran a 'dbench 32' on a dual pentium 4 with HT, on an Adaptec
2120S (aacraid) with an ext3 filesystem. So far with my testing on mm3 I
have not had a lockup. 'dbench 32' also is also much faster, from about
60MB/s on 2.6.5 (the few times it did not lock) to 108MB/s on 2.6.5-mm3.

I have SMT scheduler support enabled along with 4K stacks.

2.6.5-mm3+SMP+AACRAID+EXT3= completes
2.6.5+SMP+AACRAID+EXT3= lockup
2.6.5+SMP+AACRAID+EXT2= completes

2.4.21-9REL+SMP+AACRAID+EXT3= lockup
2.4.21-9REL+SMP+AACRAID+EXT2= completes
2.4.21-9REL+SingleProc+AACRAID+EXT3= lockup
2.4.21-9REL+SingleProc+AACRAID+EXT2=completes

2.6.5-mm3 is working for me!

