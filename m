Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263616AbUEUPMf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263616AbUEUPMf (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 11:12:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265880AbUEUPMf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 11:12:35 -0400
Received: from dragnfire.mtl.istop.com ([66.11.160.179]:2000 "EHLO
	dsl.commfireservices.com") by vger.kernel.org with ESMTP
	id S263616AbUEUPMc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 11:12:32 -0400
Date: Fri, 21 May 2004 11:13:24 -0400 (EDT)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: Andi Kleen <ak@muc.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH][2.6-mm] Make i386 boot not so chatty
In-Reply-To: <m3vfiq3wge.fsf@averell.firstfloor.org>
Message-ID: <Pine.LNX.4.58.0405211110490.2864@montezuma.fsmlabs.com>
References: <1Yaiz-33L-1@gated-at.bofh.it> <m3vfiq3wge.fsf@averell.firstfloor.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 May 2004, Andi Kleen wrote:

> Zwane Mwaikambo <zwane@arm.linux.org.uk> writes:
>
> > This patch silences the default i386 boot by putting a lot of development
> > related printks under KERN_DEBUG loglevel, allowing the normal chatty mode
> > to be turned on by using the 'debug' kernel parameter. I have avoided
> > changing files which have external development repositories, like cpufreq and ACPI.
>
> How about this much simpler patch?
>
> -Andi
>
>  /* printk's without a loglevel use this.. */
> -#define DEFAULT_MESSAGE_LOGLEVEL 4 /* KERN_WARNING */
> +#define DEFAULT_MESSAGE_LOGLEVEL 6 /* KERN_INFO */

Still rather verbose, there is too much debugging stuff under KERN_INFO.

