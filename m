Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262256AbUEFN2R@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262256AbUEFN2R (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 09:28:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262215AbUEFN1n
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 09:27:43 -0400
Received: from userel174.dsl.pipex.com ([62.188.199.174]:41094 "EHLO
	einstein.homenet") by vger.kernel.org with ESMTP id S262256AbUEFN07
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 09:26:59 -0400
Date: Thu, 6 May 2004 14:25:13 +0100 (BST)
From: Tigran Aivazian <tigran@veritas.com>
X-X-Sender: tigran@einstein.homenet
To: Dave Jones <davej@redhat.com>
cc: Simon Trimmer <simon@urbanmyth.org>, <kim.jensen2@hp.com>,
       <linux-kernel@vger.kernel.org>
Subject: Re: microcode_ctl question (fwd)
In-Reply-To: <20040506131619.GB27851@redhat.com>
Message-ID: <Pine.LNX.4.44.0405061423230.4432-100000@einstein.homenet>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 May 2004, Dave Jones wrote:
> I fixed up microcode.c to use on_each_cpu() last year sometime, which
> I thought should fix things up wrt preemption. Can you point to the
> bits you think are still problematic ?

Ok, just looked at the definition of on_each_cpu() and I can see that it 
is disabling/enabling preemption explicitly, so there are no problems.

I assumed that on_each_cpu() is just a new 2.6 name for the old 
smp_call_function(), that is why I thought there may be problems with 
preemption. Thanks for clarifying this.

Kind regards
Tigran

