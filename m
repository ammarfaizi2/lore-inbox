Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264279AbUD2MIf@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264279AbUD2MIf (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Apr 2004 08:08:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264295AbUD2MIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Apr 2004 08:08:35 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:4800 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S264279AbUD2MId (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Apr 2004 08:08:33 -0400
Date: Thu, 29 Apr 2004 17:36:41 +0530
From: Dipankar Sarma <dipankar@in.ibm.com>
To: Martin Schwidefsky <schwidefsky@de.ibm.com>
Cc: akpm@osdl.org, hch@infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] s390 (9/9): no timer interrupts in idle.
Message-ID: <20040429120641.GB3663@in.ibm.com>
Reply-To: dipankar@in.ibm.com
References: <OF8DC2156F.441E947F-ONC1256E85.002E0C3D-C1256E85.002E2DB9@de.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <OF8DC2156F.441E947F-ONC1256E85.002E0C3D-C1256E85.002E2DB9@de.ibm.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 29, 2004 at 10:24:23AM +0200, Martin Schwidefsky wrote:
> 
> > idle_cpu_mask does not really represent CPUs that are conventionally
> > called "idle", it represents the ones that have hz timer switched
> > off (in your patch). So, why not just call it nohz_cpu_mask ?
> > RCU doesn't need an idle cpu mask, it has its own mechanism
> > for detecting idle cpus, it just needs to know about the ones
> > that have hz timers switched off. If you call it nohz_cpu_mask,
> > then it would make sense to say that for systems which do not
> > switch off hz timer, nohz_cpu_mask will always be CPU_MASK_NONE.
> 
> Ok, I don't really mind the name change. It's nohz_cpu_mask then.

Thanks. Sorry about the name nitpick, I too didn't think about this
when Jan had first sent me the patch.

Dipankar
