Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261934AbVAUBYj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261934AbVAUBYj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 20 Jan 2005 20:24:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262191AbVAUBYj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 20 Jan 2005 20:24:39 -0500
Received: from omx2-ext.sgi.com ([192.48.171.19]:52384 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S261934AbVAUBYh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 20 Jan 2005 20:24:37 -0500
From: Limin Gu <limin@dbear.engr.sgi.com>
Message-Id: <200501210124.j0L1OUE22333@dbear.engr.sgi.com>
Subject: Re: [patch] Job - inescapable job containers
To: akpm@osdl.org (Andrew Morton)
Date: Thu, 20 Jan 2005 17:24:30 -0800 (PST)
Cc: linux-kernel@vger.kernel.org, lse-tech@lists.sourceforge.net,
       limin@dbear.engr.sgi.com (Limin Gu)
In-Reply-To: <20050119170628.2429c41e.akpm@osdl.org> from "Andrew Morton" at Jan 19, 2005 05:06:28 PM
X-Mailer: ELM [version 2.5 PL3]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> I'm totally not in a position to evaluate the completeness, desirability,
> interest-level, etc of this patch, I'm afraid.  This is an opportunity for
> other stakeholders to weigh in..

Thanks Andrew!

First, Job can work as a standalone kernel module.
The current implementation provides the inescapable job container.
Job provides global unique Job ID (jid) to processes in a cluster
environment. Job initiation on Linux is performed via a PAM session
module with authentication and security checks. Root level processes,
or those with the CAP_SYS_RESOURCE capability, can create new jobs
or escape from a job.

Second, Job based batch schedulers or resource limit tools can take the
advantage of the process control ability Job provides.

Thrid, Job provides a registion mechanism to various accounting modules
for setting and getting job based accounting information.
CSA (Comprehensive System Accounting) is one example of the accounting
modules, (CSA code maintainer Jay Lan is currently on vacation, he will
be back at Feb. 1).

We are pushing Job to linux kernel. If anybody has been using Job in your
open source software, please respond to show the desirability and
interest-level for Job, and we highly appreciate your suggestion on its 
completeness as well.

Thank you!

--Limin
