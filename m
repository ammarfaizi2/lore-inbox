Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288765AbSANE7r>; Sun, 13 Jan 2002 23:59:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288767AbSANE7f>; Sun, 13 Jan 2002 23:59:35 -0500
Received: from dsl081-053-223.sfo1.dsl.speakeasy.net ([64.81.53.223]:38784
	"EHLO starship.berlin") by vger.kernel.org with ESMTP
	id <S288765AbSANE7Z>; Sun, 13 Jan 2002 23:59:25 -0500
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@bonn-fries.net>
To: Arjan van de Ven <arjan@fenrus.demon.nl>,
        Roman Zippel <zippel@linux-m68k.org>
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
Date: Mon, 14 Jan 2002 06:03:43 +0100
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <E16PZbb-0003i6-00@the-village.bc.nu> <3C41A545.A903F24C@linux-m68k.org> <20020113153602.GA19130@fenrus.demon.nl>
In-Reply-To: <20020113153602.GA19130@fenrus.demon.nl>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E16PzHb-00006g-00@starship.berlin>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 13, 2002 04:36 pm, Arjan van de Ven wrote:
> On Sun, Jan 13, 2002 at 04:18:29PM +0100, Roman Zippel wrote:
> 
> > What somehow got lost in this discussion, that both patches don't
> > necessarily conflict with each other, they both attack the same problem
> > with different approaches, which complement each other. I prefer to get
> > the best of both patches.
> 
> If you do this (and I've seen the results of doing both at once vs only
> either of then vs pure) then there's NO benifit for the preemption left.

Sorry, that's incorrect.  I stated why earlier in this thread and akpm signed 
off on it.  With preempt you get ASAP (i.e., as soon as the outermost 
spinlock is done) process scheduling.  With hand-coded scheduling points you 
get 'as soon as it happens to hit a scheduling point'.

That is not the only benefit, just the most obvious one.

--
Daniel
