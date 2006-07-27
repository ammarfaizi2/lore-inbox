Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751897AbWG0Xzo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751897AbWG0Xzo (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jul 2006 19:55:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751751AbWG0Xzo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jul 2006 19:55:44 -0400
Received: from ozlabs.tip.net.au ([203.10.76.45]:41907 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S1750710AbWG0Xzn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jul 2006 19:55:43 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17609.21005.415970.234577@cargo.ozlabs.ibm.com>
Date: Fri, 28 Jul 2006 09:53:49 +1000
From: Paul Mackerras <paulus@samba.org>
To: Andi Kleen <ak@suse.de>
Cc: Neil Horman <nhorman@tuxdriver.com>, a.zummo@towertech.it,
       jg@freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] RTC: Add mmap method to rtc character driver
In-Reply-To: <p73bqrc5rbu.fsf@verdi.suse.de>
References: <20060725174100.GA4608@hmsreliant.homelinux.net>
	<p73bqrc5rbu.fsf@verdi.suse.de>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen writes:

> No, no, it's wrong. They should use gettimeofday and the kernel's job
> is to make it fast enough that they can. 

Not necessarily - maybe gettimeofday's seconds + microseconds
representation is awkward for them to use, and some other kernel
interface would be more efficient for them to use, while being as easy
or easier for the kernel to compute.  Jim, was that your point?

Paul.
