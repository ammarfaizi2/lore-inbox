Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266095AbSKTNTo>; Wed, 20 Nov 2002 08:19:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266101AbSKTNTo>; Wed, 20 Nov 2002 08:19:44 -0500
Received: from nat-pool-rdu.redhat.com ([66.187.233.200]:42354 "EHLO
	devserv.devel.redhat.com") by vger.kernel.org with ESMTP
	id <S266095AbSKTNTl>; Wed, 20 Nov 2002 08:19:41 -0500
Date: Wed, 20 Nov 2002 08:26:35 -0500
From: Arjan van de Ven <arjanv@redhat.com>
To: Steffen Persvold <sp@scali.com>
Cc: Arjan van de Ven <arjanv@redhat.com>, Hugh Dickins <hugh@veritas.com>,
       Jun Nakajima <jun.nakajima@intel.com>, linux-kernel@vger.kernel.org
Subject: Re: [BUG?] Xeon with HyperThreading and linux-2.4.20-rc2
Message-ID: <20021120082635.C1498@devserv.devel.redhat.com>
References: <20021120080422.A1498@devserv.devel.redhat.com> <Pine.LNX.4.44.0211201417000.13800-100000@sp-laptop.isdn.scali.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.44.0211201417000.13800-100000@sp-laptop.isdn.scali.no>; from sp@scali.com on Wed, Nov 20, 2002 at 02:27:20PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, Nov 20, 2002 at 02:27:20PM +0100, Steffen Persvold wrote:
> 
> Sure, the bios has this option (and it works). I just believed the 'noht' 
> option would disable it from a kernel perspective. I understand that if 
> the MP table lists 4 processors, the kernel must think it is 4 processors 
> and enable them. But what is the purpose of the 'noht' option ? If it is 
> to avoid scanning the ACPI table for CPUs, wouldn't it be less confusing 
> to call it something like 'acpismp=disable', since you apparently can't 
> disable the siblings anyway (when they are also listed in the MP table) ?

in theory we can, at least with the O(1) scheduling infrastructure
it's easy. it's just that nobody cared enough so far to do it
