Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270675AbTGNPmm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jul 2003 11:42:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270676AbTGNPmm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jul 2003 11:42:42 -0400
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:22555 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id S270675AbTGNPml (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jul 2003 11:42:41 -0400
Date: Mon, 14 Jul 2003 11:57:29 -0400
From: Jakub Jelinek <jakub@redhat.com>
To: davidm@hpl.hp.com
Cc: linux-kernel@vger.kernel.org
Subject: Re: sizeof (siginfo_t) problem
Message-ID: <20030714115729.K15481@devserv.devel.redhat.com>
Reply-To: Jakub Jelinek <jakub@redhat.com>
References: <20030714084000.J15481@devserv.devel.redhat.com> <16146.53424.388683.213654@napali.hpl.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <16146.53424.388683.213654@napali.hpl.hp.com>; from davidm@napali.hpl.hp.com on Mon, Jul 14, 2003 at 08:48:00AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 14, 2003 at 08:48:00AM -0700, David Mosberger wrote:
>   Jakub> The kernel unfortunately does this right on sparc64 and alpha
>   Jakub> from 64-bit arches only; ia64, s390x, ppc64 etc. got it
>   Jakub> wrong.
> 
> The ia64 kernel defines in asm-ia64/siginfo.h:
> 
> #define SI_PAD_SIZE	((SI_MAX_SIZE/sizeof(int)) - 4)
> 
> typedef struct siginfo {
> 	int si_signo;
> 	int si_errno;
> 	int si_code;
> 	int __pad0;
> 
> What's wrong with that?

Oops, sorry, you're right, dunno where I was looking.
So, the bug seems to exist on s390x, amd64, maybe parisc64 if such thing
exists.

	Jakub
