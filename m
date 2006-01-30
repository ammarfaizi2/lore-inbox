Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964906AbWA3T02@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964906AbWA3T02 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 30 Jan 2006 14:26:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964907AbWA3T01
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 30 Jan 2006 14:26:27 -0500
Received: from fmr22.intel.com ([143.183.121.14]:14246 "EHLO
	scsfmr002.sc.intel.com") by vger.kernel.org with ESMTP
	id S964900AbWA3T0Z (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 30 Jan 2006 14:26:25 -0500
Message-Id: <200601301926.k0UJQBg16647@unix-os.sc.intel.com>
From: "Chen, Kenneth W" <kenneth.w.chen@intel.com>
To: "'Ingo Molnar'" <mingo@elte.hu>, "Bjorn Helgaas" <bjorn.helgaas@hp.com>
Cc: "Ingo Molnar" <mingo@redhat.com>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>
Subject: RE: boot-time slowdown for measure_migration_cost
Date: Mon, 30 Jan 2006 11:26:04 -0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.6353
Thread-Index: AcYlwgS4Y0Gm00o5TDKKmQKLy+FgtwAEE29Q
In-Reply-To: <20060130172140.GB11793@elte.hu>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2180
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ingo Molnar wrote on Monday, January 30, 2006 9:22 AM
> - in kernel/sched.c, decrease ITERATIONS from 2 to 1. This will make the 
>   measurement more noisy though.
> 
> - in kernel/sched.c, change this line:
> 
>                 size = size * 20 / 19;
> 
>   to:
> 
>                 size = size * 10 / 9;
> 
>   this will probably halve the cost - against at the expense of 
>   accuracy and statistical stability.

I think the kernel should keep the accuracy and stability.  One option
would be by default not to measure the migration cost.  For people who
wants to have an accurate scheduler parameter, they can turn on a boot
time option to do the measure.

- Ken

