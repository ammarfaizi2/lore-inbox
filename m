Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316836AbSE3Tu1>; Thu, 30 May 2002 15:50:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316851AbSE3Tu0>; Thu, 30 May 2002 15:50:26 -0400
Received: from loewe.cosy.sbg.ac.at ([141.201.2.12]:24531 "EHLO
	loewe.cosy.sbg.ac.at") by vger.kernel.org with ESMTP
	id <S316836AbSE3TuZ>; Thu, 30 May 2002 15:50:25 -0400
Date: Thu, 30 May 2002 21:50:26 +0200 (MET DST)
From: "Thomas 'Dent' Mirlacher" <dent@cosy.sbg.ac.at>
To: Linux-Kernel ML <linux-kernel@vger.kernel.org>
Subject: tasklets
In-Reply-To: <200205301948.VAA21563@loewe.cosy.sbg.ac.at>
Message-ID: <Pine.GSO.4.05.10205302149300.9848-100000@mausmaki.cosy.sbg.ac.at>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi list,

can someone explain the notes in tqueue.h?

it states:

 * - Bottom halfs are called in the reverse order that they were linked into
 *   the list.

but in queue_task it does a list_add_tail, which doesn't really explain the
above. also __run_task_queue does essentially a list_for_each, and no
list_for_each_prev.

so i cannot see any reasons why the tasks in the list shouldn't work like a
fifo.

can someone give me a hint what's wrong with my thinking? :)

thanks,
	tm

-- 
in some way i do, and in some way i don't.

