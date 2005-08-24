Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932508AbVHXAWI@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932508AbVHXAWI (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Aug 2005 20:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932506AbVHXAWH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Aug 2005 20:22:07 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:31172 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S932471AbVHXAWH (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Aug 2005 20:22:07 -0400
Message-ID: <01de01c5a841$71ed60d0$6900a8c0@comcast.net>
From: "John Hawkes" <hawkes@sgi.com>
To: "Paul Jackson" <pj@sgi.com>, "Andrew Morton" <akpm@osdl.org>
Cc: <nickpiggin@yahoo.com.au>, <linux-ia64@vger.kernel.org>,
       <linux-kernel@vger.kernel.org>, <torvalds@osdl.org>, <mingo@elte.hu>,
       "Paul Jackson" <pj@sgi.com>, <dino@in.ibm.com>
References: <20050823080427.14740.20177.sendpatchset@jackhammer.engr.sgi.com>
Subject: Re: [PATCH 2.6.13-rc6] cpu_exclusive sched domains on partial nodes temp fix
Date: Tue, 23 Aug 2005 17:19:07 -0700
MIME-Version: 1.0
Content-Type: text/plain;
	charset="Windows-1252"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.00.2919.6600
X-MimeOLE: Produced By Microsoft MimeOLE V5.00.2919.6600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> + for_each_cpu_mask(i, cur->cpus_allowed) {
> + for_each_cpu_mask(j, node_to_cpumask(cpu_to_node(i))) {
> + if (!cpu_isset(j, cur->cpus_allowed))
> + return;

Looks good to me.
Feel free to add:
Acked-by: John Hawkes <hawkes@sgi.com>


John Hawkes

