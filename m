Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261816AbVHDFLg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261816AbVHDFLg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 4 Aug 2005 01:11:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVHDFLg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 4 Aug 2005 01:11:36 -0400
Received: from mail03.syd.optusnet.com.au ([211.29.132.184]:39318 "EHLO
	mail03.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S261816AbVHDFLa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 4 Aug 2005 01:11:30 -0400
From: Con Kolivas <kernel@kolivas.org>
To: Jan De Luyck <lkml@kcore.org>
Subject: Re: [PATCH] i386 No-Idle-Hz aka Dynamic-Ticks 3
Date: Thu, 4 Aug 2005 15:07:03 +1000
User-Agent: KMail/1.8.1
Cc: linux-kernel@vger.kernel.org, ck@vds.kolivas.org, tony@atomide.com,
       tuukka.tikkanen@elektrobit.com
References: <200508031559.24704.kernel@kolivas.org> <200508040709.19426.lkml@kcore.org>
In-Reply-To: <200508040709.19426.lkml@kcore.org>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-15"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200508041507.03562.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 4 Aug 2005 03:09 pm, Jan De Luyck wrote:
> On Wednesday 03 August 2005 07:59, Con Kolivas wrote:
> > This is the dynamic ticks patch for i386 as written by Tony Lindgen
> > <tony@atomide.com> and Tuukka Tikkanen <tuukka.tikkanen@elektrobit.com>.
> > Patch for 2.6.13-rc5
>
> On a weird sidenote: my synaptics touchpad seems to not-like dyntick very
> much. When starting with a dyntick enabled kernel I get when psmouse.ko is
> loaded:
>
> Aug  4 06:45:47 precious kernel: Synaptics claims to have extended
> capabilities, but I'm not able to read them.<3>Unable to initialize
> Synaptics hardware. Aug  4 06:45:47 precious kernel: input: PS/2 Synaptics
> TouchPad on isa0060/serio1
>
> subsequently, X fails to start too (touchpad is set as corepointer)
>
> reloading the module right then and there solves the problem:
>
> Aug  4 06:47:47 precious kernel: Synaptics Touchpad, model: 1, fw: 5.8, id:
> 0x9d48b1, caps: 0x904713/0x4006 Aug  4 06:47:47 precious kernel: input:
> SynPS/2 Synaptics TouchPad on isa0060/serio1
>
> Also, booting the same (but non-patched) kernel gives me a clean boot:
>
> Aug  4 06:56:42 precious kernel: Synaptics Touchpad, model: 1, fw: 5.8, id:
> 0x9d48b1, caps: 0x904713/0x4006 Aug  4 06:56:42 precious kernel: input:
> SynPS/2 Synaptics TouchPad on isa0060/serio1
>
> This is constantly reproducable for me. I guess some timing issue
> somewhere?

Did you try without the apic option or disable it at runtime? The apic option 
is proving more problems than not so far for people that have tried it.

Cheers,
Con
