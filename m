Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S275290AbTHSBCq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Aug 2003 21:02:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275278AbTHSBCp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Aug 2003 21:02:45 -0400
Received: from [66.212.224.118] ([66.212.224.118]:64008 "EHLO
	hemi.commfireservices.com") by vger.kernel.org with ESMTP
	id S275290AbTHSBCn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Aug 2003 21:02:43 -0400
Date: Mon, 18 Aug 2003 21:02:38 -0400 (EDT)
From: Zwane Mwaikambo <zwane@linuxpower.ca>
X-X-Sender: zwane@montezuma.mastecende.com
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Dave Jones <davej@redhat.com>, mpm@selenic.com, akpm@osdl.org,
       linux-kernel@vger.kernel.org
Subject: Re: Debug: sleeping function called from invalid context
In-Reply-To: <20030818171502.65d40693.rddunlap@osdl.org>
Message-ID: <Pine.LNX.4.53.0308182101540.2009@montezuma.mastecende.com>
References: <20030815101856.3eb1e15a.rddunlap@osdl.org> <20030815173246.GB9681@redhat.com>
 <20030815123053.2f81ec0a.rddunlap@osdl.org> <20030816070652.GG325@waste.org>
 <20030818140729.2e3b02f2.rddunlap@osdl.org> <20030819001316.GF22433@redhat.com>
 <20030818171502.65d40693.rddunlap@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Aug 2003, Randy.Dunlap wrote:

> | How spooky. now I got one too, (minus the noise).
> | 
> | Call Trace:
> |  [<c0120022>] __might_sleep+0x5b/0x5f
> |  [<c010cf8a>] save_v86_state+0x6a/0x1f3
> |  [<c010dad2>] handle_vm86_fault+0xa7/0x897
> |  [<c010b2ed>] do_general_protection+0x0/0x93
> |  [<c010a651>] error_code+0x2d/0x38
> |  [<c0109623>] syscall_call+0x7/0xb
> | 
> | By the looks of the logs, it happened as I restarted X, as theres
> | a bunch of mtrr messages right after this..
> 
> I don't recall mtrr messages, but it is happening just after I start
> X and the window manager with me also.

It most probably is the XFree86 video bios thing running in vm86 mode.
