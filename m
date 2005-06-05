Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261562AbVFENoq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261562AbVFENoq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Jun 2005 09:44:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261566AbVFENop
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Jun 2005 09:44:45 -0400
Received: from imf22aec.mail.bellsouth.net ([205.152.59.70]:5113 "EHLO
	imf22aec.mail.bellsouth.net") by vger.kernel.org with ESMTP
	id S261562AbVFENoo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Jun 2005 09:44:44 -0400
Message-ID: <007e01c569dc$1d6d2160$2800000a@pc365dualp2>
From: <cutaway@bellsouth.net>
To: <linux-kernel@vger.kernel.org>
References: <42A09190.8080703@ccur.com> <20050605112119.GU23831@wotan.suse.de>
Subject: Re: [PATCH] ptrace(2) single-stepping into signal handlers
Date: Sun, 5 Jun 2005 10:37:29 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1478
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1478
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

----- Original Message ----- 
From: "Andi Kleen" <ak@suse.de>
To: "John Blackwood" <john.blackwood@ccur.com>
Cc: <linux-kernel@vger.kernel.org>; <roland@redhat.com>; <ak@suse.de>;
<akpm@osdl.org>; <bugsy@ccur.com>
Sent: Sunday, June 05, 2005 07:21
Subject: Re: [PATCH] ptrace(2) single-stepping into signal handlers


> On Fri, Jun 03, 2005 at 01:21:20PM -0400, John Blackwood wrote:
> > 1. Make the default behavior that we single-step to the next instruction
> >    in the main (non-signal handler) stream of execution, instead of
> >    single-stepping into the user's signal handler.
>
> I think it is better to not change the default behaviour. You risk
> breaking programs and there are much more that use ptrace than just gdb.

A performance trace profiler would want to step through signal handlers.
Sometimes they're an architected norm for a program rather than an abnormal
condition handler (ex. Lisp systems routinely handling GP faults on null
pointers rather than doing null pointer checks in critical loops)

