Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261285AbVEDRjE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261285AbVEDRjE (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 May 2005 13:39:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261254AbVEDRjE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 May 2005 13:39:04 -0400
Received: from pC19EBD0F.dip.t-dialin.net ([193.158.189.15]:4 "EHLO
	gateway2.croq.loc") by vger.kernel.org with ESMTP id S261314AbVEDRi0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 May 2005 13:38:26 -0400
Message-ID: <4279084C.9030908@free.fr>
Date: Wed, 04 May 2005 19:37:16 +0200
From: Olivier Croquette <ocroquette@free.fr>
User-Agent: Mozilla Thunderbird 1.0.2 (Macintosh/20050317)
X-Accept-Language: fr-fr, en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: Scheduler: SIGSTOP on multi threaded processes
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello

On a 2.6.11 x86 system, I am SIGSTOP'ing processes which have started 
several threads before.

As expected, all threads are suspended.

But surprisingly, it can happen that some threads are still scheduled 
after the SIGSTOP has been issued.

Typically, they get scheduled 2 times within the next 5ms, before being 
really stopped.

Sadly, I could not reproduce that in a smaller example yet.

As this behaviour is IMA against the SIGSTOP concept, I tried to analyze 
the kernel code responsible for that. I could not really find the exact 
lines.

So here are my questions:

1. do you know any reason for which the SIGSTOP would not stop 
immediatly all threads of a process?

2. where do the threads get suspended exactly in the kernel? I think it 
is in signal.c but I am not sure exactly were.

3. can you confirm that the bug MUST be in my code? :)

Thanks!

Best regards

Olivier
