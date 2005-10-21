Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965064AbVJUSKe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965064AbVJUSKe (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 14:10:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965059AbVJUSKe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 14:10:34 -0400
Received: from omx3-ext.sgi.com ([192.48.171.20]:39062 "EHLO omx3.sgi.com")
	by vger.kernel.org with ESMTP id S965062AbVJUSKd (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 14:10:33 -0400
Date: Fri, 21 Oct 2005 11:10:04 -0700
From: Paul Jackson <pj@sgi.com>
To: Kamezawa Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
Cc: Simon.Derr@bull.net, clameter@sgi.com, akpm@osdl.org, kravetz@us.ibm.com,
       linux-kernel@vger.kernel.org, linux-mm@kvack.org, magnus.damm@gmail.com,
       marcelo.tosatti@cyclades.com
Subject: Re: [PATCH 4/4] Swap migration V3: sys_migrate_pages interface
Message-Id: <20051021111004.757a1c77.pj@sgi.com>
In-Reply-To: <43590789.1070309@jp.fujitsu.com>
References: <20051020225935.19761.57434.sendpatchset@schroedinger.engr.sgi.com>
	<20051020225955.19761.53060.sendpatchset@schroedinger.engr.sgi.com>
	<4358588D.1080307@jp.fujitsu.com>
	<Pine.LNX.4.61.0510210901380.17098@openx3.frec.bull.fr>
	<435896CA.1000101@jp.fujitsu.com>
	<20051021081553.50716b97.pj@sgi.com>
	<43590789.1070309@jp.fujitsu.com>
Organization: SGI
X-Mailer: Sylpheed version 2.0.0beta5 (GTK+ 2.4.9; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kame wroteL
> I'm just afraid of swapped-out pages will goes back to original nodes

The pages could end up there, yes, if that's where they are faulted
back into.

In general, the swap-based migration method does not guarantee
where the pages will end up.  The more difficult direct node-to-node
migration method will be needed to guarantee that.

-- 
                  I won't rest till it's the best ...
                  Programmer, Linux Scalability
                  Paul Jackson <pj@sgi.com> 1.925.600.0401
