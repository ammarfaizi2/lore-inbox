Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264594AbUANTu1 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jan 2004 14:50:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264591AbUANTuZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jan 2004 14:50:25 -0500
Received: from fed1mtao08.cox.net ([68.6.19.123]:53469 "EHLO
	fed1mtao08.cox.net") by vger.kernel.org with ESMTP id S264830AbUANTtx
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jan 2004 14:49:53 -0500
Date: Wed, 14 Jan 2004 12:49:42 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Cc: mpm@selenic.com, linux-kernel@vger.kernel.org, zaitcev@redhat.com
Subject: Re: [patch] arch-specific cond_syscall usage issues
Message-ID: <20040114194942.GC17509@stop.crashing.org>
References: <20040110032915.GW18208@waste.org> <20040109193753.3c158b3b.akpm@osdl.org> <20040114161306.GA16950@stop.crashing.org> <20040114113107.786c237a.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040114113107.786c237a.akpm@osdl.org>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 14, 2004 at 11:31:07AM -0800, Andrew Morton wrote:

> Tom Rini <trini@kernel.crashing.org> wrote:
> >
> >  As has been previously noted, the cond_syscall is only ever cared about
> >  on PPC when you try for !PCI.  And this only happens realistically now,
> >  on MPC8xx (it's usually present on IBM 4xx, and lets ignore APUS).
> >  MPC8xx support has been broken for a while, but hopefully will get fixed
> >  'soon'.
> > 
> >  So can we please move this cond_syscall into kernel/sys.c ?
> 
> Spose so.  Are we sure it shouldn't be inside soem ppc-specfic ifdef?

At an extreme space concern it could be covered in a PPC32 || ALPHA
test.  It should do no harm if it's not.

-- 
Tom Rini
http://gate.crashing.org/~trini/
