Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265271AbUFXOGJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265271AbUFXOGJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 10:06:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265290AbUFXOGJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 10:06:09 -0400
Received: from holomorphy.com ([207.189.100.168]:65161 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S265271AbUFXOGE (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 10:06:04 -0400
Date: Thu, 24 Jun 2004 07:05:39 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Andi Kleen <ak@muc.de>
Cc: Yusuf Goolamabbas <yusufg@outblaze.com>, linux-kernel@vger.kernel.org
Subject: Re: finish_task_switch high in profiles in 2.6.7
Message-ID: <20040624140539.GT1552@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Andi Kleen <ak@muc.de>, Yusuf Goolamabbas <yusufg@outblaze.com>,
	linux-kernel@vger.kernel.org
References: <2ayz2-1Um-15@gated-at.bofh.it> <m3n02tz203.fsf@averell.firstfloor.org> <20040624104416.GB8798@outblaze.com> <20040624113608.GA31080@colin2.muc.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040624113608.GA31080@colin2.muc.de>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 24, 2004 at 01:36:08PM +0200, Andi Kleen wrote:
> Sounds like a inferior clone of dprobes to me. But I doubt it 
> would help tracking this down.

The schedprof thing I wrote to track down the source of context
switches during database creation may prove useful, since it has
at least demonstrated where thundering herds came from properly once
before and is damn near idiotproof -- it requires no more than
readprofile(1) from userspace. I'll dredge that up again and maybe
we'll see if it helps here. It will also properly point to
sys_sched_yield() and the like in the event of badly-behaved userspace.


-- wli
