Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284917AbRLMTbb>; Thu, 13 Dec 2001 14:31:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284967AbRLMTbV>; Thu, 13 Dec 2001 14:31:21 -0500
Received: from cs182072.pp.htv.fi ([213.243.182.72]:21632 "EHLO
	cs182072.pp.htv.fi") by vger.kernel.org with ESMTP
	id <S284917AbRLMTbI>; Thu, 13 Dec 2001 14:31:08 -0500
Message-ID: <3C1901BC.C5E7936C@welho.com>
Date: Thu, 13 Dec 2001 21:30:04 +0200
From: Mika Liljeberg <Mika.Liljeberg@welho.com>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.16 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: kuznet@ms2.inr.ac.ru
CC: davem@redhat.com, linux-kernel@vger.kernel.org, mika.liljeberg@nokia.com
Subject: Re: TCP LAST-ACK state broken in 2.4.17-pre2
In-Reply-To: <200112131759.UAA01376@ms2.inr.ac.ru>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

kuznet@ms2.inr.ac.ru wrote:
> This is not related to that problem.

I believe you. Nevertheless, it appears to be a problem that happens in
the LAST-ACK state.

> Please, make cat /proc/net/tcp at this point.

I'll do that if it happens again.

> To be honest I do not believe
> that tcpdump finishes _here_. When will retransmit timer expire? Taking
> into account that 10.0.5.3 has rto of 14 seconds (distance between retransmits
> of its FIN :-)), linux can have even more. In the case of such bad connection
> closing fin-wait-2 via abort is pretty normal.

I'm afraid it did end there. :( The data transfer was unidirectional
from the remote towards the Linux machine. During the SYN exchange the
RTT is less than one second. The rest is queuing delay. So Linux should
have a fairly low RTO. There were no FIN retransmissions, I'm sorry to
say.

> Alexey

Cheers,

	MikaL
