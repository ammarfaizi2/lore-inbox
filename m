Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281309AbRKTTw0>; Tue, 20 Nov 2001 14:52:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281308AbRKTTwQ>; Tue, 20 Nov 2001 14:52:16 -0500
Received: from zeus.kernel.org ([204.152.189.113]:22514 "EHLO zeus.kernel.org")
	by vger.kernel.org with ESMTP id <S281304AbRKTTwM>;
	Tue, 20 Nov 2001 14:52:12 -0500
From: kuznet@ms2.inr.ac.ru
Message-Id: <200111201945.WAA03637@ms2.inr.ac.ru>
Subject: Re: more tcpdumpinfo for nfs3 problem: aix-server --- linux 2.4.15pre5 client
To: trond.myklebust@fys.uio.no
Date: Tue, 20 Nov 2001 22:45:21 +0300 (MSK)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <15354.45419.978323.438540@charged.uio.no> from "Trond Myklebust" at Nov 20, 1 08:39:23 pm
X-Mailer: ELM [version 2.4 PL24]
MIME-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> Deadlock - in exactly the same way as with the xprt code...

Soooory! Delete from the picture all except for containing QDIO:


(Call QDIO bottom half code)
spin_lock(&QDIO_lock);
                                                 <QDIO hard interrupt>
                                                       ->spin_lock(&QDIO_lock)
                                                              (spins...)

with the same result. No help of nfs is required. :-)

So, you have drawn wrong picture.


Alexey
