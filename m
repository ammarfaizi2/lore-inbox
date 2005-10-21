Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965037AbVJUREo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965037AbVJUREo (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 13:04:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965041AbVJUREo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 13:04:44 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:26590 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965037AbVJUREn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 13:04:43 -0400
Date: Fri, 21 Oct 2005 10:03:57 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: kamezawa.hiroyu@jp.fujitsu.com, Simon.Derr@bull.net, akpm@osdl.org,
       kravetz@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       magnus.damm@gmail.com, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 4/4] Swap migration V3: sys_migrate_pages interface
Message-Id: <20051021100357.3397269e.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.62.0510210926120.23328@schroedinger.engr.sgi.com>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
	<20051020225955.19761.53060.sendpatchset@schroedinger.engr.sgi.com>
	<4358588D.1080307@jp.fujitsu.com>
	<Pine.LNX.4.61.0510210901380.17098@openx3.frec.bull.fr>
	<435896CA.1000101@jp.fujitsu.com>
	<Pine.LNX.4.62.0510210926120.23328@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> Could the cpuset_mems_allowed(task) function update the mems_allowed if 
> needed?

I'm not sure what you're thinking here.  Instead of my asking a dozen
stupid questions, I guess I should just ask you to explain what you
have in mind more.

The function call you show above has no 'mask' argument, so I don't
know what you intend to update mems_allowed to.  Currently, a task
mems_allowed is only updated in task context, from its cpusets
mems_allowed. The task mems_allowed is updated automatically coming
into the page allocation code, if the tasks mems_generation doesn't
match its cpusets mems_generation.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
