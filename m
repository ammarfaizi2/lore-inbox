Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281925AbRKURGu>; Wed, 21 Nov 2001 12:06:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281917AbRKURGb>; Wed, 21 Nov 2001 12:06:31 -0500
Received: from minus.inr.ac.ru ([193.233.7.97]:5385 "HELO ms2.inr.ac.ru")
	by vger.kernel.org with SMTP id <S281904AbRKURGM>;
	Wed, 21 Nov 2001 12:06:12 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200111211705.UAA17899@ms2.inr.ac.ru>
Subject: Re: more tcpdumpinfo for nfs3 problem: aix-server --- linux 2.4.15pre5 client
To: trond.myklebust@fys.uio.no (Trond Myklebust)
Date: Wed, 21 Nov 2001 20:05:56 +0300 (MSK)
Cc: davem@redhat.com, linux-kernel@vger.kernel.org
In-Reply-To: <E166UHi-0005dA-00@charged.uio.no> from "Trond Myklebust" at Nov 21, 1 11:07:14 am
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

>     Either we must demand that CPU 2 uses irq-safe spinlocks in order to 
> protect against sk->write_space(),

Never. :-)

>				 or we must demand that CPU 1 should drop 
> 'lock1' before being allowed to call dev_kfree_skb_any().

Yes, alas.

Being pretty evident after seen once, this rule was _not_ evident for me
until yesterday. Actually, this is very sad observation, because core
has no way to detect this is a generic way...

Alexey
