Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261943AbUEFNRa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261943AbUEFNRa (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 6 May 2004 09:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261984AbUEFNRa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 6 May 2004 09:17:30 -0400
Received: from delerium.kernelslacker.org ([81.187.208.145]:62869 "EHLO
	delerium.codemonkey.org.uk") by vger.kernel.org with ESMTP
	id S261943AbUEFNR3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 6 May 2004 09:17:29 -0400
Date: Thu, 6 May 2004 14:16:19 +0100
From: Dave Jones <davej@redhat.com>
To: Tigran Aivazian <tigran@veritas.com>
Cc: Simon Trimmer <simon@urbanmyth.org>, kim.jensen2@hp.com,
       linux-kernel@vger.kernel.org
Subject: Re: microcode_ctl question (fwd)
Message-ID: <20040506131619.GB27851@redhat.com>
Mail-Followup-To: Dave Jones <davej@redhat.com>,
	Tigran Aivazian <tigran@veritas.com>,
	Simon Trimmer <simon@urbanmyth.org>, kim.jensen2@hp.com,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.53.0405052017190.31452@calcium.webfusion.co.uk> <Pine.LNX.4.44.0405061307310.3358-100000@einstein.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0405061307310.3358-100000@einstein.homenet>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 06, 2004 at 01:23:42PM +0100, Tigran Aivazian wrote:

Hi Tigran,

 > Btw, I have just noticed what may be a bug wrt not being aware of kernel
 > preemption, i.e. we cache the CPU id in a local variable and later use it,
 > but then there seems to be no protection against kernel preemption (i.e.
 > we hold no spinlocks, only a semaphore) at that point, so the original CPU
 > id may not be quite the same as the CPU id for which the data was
 > collected. I should fix this if it is a problem. The question to
 > linux-kernel guys is to confirm that this is indeed a bug, i.e. to clarify
 > under which condition the kernel preemption can and cannot occur.
 > 
 > In particular can such preemption occur while executing a function called 
 > via IPI mechanism?

I fixed up microcode.c to use on_each_cpu() last year sometime, which
I thought should fix things up wrt preemption. Can you point to the
bits you think are still problematic ?

		Dave

