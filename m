Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264035AbRFFSqO>; Wed, 6 Jun 2001 14:46:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264038AbRFFSqE>; Wed, 6 Jun 2001 14:46:04 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:5676 "EHLO
	flinx.biederman.org") by vger.kernel.org with ESMTP
	id <S264027AbRFFSpq>; Wed, 6 Jun 2001 14:45:46 -0400
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christian Borntrdger <linux-kernel@borntraeger.net>,
        Derek Glidden <dglidden@illusionary.com>
Subject: Re: Requirement: swap = RAM x 2.5 ??
In-Reply-To: <3B1D5ADE.7FA50CD0@illusionary.com>
	<991815578.30689.1.camel@nomade>
	<20010606095431.C15199@dev.sportingbet.com>
	<0106061316300A.00553@starship>
	<200106061528.f56FSKa14465@vindaloo.ras.ucalgary.ca>
	<000701c0ee9f$515fd6a0$3303a8c0@einstein>
	<3B1E52FC.C17C921F@mandrakesoft.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Jun 2001 12:42:03 -0600
In-Reply-To: <3B1E52FC.C17C921F@mandrakesoft.com>
Message-ID: <m1snhd5u2s.fsf@frodo.biederman.org>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.5
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jeff Garzik <jgarzik@mandrakesoft.com> writes:

> I'm sorry but this is a regression, plain and simple.
> 
> Previous versons of Linux have worked great on diskless workstations
> with NO swap.
> 
> Swap is "extra space to be used if we have it" and nothing else.

Given the slow speed of disks to use them efficiently when you are using
swap some additional rules apply.

In the worse case when swapping is being used you get:
Virtual Memory = RAM + (swap - RAM).

That cannot be improved.  You can increase your likely hood that that case won't
come up, but that is a different matter entirely.  

I suspect in practice that we are suffering more from lazy reclamation
of swap pages than from a more aggressive swap cache. 

Eric

