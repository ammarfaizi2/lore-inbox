Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S293472AbSCASPj>; Fri, 1 Mar 2002 13:15:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S293469AbSCASPf>; Fri, 1 Mar 2002 13:15:35 -0500
Received: from ns.suse.de ([213.95.15.193]:62478 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S293491AbSCASOo>;
	Fri, 1 Mar 2002 13:14:44 -0500
To: Dave McCracken <dmccr@us.ibm.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2.4.19-pre2] Make max_threads be based on normal zone size
In-Reply-To: <71650000.1015004327@baldur.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 01 Mar 2002 19:14:41 +0100
In-Reply-To: Dave McCracken's message of "1 Mar 2002 18:42:55 +0100"
Message-ID: <p73vgcgjgtq.fsf@oldwotan.suse.de>
X-Mailer: Gnus v5.7/Emacs 20.6
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave McCracken <dmccr@us.ibm.com> writes:

> The max_threads config parameter (used to determine how many tasks to
> allow) is currently calculated based on the total amount of physical memory
> in the machine.  This is wrong, since the real limiting factor is the
> amount of memory in the normal zone.
> 
> This patch fixes the initialization of max_threads by allowing an
> architecture to specify how much memory is in the normal zone, and using
> that value to initialize max_threads.

There are lots of other functions with the same problem (like all the 
hash table sizing and others). Perhaps these should be fixed too? 

-Andi
