Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316586AbSFFAq3>; Wed, 5 Jun 2002 20:46:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316587AbSFFAq2>; Wed, 5 Jun 2002 20:46:28 -0400
Received: from blv-smtpout-01.boeing.com ([192.161.36.5]:11745 "EHLO
	blv-smtpout-01.boeing.com") by vger.kernel.org with ESMTP
	id <S316586AbSFFAq1>; Wed, 5 Jun 2002 20:46:27 -0400
From: Rick Bressler <bressler@mushroom.ca.boeing.com>
Message-Id: <200206060046.g560kJi04034@mushroom.ca.boeing.com>
Subject: Re: [PATCH] scheduler hints
To: linux-kernel@vger.kernel.org
Date: Wed, 5 Jun 2002 17:46:19 -0700 (PDT)
Cc: rml@tech9.net
In-Reply-To: <no.id> from "Robert Love" at Jun 04, 2002 08:53:54 AM
Reply-To: Rick Bressler <rickb@mushroom.ca.boeing.com>
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> So I went ahead and implemented scheduler hints on top of the O(1)
> scheduler. 

> Other hints could be "I am interactive" or "I am a batch (i.e. cpu hog)
> task" or "I am cache hot: try to keep me on this CPU". 

Sequent had an interesting hint they cooked up with Oracle. (Or maybe it
was the other way around.)  As I recall they called it 'twotask.'
Essentially Oracle clients processes spend a lot of time exchanging
information with its server process. It usually makes sense to bind them
to the same CPU in an SMP (and especially NUMA) machine.  (Probably
obvious to most of the folks on the group, but it is generally lots
better to essentially communicate through the cache and local memory
than across the NUMA bus.)

As I recall it made a significant difference in Oracle performance, and
would probably also translate to similar performance in many situations
where you had a client and server process doing lots of interaction in
an SMP environment.

Don't know if there is enough application to warrant it, but you asked.
:-)

-- 
+--------------------------------------------+ Rick Bressler
|Mushrooms and other fungi have several      | 
|important roles in nature.  They help things| 
|grow, they are a source of food, they       |
|decompose organic matter and they           | 
|infect, debilitate and kill organisms.      | Linux: Because a PC is a
+--------------------------------------------+ terrible thing to waste.
