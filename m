Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161237AbVKSDav@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161237AbVKSDav (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 18 Nov 2005 22:30:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161239AbVKSDav
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 18 Nov 2005 22:30:51 -0500
Received: from [139.30.44.16] ([139.30.44.16]:44859 "EHLO
	gockel.physik3.uni-rostock.de") by vger.kernel.org with ESMTP
	id S1161237AbVKSDau (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 18 Nov 2005 22:30:50 -0500
Date: Sat, 19 Nov 2005 04:29:43 +0100 (CET)
From: Tim Schmielau <tim@physik3.uni-rostock.de>
To: Andrew Morton <akpm@osdl.org>
cc: KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com>,
       linux-kernel@vger.kernel.org
Subject: Re: compile fix 2.6.15-rc1-mm1 + EXPERIMENTAL+  CONFIG_SPARSEMEM +
 X86_PC
In-Reply-To: <20051118170744.2c852d25.akpm@osdl.org>
Message-ID: <Pine.LNX.4.63.0511190413430.20311@gockel.physik3.uni-rostock.de>
References: <437D79F3.9070301@jp.fujitsu.com> <20051118170744.2c852d25.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2005, Andrew Morton wrote:

> KAMEZAWA Hiroyuki <kamezawa.hiroyu@jp.fujitsu.com> wrote:
> > 
> > This is a compile fix for
> > X86_PC && EXPERIMENTAL && CONFIG_SPARSEMEM=y && !CONFIG_NEED_MULTIPLE_NODES
> > 
> > BTW, on x86, it looks I can select CONFIG_NUMA=y but will not set
> > CONFIG_NEED_MULTIPLE_NODES. It this expected ?
> > 
> 
> Please send me the .config.
> 

Indeed, please do. Especially as I cannot reproduce the problem here.

I did a "make allnoconfig" and then selected EXPERIMENTAL and 
CONFIG_SPARSEMEM through "make menuconfig".
This gives many "pfn to_to_nid" redefined warnings, but no error.

BTW., the warnings appear even if dont-include-schedh-from-moduleh.patch 
is backed out. Thus I plead "not guilty". ;-)

Tim
