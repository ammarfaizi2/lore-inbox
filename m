Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S282943AbRK0Uw6>; Tue, 27 Nov 2001 15:52:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S282944AbRK0Uws>; Tue, 27 Nov 2001 15:52:48 -0500
Received: from zero.tech9.net ([209.61.188.187]:64009 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S282943AbRK0Uwf>;
	Tue, 27 Nov 2001 15:52:35 -0500
Subject: Re: [patch] sched_[set|get]_affinity() syscall, 2.4.15-pre9
From: Robert Love <rml@tech9.net>
To: Joe Korty <l-k@mindspring.com>
Cc: mingo@elte.hu, Ryan Cumming <bodnar42@phalynx.dhs.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <5.0.2.1.2.20011127020817.009ed3d0@pop.mindspring.com>
In-Reply-To: <1006832357.1385.3.camel@icbm> 
	<5.0.2.1.2.20011127020817.009ed3d0@pop.mindspring.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 27 Nov 2001 15:53:04 -0500
Message-Id: <1006894385.819.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-11-27 at 02:13, Joe Korty wrote:

> I have not yet seen the patch, but one nice feature that a system call 
> interface could provide is the ability to *atomically* change the cpu
> affinities of sets of processes -- for example, all processes with a
> certain uid or gid.  All that would be required would be for the system
> call to accept a command integer value which would define what the
> argument integer value would mean -- a pid, a gid, or a uid.

Effecting all tasks matching a uid or some other filter is a little
beyond what either patch does.  Note however that both interfaces have
atomicity.

You can open and write to proc from within a program ... very easily, in
fact.

Also, with some sed and grep magic, you can set the affinity of all
tasks via the proc interface pretty easy.  Just a couple lines.

	Robert Love

