Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263140AbTDMDke (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 23:40:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263144AbTDMDke (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 23:40:34 -0400
Received: from franka.aracnet.com ([216.99.193.44]:18092 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263140AbTDMDkd (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 23:40:33 -0400
Date: Sat, 12 Apr 2003 20:52:11 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: "Shaheed R. Haque" <srhaque@iee.org>, linux-kernel@vger.kernel.org
cc: thockin@isunix.it.ilstu.edu
Subject: Re: Re: Processor sets (pset) for linux kernel 2.5/2.6?
Message-ID: <241480000.1050205930@[10.10.2.4]>
In-Reply-To: <1050177383.3e986f67b7f68@netmail.pipex.net>
References: <1050146434.3e97f68300fff@netmail.pipex.net> <1050177383.3e986f67b7f68@netmail.pipex.net>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Hmmm, AFAICS, sched_getaffinity() and sched_setaffinity() 
> allow the calling process to be bound to the nominated CPU(s), but that is not 
> the same as giving them exclusive access, is it? In other words, other 
> processes which have no particualr affinity needs can presumably still be 
> scheduled to run on the same processor. 
> 
> I am looking for something more akin to the patch I referred to...or did I miss 
> something in the effect of set_cpus_allowed()?

The NUMA scheduler work can trivially be converted into arbitrary
scheduler pools - they are not designed for dynamic modification
at the moment, but could be without too much effort I think.

Around 2.5.59 or so I posted a patch to rename them to pools, though
we had a few other things to sort out at the time. I might revive it
at some point - it's pretty simple.

M.

