Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751193AbWHKP3E@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751193AbWHKP3E (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 11 Aug 2006 11:29:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751191AbWHKP3D
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 11 Aug 2006 11:29:03 -0400
Received: from liaag2af.mx.compuserve.com ([149.174.40.157]:16572 "EHLO
	liaag2af.mx.compuserve.com") by vger.kernel.org with ESMTP
	id S1751193AbWHKP3C (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 11 Aug 2006 11:29:02 -0400
Date: Fri, 11 Aug 2006 11:24:03 -0400
From: Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: [PATCH for review] [140/145] i386: mark cpu_dev
  structures as __cpuinitdata
To: Andi Kleen <ak@suse.de>
Cc: Magnus Damm <magnus@valinux.co.jp>,
       linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <200608111126_MC3-1-C7CA-65CE@compuserve.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	 charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In-Reply-To: <20060810193740.9133413C0B@wotan.suse.de>

On Thu, 10 Aug 2006 21:37:40 +0200, Andi Kleen wrote:

> From: Magnus Damm <magnus@valinux.co.jp>
> 
> The different cpu_dev structures are all used from __cpuinit callers what
> I can tell. So mark them as __cpuinitdata instead of __initdata. I am a
> little bit unsure about arch/i386/common.c:default_cpu, especially when it
> comes to the purpose of this_cpu.

But none of these CPUs supports hotplug and only one (AMD) does SMP.
So this is just wasting space in the kernel at runtime.

If anything I would only do this for AMD.

Same for the other patch that does more of this kind of change.

(IIRC I tried to do this a while ago and was told not to.)

-- 
Chuck
