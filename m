Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751414AbWGMGrz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751414AbWGMGrz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Jul 2006 02:47:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751490AbWGMGrz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Jul 2006 02:47:55 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:60339 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S1751414AbWGMGru (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Jul 2006 02:47:50 -0400
X-Mailer: exmh version 2.7.2 01/07/2005 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: eranian@hpl.hp.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 adds smp_call_function_single 
In-reply-to: Your message of "Tue, 11 Jul 2006 06:24:22 MST."
             <20060711132422.GB28851@frankl.hpl.hp.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 13 Jul 2006 16:47:04 +1000
Message-ID: <12523.1152773224@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephane Eranian (on Tue, 11 Jul 2006 06:24:22 -0700) wrote:
>+static void
>+__smp_call_function_single(int cpu, void (*func) (void *info), void *info,
>+				int nonatomic, int wait)
>...
>+	wmb();
>+	/* Send a message to all other CPUs and wait for them to respond */
>+	send_IPI_mask(cpumask_of_cpu(cpu), CALL_FUNCTION_VECTOR);

Nit pick.  The comment is wrong, one cpu, not all cpus.

