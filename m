Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266573AbUGKL4w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266573AbUGKL4w (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jul 2004 07:56:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266575AbUGKL4w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jul 2004 07:56:52 -0400
Received: from mx1.redhat.com ([66.187.233.31]:10117 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S266573AbUGKL4v (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jul 2004 07:56:51 -0400
Date: Sun, 11 Jul 2004 07:56:10 -0400 (EDT)
From: Ingo Molnar <mingo@redhat.com>
X-X-Sender: mingo@devserv.devel.redhat.com
To: Andi Kleen <ak@muc.de>
cc: linux-kernel@vger.kernel.org, Andrew Morton <akpm@osdl.org>
Subject: Re: serious performance regression due to NX patch
In-Reply-To: <m31xjiam9q.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.58.0407110754280.26194@devserv.devel.redhat.com>
References: <2giKE-67F-1@gated-at.bofh.it> <2gIc8-6pd-29@gated-at.bofh.it>
 <2gJ8a-72b-11@gated-at.bofh.it> <2gJhY-776-21@gated-at.bofh.it>
 <m31xjiam9q.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Sun, 11 Jul 2004, Andi Kleen wrote:

> > +#ifdef __i386__
> 
> Won't do on x86-64.

well on x86-64 'non-executable' really means non-executable, and always
did, right? (and this is completely separate from the issue of whether the
process stack is executable or not. This is about x86 that didnt enforce
the vma's protection bit.)

	Ingo
