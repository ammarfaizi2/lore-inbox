Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S274286AbRITA4L>; Wed, 19 Sep 2001 20:56:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S274289AbRITA4B>; Wed, 19 Sep 2001 20:56:01 -0400
Received: from hall.mail.mindspring.net ([207.69.200.60]:23595 "EHLO
	hall.mail.mindspring.net") by vger.kernel.org with ESMTP
	id <S274286AbRITAzu>; Wed, 19 Sep 2001 20:55:50 -0400
Subject: Re: Feedback on preemptible kernel patch xfs
From: Robert Love <rml@tech9.net>
To: Gerold Jury <geroldj@grips.com>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3BA94B2E.99FABD43@grips.com>
In-Reply-To: <1000581501.32705.46.camel@phantasy> 
	<3BA72A80.6020706@grips.com> <1000853560.19365.13.camel@phantasy> 
	<3BA94B2E.99FABD43@grips.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Evolution-Format: text/plain
X-Mailer: Evolution/0.13.99+cvs.2001.09.19.07.08 (Preview Release)
Date: 19 Sep 2001 20:56:46 -0400
Message-Id: <1000947409.4348.58.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2001-09-19 at 21:49, Gerold Jury wrote:
> First the good news.
> Even my most ugly ideas where not able to crash your preemtible
> 2.4.10-pre10-xfs

Good to hear.

> But, to be sure i repeated everything, neither latencytest-0.42 nor
> my own tests could find a difference with or without the preemptible
> patch. I do not know if i can expect a lower latency at this stage of
> development.

I am surprised, you should see a difference, especially with the
latencytest.  Silly question, but you both applied the patch and enabled
the config statement, right?

No, at this stage of development we are seeing greatly reduced latency
times with the patch.  Continued work is going to be on improving
locking mechanisms, but this is something that will come about later and
improve the kernel overall.

> A maximum of 15 msec latency with all the stress, i managed to put on the
> machine is not that bad anyway.

No, 15ms is very good.  I am seeing things 5-10ms here, but much much
higher without preemption. Odd.

> The CPU is a 1.1GHz Athlon. I forgot to mention this.

Oh, Good. we earlier had problems with an Athlon optimized kernel, but
we have solved those problems.

> I will continue to test the preempt patches.

Thank you.

> Do you want me to test anything special ?

I can't think of a benchmark that tests various aspects of a filesystem
(file creation/deletion, directory seeking and listing, etc.) but that
would be great to see if xfs improves with preemption.

You can test raw disk I/O with dbench ftp://samba.org/pub/tridge/dbench/
... try 16 threads (dbench -16).

-- 
Robert M. Love
rml at ufl.edu
rml at tech9.net

