Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263693AbTDYUuA (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Apr 2003 16:50:00 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263985AbTDYUuA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Apr 2003 16:50:00 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:3085 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263693AbTDYUt6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Apr 2003 16:49:58 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: TASK_UNMAPPED_BASE & stack location
Date: 25 Apr 2003 14:01:44 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b8c7no$u59$1@cesium.transmeta.com>
References: <459930000.1051302738@[10.10.2.4]>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <459930000.1051302738@[10.10.2.4]>
By author:    "Martin J. Bligh" <mbligh@aracnet.com>
In newsgroup: linux.dev.kernel
>
> Is there any good reason we can't remove TASK_UNMAPPED_BASE, and just shove
> libraries directly above the program text? Red Hat seems to have patches to
> dynamically tune it on a per-processes basis anyway ...
> 
> Moreover, can we put the stack back where it's meant to be, below the
> program text, in that wasted 128MB of virtual space? Who really wants 
> > 128MB of stack anyway (and can't fix their app)?
> 

That space is NULL pointer trap zone.  NULL pointer trapping -> good.

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
