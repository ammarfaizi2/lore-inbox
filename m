Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277013AbRJQSAc>; Wed, 17 Oct 2001 14:00:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277022AbRJQSAW>; Wed, 17 Oct 2001 14:00:22 -0400
Received: from minus.inr.ac.ru ([193.233.7.97]:2067 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S277013AbRJQSAI>;
	Wed, 17 Oct 2001 14:00:08 -0400
From: kuznet@ms2.inr.ac.ru
Message-Id: <200110171758.VAA22159@ms2.inr.ac.ru>
Subject: Re: [NFS] NFSD over TCP: TCP broken?
To: kalele@veritas.COM (Shirish Kalele)
Date: Wed, 17 Oct 2001 21:58:37 +0400 (MSK DST)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <023a01c15708$a275d270$3291b40a@fserv2000.net> from "Shirish Kalele" at Oct 17, 1 04:45:00 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> where the interleaving gets in.

I do not think that you diagnosed the problem correctly.
nfsd used non blocking io and write to tcp is strictly atomic in this case.


>		 I'm not sure if TCP should be handling this
> or NFSD. From what little I know, TCP should serialize requests it gets and
> atomically write them out,

However, it does not and it should not. Like concurrent write()
to any other file, the result is unpredictably interleaved data.

Alexey
