Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131669AbRDJMtm>; Tue, 10 Apr 2001 08:49:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131672AbRDJMtd>; Tue, 10 Apr 2001 08:49:33 -0400
Received: from iris.mc.com ([192.233.16.119]:16081 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S131669AbRDJMtZ>;
	Tue, 10 Apr 2001 08:49:25 -0400
From: Mark Salisbury <mbs@mc.com>
To: David Schleef <ds@schleef.org>, David Schleef <ds@schleef.org>,
        Mikulas Patocka <mikulas@artax.karlin.mff.cuni.cz>
Subject: Re: No 100 HZ timer !
Date: Tue, 10 Apr 2001 08:34:47 -0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, Jeff Dike <jdike@karaya.com>,
        schwidefsky@de.ibm.com, linux-kernel@vger.kernel.org
In-Reply-To: <20010410044336.A1934@stm.lbl.gov> <Pine.LNX.3.96.1010410135540.17123B-100000@artax.karlin.mff.cuni.cz> <20010410053105.B4144@stm.lbl.gov>
In-Reply-To: <20010410053105.B4144@stm.lbl.gov>
MIME-Version: 1.0
Message-Id: <0104100840171D.01893@pc-eng24.mc.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Apr 2001, David Schleef wrote:
> This just indicates that the interface needs to be richer -- i.e.,
> such as having a "lazy timer" that means: "wake me up when _at least_
> N ns have elapsed, but there's no hurry."  If waking you up at N ns
> is expensive, then the wakeup is delayed until something else
> interesting happens.

all POSIX timer and timer like functions (timer_xxx, nanosleep, alarm etc)
are defined to operate on a 'no earlier than' semantic. i.e. if you ask to
nanosleep for 500 nsec, you will sleep for no less than 500 nanoseconds, but
possibly up to 20,000,500 nanoseconds.  this is because the maximum legal POSIX
time resolution is 20,000,000 nanoseconds (1/50th second or 50hz because of
european electricity and old hardware)

-- 
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**   mbs@mc.com     | System OS - Kernel Team     **
**------------------------------------------------**
**  I will be riding in the Multiple Sclerosis    **
**  Great Mass Getaway, a 150 mile bike ride from **
**  Boston to Provincetown.  Last year I raised   **
**  over $1200.  This year I would like to beat   **
**  that.  If you would like to contribute,       **
**  please contact me.                            **
**------------------------------------------------*/

