Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270626AbTHAAXt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 31 Jul 2003 20:23:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270627AbTHAAXt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 31 Jul 2003 20:23:49 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:27351 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S270626AbTHAAXs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 31 Jul 2003 20:23:48 -0400
Date: Thu, 31 Jul 2003 17:26:55 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@hpce.nec.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       LSE <lse-tech@lists.sourceforge.net>
cc: Andi Kleen <ak@muc.de>
Subject: Re: [patch] scheduler fix for 1cpu/node case
Message-ID: <380280000.1059697615@flay>
In-Reply-To: <200307312345.36368.efocht@hpce.nec.com>
References: <200307280548.53976.efocht@gmx.net> <59140000.1059663916@[10.10.2.4]> <200307312345.36368.efocht@hpce.nec.com>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thursday 31 July 2003 17:05, Martin J. Bligh wrote:
>> you're using node_to_cpu_mask for ia64 ... others were using
>> node_to_cpumask (1 less "_"), so this doesn't build ...
> 
> Ooops, you're right, of course. Sorry about this mistake :-(

np - was easy to fix up ;-) I did run some benchmarks on it ... 
low end SDET seemed highly variable, but otherwise looked OK. 
If I have only 4 tasks running on a 16x (4x4), what's the rate
limit on the idle cpus trying to steal now?

M.

