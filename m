Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964979AbVJUPXN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964979AbVJUPXN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 11:23:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964982AbVJUPXN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 11:23:13 -0400
Received: from omx2-ext.sgi.com ([192.48.171.19]:43457 "EHLO omx2.sgi.com")
	by vger.kernel.org with ESMTP id S964979AbVJUPXL (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 11:23:11 -0400
Date: Fri, 21 Oct 2005 08:22:45 -0700
From: Paul Jackson <pj@sgi.com>
To: Simon Derr <Simon.Derr@bull.net>
Cc: kamezawa.hiroyu@jp.fujitsu.com, Simon.Derr@bull.net, clameter@sgi.com,
       akpm@osdl.org, kravetz@us.ibm.com, linux-kernel@vger.kernel.org,
       linux-mm@kvack.org, magnus.damm@gmail.com, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 4/4] Swap migration V3: sys_migrate_pages interface
Message-Id: <20051021082245.5c540dca.pj@sgi.com>
In-Reply-To: <Pine.LNX.4.61.0510210927140.17098@openx3.frec.bull.fr>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
	<20051020225955.19761.53060.sendpatchset@schroedinger.engr.sgi.com>
	<4358588D.1080307@jp.fujitsu.com>
	<Pine.LNX.4.61.0510210901380.17098@openx3.frec.bull.fr>
	<435896CA.1000101@jp.fujitsu.com>
	<Pine.LNX.4.61.0510210927140.17098@openx3.frec.bull.fr>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Simon wrote:
> Maybe sometimes the user would be interested in migrating all the 
> existing pages of a process, but not change the policy for the future ?

So long as the user has some reasonable right to change the affected
tasks memory layout, and so long as they are moving memory within the
cpuset constraints (if any) of the affected task, or as close to that
as practical (such as with ECC soft error avoidance), then yes, it would
seem that this sys_migrate_pages() lets existing pages be moved without
changing the cpuset policy for the future.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
