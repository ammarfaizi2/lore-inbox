Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131253AbRAXMcP>; Wed, 24 Jan 2001 07:32:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131786AbRAXMcG>; Wed, 24 Jan 2001 07:32:06 -0500
Received: from hermes.mixx.net ([212.84.196.2]:29195 "HELO hermes.mixx.net")
	by vger.kernel.org with SMTP id <S131253AbRAXMbu>;
	Wed, 24 Jan 2001 07:31:50 -0500
Message-ID: <3A6ECA9A.AD9200E7@innominate.de>
Date: Wed, 24 Jan 2001 13:29:14 +0100
From: Daniel Phillips <phillips@innominate.de>
Organization: innominate
X-Mailer: Mozilla 4.72 [de] (X11; U; Linux 2.4.0-test10 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Joe deBlaquiere <jadb@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: more on scheduler benchmarks
In-Reply-To: <20010122101738.B7427@w-mikek.des.sequent.com> <3A6CEB02.3050906@redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Joe deBlaquiere wrote:
> 
> Maybe I've been off in the hardware lab for too long, but how about
> 
> 1. using ioperm to give access to the parallel port.
> 2. have your program write a byte (thread id % 256 ?) constantly to the
> port during it's other activity
> 3. capture the results from another computer with an ecp port
> 
> This way you don't run the risk of altering the scheduler behavior with
> your logging procedure.

It's a technique I've used in debugging realtime systems.  It works
great, but bear in mind that the out to the parallel port costs an awful
lot of cycles.  You *will* alter the behaviour of the scheduler.

--
Daniel
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
