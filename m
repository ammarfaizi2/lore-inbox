Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S272786AbTG3HLk (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Jul 2003 03:11:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S272787AbTG3HLk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Jul 2003 03:11:40 -0400
Received: from mx1.elte.hu ([157.181.1.137]:28837 "EHLO mx1.elte.hu")
	by vger.kernel.org with ESMTP id S272786AbTG3HLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Jul 2003 03:11:39 -0400
Date: Wed, 30 Jul 2003 09:07:59 +0200 (CEST)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: Ingo Molnar <mingo@elte.hu>
To: Andrew Morton <akpm@osdl.org>
Cc: linas@austin.ibm.com, <linux-kernel@vger.kernel.org>,
       Andrea Arcangeli <andrea@suse.de>
Subject: Re: PATCH: Race in 2.6.0-test2 timer code
In-Reply-To: <20030729233603.21ad2409.akpm@osdl.org>
Message-ID: <Pine.LNX.4.44.0307300842550.29469-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 29 Jul 2003, Andrew Morton wrote:

> Well Andrea did mention a problem with the interval timers.  But I am
> not aware of the exact details of the race which he found, and I don't
> understand why del_timer() and add_timer() would be needing the
> per-timer locks.

hmm ... indeed i cannot see the 2.6 itimer race anymore. Andrea, can you
see any SMP races in the current 2.6 timer code?

(in any case, i still think it would be safer to 'upgrade' the add_timer()  
interface to be SMP-safe and to allow double-adds - but not for any bug
reason anymore.)

	Ingo

