Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264237AbTDKFQX (for <rfc822;willy@w.ods.org>); Fri, 11 Apr 2003 01:16:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264238AbTDKFQX (for <rfc822;linux-kernel-outgoing>);
	Fri, 11 Apr 2003 01:16:23 -0400
Received: from [12.47.58.73] ([12.47.58.73]:44406 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S264237AbTDKFQW (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Apr 2003 01:16:22 -0400
Date: Thu, 10 Apr 2003 22:28:00 -0700
From: Andrew Morton <akpm@digeo.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: alan@lxorguk.ukuu.org.uk, davidm@hpl.hp.com, linux-kernel@vger.kernel.org
Subject: Re: proc_misc.c bug
Message-Id: <20030410222800.6afa25ae.akpm@digeo.com>
In-Reply-To: <32880.4.64.197.106.1050037303.squirrel@webmail.osdl.org>
References: <200304102202.h3AM2YH3021747@napali.hpl.hp.com>
	<1050011057.12930.134.camel@dhcp22.swansea.linux.org.uk>
	<20030410154902.32f48f9c.rddunlap@osdl.org>
	<32880.4.64.197.106.1050037303.squirrel@webmail.osdl.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Apr 2003 05:28:00.0541 (UTC) FILETIME=[1DFE7CD0:01C2FFEB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rddunlap@osdl.org> wrote:
>
> Maybe the reason to modify it is that NR_CPUS is not a good
> approximation/hint/clue.

NR_CPUS is not tooooo bad an approximation.  After all, the output size is
approximately proportional to the number of CPUs.

Multiplied by the number of interrupts :(

           CPU0       CPU1       
  0:   11982656          0    IO-APIC-edge  timer
  1:         26          0    IO-APIC-edge  i8042
  2:          0          0          XT-PIC  cascade


We could perhaps just convert it to num_online_cpus() and run away.  Depends
how heoric you're feeling.


