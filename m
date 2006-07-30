Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932399AbWG3SLP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932399AbWG3SLP (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 30 Jul 2006 14:11:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932401AbWG3SLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 30 Jul 2006 14:11:15 -0400
Received: from gateway.argo.co.il ([194.90.79.130]:24338 "EHLO
	argo2k.argo.co.il") by vger.kernel.org with ESMTP id S932399AbWG3SLO
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 30 Jul 2006 14:11:14 -0400
Message-ID: <44CCF63B.6070906@argo.co.il>
Date: Sun, 30 Jul 2006 21:11:07 +0300
From: Avi Kivity <avi@argo.co.il>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Jiri Slaby <jirislaby@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: FP in kernelspace
References: <p73u04z2dzu.fsf@verdi.suse.de>
In-Reply-To: <p73u04z2dzu.fsf@verdi.suse.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 30 Jul 2006 18:11:10.0325 (UTC) FILETIME=[89038A50:01C6B403]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
>
> Avi Kivity <avi@argo.co.il> writes:
> >
> > It's also broken for x86-64, which uses sse for floating point, not
> > the x87 fpu.
>
> Sorry, that doesn't make sense.
>

 > > kernel_fpu_begin();
 > > c = d * 3.14;
 > > kernel_fpu_end();

Cannot work on x86-64, even disregarding fp exceptions, because 
kernel_fpu_begin() doesn't save the sse state which is used by fp math.

No?

-- 
Do not meddle in the internals of kernels, for they are subtle and quick to panic.

