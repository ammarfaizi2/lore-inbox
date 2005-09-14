Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030189AbVINWLb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030189AbVINWLb (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Sep 2005 18:11:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965070AbVINWLb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Sep 2005 18:11:31 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:16361 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S965061AbVINWLY (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Wed, 14 Sep 2005 18:11:24 -0400
Date: Thu, 15 Sep 2005 00:10:56 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Russell King <rmk+lkml@arm.linux.org.uk>
cc: Nick Piggin <nickpiggin@yahoo.com.au>,
       Linux Kernel Mailing List <Linux-Kernel@vger.kernel.org>,
       Dipankar Sarma <dipankar@in.ibm.com>
Subject: Re: [PATCH 2/5] atomic: introduce atomic_inc_not_zero
In-Reply-To: <20050914230049.F30746@flint.arm.linux.org.uk>
Message-ID: <Pine.LNX.4.61.0509150010100.3728@scrub.home>
References: <43283825.7070309@yahoo.com.au> <4328387E.6050701@yahoo.com.au>
 <Pine.LNX.4.61.0509141814220.3743@scrub.home> <43285374.3020806@yahoo.com.au>
 <Pine.LNX.4.61.0509141906040.3728@scrub.home> <20050914230049.F30746@flint.arm.linux.org.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, 14 Sep 2005, Russell King wrote:

> > 	do {
> > 		old = atomic_load_locked(v);
> > 		if (!old)
> > 			break;
> > 		new = old + 1;
> > 	} while (!atomic_store_lock(v, old, new));
> 
> How do you propose architectures which don't have locked loads implement
> this, where the only atomic instruction is an unconditional atomic swap
> between memory and CPU register?

#define atomic_store_lock atomic_cmpxchg

bye, Roman
