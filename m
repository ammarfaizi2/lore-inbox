Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965172AbVKVUiq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965172AbVKVUiq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 22 Nov 2005 15:38:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965175AbVKVUip
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 22 Nov 2005 15:38:45 -0500
Received: from gateway-1237.mvista.com ([12.44.186.158]:19451 "EHLO
	hermes.mvista.com") by vger.kernel.org with ESMTP id S965172AbVKVUio
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 22 Nov 2005 15:38:44 -0500
Message-ID: <438381D4.5020904@mvista.com>
Date: Tue, 22 Nov 2005 12:38:44 -0800
From: David Singleton <dsingleton@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Fedora/1.7.8-2
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: robustmutexes@lists.osdl.org
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Robust Futex patches available
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


    There are two new patches for Robust Futex support available at

    http://source.mvista.com/~dsingleton

    patch-2.6.14-rt13-rf3 fixes two locking bugs which caused hangs and 
deadlocks.

    patch-2.6.14-rt13-rf4 adds support for pthread_mutexes 'malloc'ed on 
the heap.

    I'd also like some advice on the direction POSIX is heading with 
respect to
    robust pthread_mutexes and priority inheritance.

    It appears there are some not used openposix tests that use 
different flags for
    defining robustness.      Here is a snip from the openposix robust 
test's README:

Robust Mutex Tests
------------------------
The tests are under <rtnptl-tests>/robust_test directory.

rt-nptl supports 'robust' behavior, there will be two robust modes,
one is PTHREAD_MUTEX_ROBUST_NP mode, the other is
PTHREAD_MUTEX_ROBUST_SUN_NP mode. When the owner of a mutex dies in
the first mode, the waiter will set the mutex to ENOTRECOVERABLE
state, while in the second mode, the waiter needs to call
pthread_mutex_setconsistency_np to change the state manually.

Currently the PTHREAD_MUTEX_ROBUST_NP is providing
the fucntionality described by the PTHREAD_MUTEX_ROBUST_SUN_NP.

Any advice on which way we should go?   I feel we should follow
POSIX and provide both methods and the new pthread_mutex_setconsistency_np
function which provides the mutex recovery mechanism.

David

