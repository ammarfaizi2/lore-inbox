Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261992AbUKCXO5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261992AbUKCXO5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 3 Nov 2004 18:14:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261974AbUKCXG5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 3 Nov 2004 18:06:57 -0500
Received: from sp-260-1.net4.netcentrix.net ([4.21.254.118]:23448 "EHLO
	asmodeus.mcnaught.org") by vger.kernel.org with ESMTP
	id S261890AbUKCXDu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 3 Nov 2004 18:03:50 -0500
To: Russell Miller <rmiller@duskglow.com>
Cc: Jim Nelson <james4765@verizon.net>, DervishD <lkml@dervishd.net>,
       Gene Heskett <gene.heskett@verizon.net>, linux-kernel@vger.kernel.org,
       =?iso-8859-1?q?M=E5ns_Rullg=E5rd?= <mru@inprovide.com>
Subject: Re: is killing zombies possible w/o a reboot?
References: <200411030751.39578.gene.heskett@verizon.net>
	<20041103192648.GA23274@DervishD> <4189586E.2070409@verizon.net>
	<200411031644.58979.rmiller@duskglow.com>
From: Doug McNaught <doug@mcnaught.org>
Date: Wed, 03 Nov 2004 18:03:32 -0500
In-Reply-To: <200411031644.58979.rmiller@duskglow.com> (Russell Miller's
 message of "Wed, 3 Nov 2004 17:44:58 -0500")
Message-ID: <87k6t24jsr.fsf@asmodeus.mcnaught.org>
User-Agent: Gnus/5.1002 (Gnus v5.10.2) Emacs/20.7 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Russell Miller <rmiller@duskglow.com> writes:

> Anyway, is there a way to simply signal a syscall that it is to be
> interrupted and forcibly cause the syscall to end?  Kicking the
> program execution out of kernel space would be sufficient to
> "unstick" the process - and coupling that with an automatic KILL
> signal may not be a bad idea.

It was already mentioned in this thread that the bookkeeping required
to clean up properly from such an abort would add a lot of overhead
and slow down the normal, non-buggy case.

-Doug
