Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261981AbSJHLP4>; Tue, 8 Oct 2002 07:15:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261983AbSJHLP4>; Tue, 8 Oct 2002 07:15:56 -0400
Received: from dukas.upc.es ([147.83.2.62]:2488 "EHLO dukas.upc.es")
	by vger.kernel.org with ESMTP id <S261981AbSJHLPz>;
	Tue, 8 Oct 2002 07:15:55 -0400
Message-ID: <3DA2C080.3B3A@mat.upc.es>
Date: Tue, 08 Oct 2002 13:24:48 +0200
From: Francesc Oller <francesc@mat.upc.es>
Reply-To: francesc@mat.upc.es
Organization: UPC
X-Mailer: Mozilla 3.01 (Win95; I)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: futex API docs?
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all!

I've been trying to understand how futexes work looking at the last
dev. kernel. I've not found any docs. Are there any?

Basically:

P (fast P sem op):

  if (atomic_decrement(sem)<0)
    sys_futex(..,FUTEX_WAIT,....);

V (fast V sem op):

  if (atomic_increment(sem)<=0)
    sys_futex(..,FUTEX_WAKE,....);

Futexes need be counting semaphores since there could be WAKEs in
the middle of atomic_decrements and WAITs (not atomic) but I do
not see this in the code. I can't find the kernel counter in the
sources

Can anybody help me?

Many thanks in advance

Please CC to my e-mail since I'm not subscribed.

Cheers

Francesc
