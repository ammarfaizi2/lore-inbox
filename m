Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290103AbSAKUbW>; Fri, 11 Jan 2002 15:31:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290100AbSAKUbC>; Fri, 11 Jan 2002 15:31:02 -0500
Received: from zero.tech9.net ([209.61.188.187]:8719 "EHLO zero.tech9.net")
	by vger.kernel.org with ESMTP id <S290097AbSAKUbA>;
	Fri, 11 Jan 2002 15:31:00 -0500
Subject: Re: [2.4.17/18pre] VM and swap - it's really unusable
From: Robert Love <rml@tech9.net>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: nigel@nrg.org, Rob Landley <landley@trommello.org>,
        Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu>
In-Reply-To: <E16P0vl-0007Tu-00@the-village.bc.nu>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.0.99+cvs.2001.12.18.08.57 (Preview Release)
Date: 11 Jan 2002 15:33:22 -0500
Message-Id: <1010781207.819.27.camel@phantasy>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2002-01-11 at 07:37, Alan Cox wrote:

> Its more than a spinlock cleanup at that point. To do anything useful you have
> to tackle both priority inversion and some kind of at least semi-formal 
> validation of the code itself. At the point it comes down to validating the
> code I'd much rather validate rtlinux than the entire kernel

The preemptible kernel plus the spinlock cleanup could really take us
far.  Having locked at a lot of the long-held locks in the kernel, I am
confident at least reasonable progress could be made.

Beyond that, yah, we need a better locking construct.  Priority
inversion could be solved with a priority-inheriting mutex, which we can
tackle if and when we want to go that route.  Not now.

I want to lay the groundwork for a better kernel.  The preempt-kernel
patch gives real-world improvements, it provides a smoother user desktop
experience -- just look at the positive feedback.  Most importantly,
however, it provides a framework for superior response with our standard
kernel in its standard programming model. 

	Robert Love

