Return-Path: <linux-kernel-owner+w=401wt.eu-S1751815AbWLNIW3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751815AbWLNIW3 (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 03:22:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751814AbWLNIW3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 03:22:29 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:55207 "EHLO
	ebiederm.dsl.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751815AbWLNIW1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 03:22:27 -0500
From: ebiederm@xmission.com (Eric W. Biederman)
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Ingo Molnar <mingo@elte.hu>, linux-kernel@vger.kernel.org
Subject: Re: [patch] Add allowed_affinity to the irq_desc to make it possible to have restricted irqs
References: <1166018020.27217.805.camel@laptopd505.fenrus.org>
	<m1lklbport.fsf@ebiederm.dsl.xmission.com>
	<20061213194332.GA29185@elte.hu>
	<m1ejr3pnm3.fsf@ebiederm.dsl.xmission.com>
	<45806137.4020403@linux.intel.com>
	<m11wn3p0zk.fsf@ebiederm.dsl.xmission.com>
	<45810383.2060708@linux.intel.com>
Date: Thu, 14 Dec 2006 01:22:08 -0700
In-Reply-To: <45810383.2060708@linux.intel.com> (Arjan van de Ven's message of
	"Thu, 14 Dec 2006 08:55:47 +0100")
Message-ID: <m1psamopjj.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@linux.intel.com> writes:

> Eric W. Biederman wrote:
>> What is the problem you are trying to solve?
>
> 2 problems
> 1) irq's that irqbalance should not touch at all

This is easy we just need a single bit.  Not 128+ bytes on the huge
machines.

> 2) irqs that can only go to a subset of processors.
>
> 1) is very real today
> 2) is partially real on some of the bigger numa stuff already.

You have said you the NUMA cases is handled in another way already?
In which case irqs that can only got to a subset of processors
shouldn't be a problem.

Eric
