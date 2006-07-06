Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030212AbWGFGsJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030212AbWGFGsJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 Jul 2006 02:48:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030214AbWGFGsJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 Jul 2006 02:48:09 -0400
Received: from orion2.pixelized.ch ([195.190.190.13]:41666 "EHLO
	mail.pixelized.ch") by vger.kernel.org with ESMTP id S1030212AbWGFGsI
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 Jul 2006 02:48:08 -0400
Message-ID: <44ACB21B.9050206@debian.org>
Date: Thu, 06 Jul 2006 08:47:55 +0200
From: "Giacomo A. Catenazzi" <cate@debian.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060619)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>,
       Arjan van de Ven <arjan@infradead.org>, akpm@osdl.org,
       tglx@linutronix.de, mingo@elte.hu, rmk+lkml@arm.linux.org.uk,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] genirq: ARM dyntick cleanup
References: <1151885928.24611.24.camel@localhost.localdomain> <20060702173527.cbdbf0e1.akpm@osdl.org> <Pine.LNX.4.64.0607031007421.12404@g5.osdl.org> <1151947627.3108.39.camel@laptopd505.fenrus.org> <20060705162425.547f3d3f.rdunlap@xenotime.net> <Pine.LNX.4.64.0607051626380.12404@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0607051626380.12404@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> 
> On Wed, 5 Jul 2006, Randy.Dunlap wrote:
>> OK, I'll bite.  What part of Linus's macro doesn't work.
> 
> Heh. This is "C language 101".
> 
> The reason we always write
> 
> 	#define empty_statement do { } while (0)
> 
> instead of
> 
> 	#define empty_statement /* empty */
> 
> is not that
> 
> 	if (x)
> 		empty_statement;
> 
> wouldn't work like Arjan claimed, but because otherwise the empty 
> statement won't parse perfectly as a real C statement.

But the classical way of empty statments is "((void) 0)"
See K&R, glibc or SuS, for assert.h
( http://www.opengroup.org/onlinepubs/000095399/basedefs/assert.h.html )

or I miss something?

ciao
	cate
