Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288973AbSANTee>; Mon, 14 Jan 2002 14:34:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288960AbSANTdQ>; Mon, 14 Jan 2002 14:33:16 -0500
Received: from zero.tech9.net ([209.61.188.187]:48132 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S288995AbSANTcU>;
	Mon, 14 Jan 2002 14:32:20 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: "J.A. Magallon" <jamagallon@able.es>
Cc: Stephan von Krawczynski <skraw@ithnet.com>,
        Alan Cox <alan@lxorguk.ukuu.org.uk>, zippel@linux-m68k.org,
        ken@canit.se, arjan@fenrus.demon.nl, landley@trommello.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20020114160256.A2922@werewolf.able.es>
In-Reply-To: <200201140033.BAA04292@webserver.ithnet.com>
	<E16PvKx-00005L-00@the-village.bc.nu>
	<20020114104532.59950d86.skraw@ithnet.com> 
	<20020114160256.A2922@werewolf.able.es>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.1 
Date: 14 Jan 2002 14:35:13 -0500
Message-Id: <1011036915.4604.2.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2002-01-14 at 10:02, J.A. Magallon wrote:

> Yup. That remind me of...
> Would there be any kernel call every driver is doing just to hide there
> a conditional_schedule() so everyone does it even without knowledge of it ?
> Just like Apple put the SystemTask() inside GetNextEvent()...

It's not nearly that easy.  If it were, we would all certainly switch to
the preemptive kernel design, and preempt whenever and wherever we
needed.

Instead, we have to worry about reentrancy and thus can not preempt
inside critical regions (denoted by spinlocks).  So we can't have
preempt there, and have more work to do -- thus this discussion.

	Robert Love

