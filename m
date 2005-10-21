Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965086AbVJUS5s@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965086AbVJUS5s (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:57:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965090AbVJUS5s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:57:48 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:23986 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965086AbVJUS5s (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:57:48 -0400
Date: Fri, 21 Oct 2005 11:57:04 -0700
From: Paul Jackson <pj@sgi.com>
To: Christoph Lameter <clameter@engr.sgi.com>
Cc: kamezawa.hiroyu@jp.fujitsu.com, Simon.Derr@bull.net, akpm@osdl.org,
       kravetz@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       magnus.damm@gmail.com, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 4/4] Swap migration V3: sys_migrate_pages interface
Message-Id: <20051021115704.08d8f202.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.62.0510211125080.23833@schroedinger.engr.sgi.com>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
	<20051020225955.19761.53060.sendpatchset@schroedinger.engr.sgi.com>
	<4358588D.1080307@jp.fujitsu.com>
	<Pine.LNX.4.61.0510210901380.17098@openx3.frec.bull.fr>
	<435896CA.1000101@jp.fujitsu.com>
	<20051021081553.50716b97.pj@sgi.com>
	<43590789.1070309@jp.fujitsu.com>
	<20051021111004.757a1c77.pj@sgi.com>
	<Pine.LNX.4.62.0510211125080.23833@schroedinger.engr.sgi.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph wrote:
> Right. But the cpuset code will change the mems_allowed. The pages will 
> then be allocated in that context.

If the migration is being done as part of moving a cpuset, or moving
a task to a different cpuset, then yes the cpuset code will change
the mems_allowed.

However I thought we were discussing the sys_migrate_pages() call
here.  Naked sys_migrate_pages() calls do not involve the cpuset code,
nor change the target tasks mems_allowed.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
