Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263221AbVCKHO2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263221AbVCKHO2 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Mar 2005 02:14:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263223AbVCKHO2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Mar 2005 02:14:28 -0500
Received: from one.firstfloor.org ([213.235.205.2]:18345 "EHLO
	one.firstfloor.org") by vger.kernel.org with ESMTP id S263221AbVCKHO0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Mar 2005 02:14:26 -0500
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org, peterc@gelato.unsw.edu.au
Subject: Re: Microstate Accounting for 2.6.11
References: <16945.5058.251259.828855@berry.gelato.unsw.EDU.AU>
	<20050310200808.306caf98.akpm@osdl.org>
From: Andi Kleen <ak@muc.de>
Date: Fri, 11 Mar 2005 08:14:25 +0100
In-Reply-To: <20050310200808.306caf98.akpm@osdl.org> (Andrew Morton's
 message of "Thu, 10 Mar 2005 20:08:08 -0800")
Message-ID: <m1acpazmb2.fsf@muc.de>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton <akpm@osdl.org> writes:

> Why does the kernel need this feature?
>
> Have you any numbers on the overhead?

It does RDTSC and lots of complicated stuff twice for each system call. 
On P4 this will be extremly slow (> 1000cycles combined) 
It is pretty unlikely that whatever it does justifies this extreme
overhead in a critical fast path.

-Andi
