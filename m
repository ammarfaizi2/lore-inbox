Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281088AbRKTO6j>; Tue, 20 Nov 2001 09:58:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281093AbRKTO6a>; Tue, 20 Nov 2001 09:58:30 -0500
Received: from zero.tech9.net ([209.61.188.187]:35079 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S281088AbRKTO6P>;
	Tue, 20 Nov 2001 09:58:15 -0500
Subject: Re: [bug report] System hang up with Speedtouch USB hotplug
From: Robert Love <rml@tech9.net>
To: Duncan Sands <duncan.sands@math.u-psud.fr>
Cc: Kilobug <kilobug@freesurf.fr>, linux-kernel@vger.kernel.org
In-Reply-To: <E166A9X-0000Co-00@baldrick>
In-Reply-To: <E165lQB-0001DZ-00@baldrick> <1006204883.826.0.camel@phantasy> 
	<E166A9X-0000Co-00@baldrick>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/0.99.1+cvs.2001.11.14.08.58 (Preview Release)
Date: 20 Nov 2001 09:58:10 -0500
Message-Id: <1006268291.5448.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2001-11-20 at 07:37, Duncan Sands wrote:
> By the way, I find the preemptible kernel patch
> very helpful for debugging SMP problems on a
> uniprocessor machine.
> 
> I'm trying to debug the speedtouch kernel module
> crashes with SMP using it: the module oopses
> nicely with preempt too!

This is a nice unintended benefit of the preemptible kernel patch, eh? 
It also helps in your SMP debugging because you can see the lock depth
(how many locks are held) via current->preempt_count.  The preempt patch
will also prevent you from infinite looping in the kernel, assuming the
system is able to preempt itself.

	Robert Love

