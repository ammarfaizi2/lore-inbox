Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287287AbSBLTPu>; Tue, 12 Feb 2002 14:15:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290276AbSBLTPl>; Tue, 12 Feb 2002 14:15:41 -0500
Received: from deimos.hpl.hp.com ([192.6.19.190]:28124 "EHLO deimos.hpl.hp.com")
	by vger.kernel.org with ESMTP id <S287287AbSBLTP3>;
	Tue, 12 Feb 2002 14:15:29 -0500
From: David Mosberger <davidm@hpl.hp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <15465.27077.652387.974359@napali.hpl.hp.com>
Date: Tue, 12 Feb 2002 11:15:17 -0800
To: David Howells <dhowells@redhat.com>
Cc: "David S. Miller" <davem@redhat.com>, torvalds@transmeta.com,
        davidm@hpl.hp.com, anton@samba.org, linux-kernel@vger.kernel.org,
        zippel@linux-m68k.org
Subject: Re: thread_info implementation
In-Reply-To: <23729.1013520070@warthog.cambridge.redhat.com>
In-Reply-To: <davem@redhat.com>
	<20020211.185100.68039940.davem@redhat.com>
	<23729.1013520070@warthog.cambridge.redhat.com>
X-Mailer: VM 7.00 under Emacs 21.1.1
Reply-To: davidm@hpl.hp.com
X-URL: http://www.hpl.hp.com/personal/David_Mosberger/
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> On Tue, 12 Feb 2002 13:21:10 +0000, David Howells <dhowells@redhat.com> said:

  David.H> What might be worth doing is to move the task_struct slab
  David.H> cache and (de-)allocator out of fork.c and to stick it in
  David.H> the arch somewhere. Then archs aren't bound to have the two
  David.H> separate. So for a system that can handle lots of memory,
  David.H> you can allocate the thread_info, task_struct and
  David.H> supervisor stack all on one very large chunk if you so
  David.H> wish.

Could you do this?  I'd prefer if task_info could be completely hidden
inside the x86/sparc arch-specific code, but if things are set up such
that we at least have the option to keep the stack, task_info, and
task_struct in a single chunk of memory (and without pointers between
them), I'd have much less of an issue with it.

	--david
