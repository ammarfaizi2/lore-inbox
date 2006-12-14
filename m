Return-Path: <linux-kernel-owner+w=401wt.eu-S1751983AbWLNGYp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751983AbWLNGYp (ORCPT <rfc822;w@1wt.eu>);
	Thu, 14 Dec 2006 01:24:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752011AbWLNGYo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Dec 2006 01:24:44 -0500
Received: from ug-out-1314.google.com ([66.249.92.172]:23467 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752016AbWLNGYn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Dec 2006 01:24:43 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=MDra0ooXqRWvw9ng5RatL5f/cQh8kyPnUhjDSGUZFEVVae5qxnwT/gQ2GXr42pUMYaVXmp1NX4GFF/FV3XrghaQO5AV4VZRQxuMsPfT2bSnB0V4QtDtrps56rwLCL/uB/4MEFFJyD7uelrLPQmwIaEwQsTUaL9ADmDjJJ7/AEZY=
Message-ID: <86802c440612132224w795f3e01qfeee7183b791922c@mail.gmail.com>
Date: Wed, 13 Dec 2006 22:24:41 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [patch] Add allowed_affinity to the irq_desc to make it possible to have restricted irqs
Cc: "Arjan van de Ven" <arjan@linux.intel.com>, "Ingo Molnar" <mingo@elte.hu>,
       linux-kernel@vger.kernel.org
In-Reply-To: <m11wn3p0zk.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <1166018020.27217.805.camel@laptopd505.fenrus.org>
	 <m1lklbport.fsf@ebiederm.dsl.xmission.com>
	 <20061213194332.GA29185@elte.hu>
	 <m1ejr3pnm3.fsf@ebiederm.dsl.xmission.com>
	 <45806137.4020403@linux.intel.com>
	 <m11wn3p0zk.fsf@ebiederm.dsl.xmission.com>
X-Google-Sender-Auth: 8c4af48a6f179477
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/13/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Arjan van de Ven <arjan@linux.intel.com> writes:
> > the numa case is already handled; the needed info for that is exposed already
> > enough... at least for irqbalance
>
> What is the problem you are trying to solve?
>
> If it is just interrupts irqbalanced can't help with we can do that
> with a single bit.
>
> My basic problem with understanding what this patch is trying to
> solve is that I've seen some theoretical cases raised but I don't see
> the real world problem.

Good question.

irqbalance could use set_affinity from boot cpu to final cpu.

YH
