Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263277AbTDLOm4 (for <rfc822;willy@w.ods.org>); Sat, 12 Apr 2003 10:42:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263279AbTDLOm4 (for <rfc822;linux-kernel-outgoing>);
	Sat, 12 Apr 2003 10:42:56 -0400
Received: from franka.aracnet.com ([216.99.193.44]:32481 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S263277AbTDLOmz (for <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Apr 2003 10:42:55 -0400
Date: Sat, 12 Apr 2003 07:54:31 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Antonio Vargas <wind@cocodriloo.com>, "Shaheed R. Haque" <srhaque@iee.org>
cc: linux-kernel@vger.kernel.org, thockin@isunix.it.ilstu.edu
Subject: Re: Processor sets (pset) for linux kernel 2.5/2.6?
Message-ID: <237660000.1050159270@[10.10.2.4]>
In-Reply-To: <20030412122422.GB9125@wind.cocodriloo.com>
References: <1050146434.3e97f68300fff@netmail.pipex.net> <20030412122422.GB9125@wind.cocodriloo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> HT is accounted as a NUMA SMP system with strong memory affinity
> for his 2 cores, so that when running 2 HT processors (2+2 cores),
> the tasks are kept preferably on the same HT processor and just bounce
> cores, since they share the same cache (don't know exactly L1, L2 or
> both, tough).

We don't actually do that right now (though it was discussed) - we treat it 
as flat SMP. Ingo had some patches to share 1 runqueue between each HT pair, 
which I think is a better plan for this, but we're not seeing much 
performance improvment from it.

M.

