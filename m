Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752054AbWCPEPS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054AbWCPEPS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 23:15:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752055AbWCPEPS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 23:15:18 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:10469 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S1752054AbWCPEPQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 23:15:16 -0500
Date: Thu, 16 Mar 2006 13:13:29 +0900
From: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] for_each_possible_cpu [1/19] defines
 for_each_possible_cpu
Message-Id: <20060316131329.1de6b9e5.kamezawa.hiroyu@jp.fujitsu.com>
In-Reply-To: <20060315194006.17dd9e24.akpm@osdl.org>
References: <20060316122110.c00f4181.kamezawa.hiroyu@jp.fujitsu.com>
	<20060315194006.17dd9e24.akpm@osdl.org>
Organization: Fujitsu
X-Mailer: Sylpheed version 2.2.0 (GTK+ 2.6.7; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Mar 2006 19:40:06 -0800
Andrew Morton <akpm@osdl.org> wrote:
> Sometimes.  Sometimes it's valid though - allocating (small amounts of)
> per-cpu storage, summing up per-cpu counters (poorly), etc.
> 
> >  -#define for_each_cpu(cpu)	  for_each_cpu_mask((cpu), cpu_possible_map)
> >  +#define for_each_possible_cpu(cpu)  for_each_cpu_mask((cpu), cpu_possible_map)
> 
> Nope, I'll change this to
> 
> #define for_each_cpu(cpu)	  for_each_cpu_mask((cpu), cpu_possible_map)
> #define for_each_possible_cpu(cpu)  for_each_cpu_mask((cpu), cpu_possible_map)
> 

Okay..It looks I was too aggressive :(
-- Kame
