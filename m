Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423296AbWJYLaV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423296AbWJYLaV (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 25 Oct 2006 07:30:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423297AbWJYLaV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 25 Oct 2006 07:30:21 -0400
Received: from mtagate1.uk.ibm.com ([195.212.29.134]:15536 "EHLO
	mtagate1.uk.ibm.com") by vger.kernel.org with ESMTP
	id S1423296AbWJYLaU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 25 Oct 2006 07:30:20 -0400
Date: Wed, 25 Oct 2006 13:30:17 +0200
From: Muli Ben-Yehuda <muli@il.ibm.com>
To: Yinghai Lu <yinghai.lu@amd.com>
Cc: Andi Kleen <ak@muc.de>, "Eric W. Biederman" <ebiederm@xmission.com>,
       Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] x86_64 irq: reset more to default when clear irq_vector for destroy_irq
Message-ID: <20061025113017.GD3277@rhun.haifa.ibm.com>
References: <5986589C150B2F49A46483AC44C7BCA412D75C@ssvlexmb2.amd.com> <86802c440610242046g6ef06fcexf8776b5009cea23@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <86802c440610242046g6ef06fcexf8776b5009cea23@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 24, 2006 at 08:46:31PM -0700, Yinghai Lu wrote:
> resend with gmail.
> 
> Clear the irq releated entries in irq_vector, irq_domain and vector_irq
> instead of clearing irq_vector only. So when new irq is created, it
> could reuse that vector. (actually is the second loop scanning from
> FIRST_DEVICE_VECTOR+8). This could avoid the vectors are used up
> with enough module inserting and removing
> 
> Cc: Eric W. Biedierman <ebiederm@xmission.com>
> Signed-off-By: Yinghai Lu <yinghai.lu@amd.com>

I hope I'm testing the right patch... this one boots and works fine.

Cheers,
Muli
