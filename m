Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267566AbUHEGXF@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267566AbUHEGXF (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Aug 2004 02:23:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267567AbUHEGXF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Aug 2004 02:23:05 -0400
Received: from fw.osdl.org ([65.172.181.6]:19847 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S267566AbUHEGXB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Aug 2004 02:23:01 -0400
Date: Wed, 4 Aug 2004 23:21:23 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com>
Cc: linux-kernel@vger.kernel.org, robustmutexes@lists.osdl.org,
       Rusty Russell <rusty@rustcorp.com.au>, Ingo Molnar <mingo@elte.hu>,
       Jamie Lokier <jamie@shareable.org>, Ulrich Drepper <drepper@redhat.com>
Subject: Re: [RFC/PATCH] FUSYN Realtime & robust mutexes for Linux, v2.3.1
Message-Id: <20040804232123.3906dab6.akpm@osdl.org>
In-Reply-To: <F989B1573A3A644BAB3920FBECA4D25A6EC06D@orsmsx407>
References: <F989B1573A3A644BAB3920FBECA4D25A6EC06D@orsmsx407>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Perez-Gonzalez, Inaky" <inaky.perez-gonzalez@intel.com> wrote:
>
> Hi All
> 
> Fusyn aims to provide primitives to solve a bunch of gaps in POSIX
> compliance related to mutexes, conditional variables and semaphores,
> POSIX Advanced real-time support as well as adding mutex robustness
> (to dying owners) and deep deadlock checking.
> 
> All of these primitives are available to both kernel space and user
> space (through a generalization of the mechanism used by futexes),
> allowing for a fast path on most mutex operations.
> 
> We strive to solve the POSIX gap of scheduling-policy based
> unlock/wakeup for mutexes, conditional variables, semaphores,
> etc; the lacks in Advanced Real-Time support (priority inversion
> protection through priority inheritance and priority protection),
> robust mutexes (mutex waiters no longer deadlock when a mutex
> owner dies) and deep deadlock checking for mutexes.
> 
> The full description of the gaps we solve, rationales behind the
> implementation and explanations on the need for the new features
> is kind of long to fully explain here, so you can find it in the
> linux/Documentation/fusyn-why.txt after applying our patch or at
> our website, in:
> 
> http://developer.osdl.org/dev/robustmutexes/index.html#Documentation

This fixes what appear to be some fairly significant shortcomings.  What do
the futex and NPTL people have to say about the gravity of the problems
which this solves, and the offered implementation?

> We are not posting it to the list, as it has grown kind of big.

Maybe you should...
