Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261680AbTISTGq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Sep 2003 15:06:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261681AbTISTGq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Sep 2003 15:06:46 -0400
Received: from holomorphy.com ([66.224.33.161]:54492 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S261680AbTISTGp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Sep 2003 15:06:45 -0400
Date: Fri, 19 Sep 2003 12:07:52 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Dave Olien <dmo@osdl.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       piggin@cyberone.com.au, maryedie@osdl.org
Subject: Re: 2.6.0-test5-mm3 as-iosched Oops running dbt2 workload
Message-ID: <20030919190752.GC4306@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Dave Olien <dmo@osdl.org>, Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, piggin@cyberone.com.au,
	maryedie@osdl.org
References: <20030919185621.GA18666@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030919185621.GA18666@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 19, 2003 at 11:56:21AM -0700, Dave Olien wrote:
> Attached is console output containing a stack trace from an Oops, followed
> by a Fatal exception, and LOTS of APIC errors.  The machine was hung,
> printing APIC error messages forever.
...
>  <0>Kernel panic: Fatal exception in interrupt
> In interrupt handler - not syncing
>  <6>APIC error on CPU3: 00(08)
> APIC error on CPU3: 08(08)

APIC receive accept error sounds like it kept getting interrupts and
didn't ack them after it panicked, which is harmless, though irritating.


-- wli
