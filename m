Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129078AbRBOTIQ>; Thu, 15 Feb 2001 14:08:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129357AbRBOTII>; Thu, 15 Feb 2001 14:08:08 -0500
Received: from nat-pool.corp.redhat.com ([199.183.24.200]:44901 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S129078AbRBOTHz>; Thu, 15 Feb 2001 14:07:55 -0500
Date: Thu, 15 Feb 2001 14:06:30 -0500 (EST)
From: Ben LaHaise <bcrl@redhat.com>
To: Kanoj Sarcar <kanoj@google.engr.sgi.com>
cc: Jamie Lokier <lk@tantalophile.demon.co.uk>, <linux-mm@kvack.org>,
        <mingo@redhat.com>, <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: x86 ptep_get_and_clear question
In-Reply-To: <200102151857.KAA82397@google.engr.sgi.com>
Message-ID: <Pine.LNX.4.30.0102151402460.15843-100000@today.toronto.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 15 Feb 2001, Kanoj Sarcar wrote:

> No. All architectures do not have this problem. For example, if the
> Linux "dirty" (not the pte dirty) bit is managed by software, a fault
> will actually be taken when processor 2 tries to do the write. The fault
> is solely to make sure that the Linux "dirty" bit can be tracked. As long
> as the fault handler grabs the right locks before updating the Linux "dirty"
> bit, things should be okay. This is the case with mips, for example.
>
> The problem with x86 is that we depend on automatic x86 dirty bit
> update to manage the Linux "dirty" bit (they are the same!). So appropriate
> locks are not grabbed.

Will you please go off and prove that this "problem" exists on some x86
processor before continuing this rant?  None of the PII, PIII, Athlon,
K6-2 or 486s I checked exhibited the worrisome behaviour you're
speculating about, plus it is logically consistent with the statements the
manual does make about updating ptes; otherwise how could an smp os
perform a reliable shootdown by doing an atomic bit clear on the present
bit of a pte?

		-ben

