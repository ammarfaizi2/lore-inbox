Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965042AbVJURHB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965042AbVJURHB (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 13:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965036AbVJURG7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 13:06:59 -0400
Received: from omx1-ext.sgi.com ([192.48.179.11]:29635 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S965039AbVJURG6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 13:06:58 -0400
Date: Fri, 21 Oct 2005 10:06:34 -0700 (PDT)
From: Christoph Lameter <clameter@engr.sgi.com>
To: Paul Jackson <pj@sgi.com>
cc: kamezawa.hiroyu@jp.fujitsu.com, Simon.Derr@bull.net, akpm@osdl.org,
       kravetz@us.ibm.com, linux-kernel@vger.kernel.org, linux-mm@kvack.org,
       magnus.damm@gmail.com, marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 4/4] Swap migration V3: sys_migrate_pages interface
In-Reply-To: <20051021100357.3397269e.pj@sgi.com>
Message-ID: <Pine.LNX.4.62.0510211005090.23359@schroedinger.engr.sgi.com>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
 <20051020225955.19761.53060.sendpatchset@schroedinger.engr.sgi.com>
 <4358588D.1080307@jp.fujitsu.com> <Pine.LNX.4.61.0510210901380.17098@openx3.frec.bull.fr>
 <435896CA.1000101@jp.fujitsu.com> <Pine.LNX.4.62.0510210926120.23328@schroedinger.engr.sgi.com>
 <20051021100357.3397269e.pj@sgi.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Oct 2005, Paul Jackson wrote:

> know what you intend to update mems_allowed to.  Currently, a task
> mems_allowed is only updated in task context, from its cpusets
> mems_allowed. The task mems_allowed is updated automatically coming
> into the page allocation code, if the tasks mems_generation doesn't
> match its cpusets mems_generation.

Therefore if mems_allowed is accessed from outside of the 
task then it may not be up to date, right?


