Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312560AbSEXWxG>; Fri, 24 May 2002 18:53:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312600AbSEXWxF>; Fri, 24 May 2002 18:53:05 -0400
Received: from sex.inr.ac.ru ([193.233.7.165]:53907 "HELO sex.inr.ac.ru")
	by vger.kernel.org with SMTP id <S312560AbSEXWxE>;
	Fri, 24 May 2002 18:53:04 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200205242251.CAA15448@sex.inr.ac.ru>
Subject: Re: Few comments on TCP implementation
To: spy9599@yahoo.COM (Yogesh Swami)
Date: Sat, 25 May 2002 02:51:58 +0400 (MSD)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20020524213011.50807.qmail@web14808.mail.yahoo.com> from "Yogesh Swami" at May 25, 2 01:45:01 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> a) The calculation of ssthresh is wrong, it should be
> max( 1/2*packets_in_flight, 2) (see RFC 2581)

The value called In_Flight in the rfc is called snd_cwnd here.
Look f.e. into rfc2861 for further details.

> b) After a retransmission timeout, all the SACK
> information SHOULD be forgotten (see RFC 2018).

If you think a little you will understand that this does not matter.
Delayed SACK invalidation is just much more stable wrt various pathologies.


> c) A few new RFCs have come recently (e.g., 3042
> called limited retransmit) that boost the performance

It is implemented. :-)

Alexey
