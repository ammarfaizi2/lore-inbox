Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315463AbSGXJS2>; Wed, 24 Jul 2002 05:18:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315468AbSGXJS2>; Wed, 24 Jul 2002 05:18:28 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:14331 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315463AbSGXJS2>;
	Wed, 24 Jul 2002 05:18:28 -0400
Message-Id: <200207240921.g6O9LRfR050890@westrelay01.boulder.ibm.com>
User-Agent: Pan/0.11.2 (Unix)
From: "Suparna Bhattacharya" <suparna@in.ibm.com>
To: "Guillaume Boissiere" <boissiere@adiglobal.com>,
       linux-kernel@vger.kernel.org, dprobes@www-124.southbury.usf.ibm.com
Subject: Re: [STATUS 2.5]  July 24, 2002 - Dynamic Probes / Kernel Probes
Date: Wed, 24 Jul 2002 14:51:46 +0530
References: <3D3DDB50.22836.49DD0EB@localhost>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 24 Jul 2002 08:14:31 +0530, Guillaume Boissiere wrote:



> -----------------------------------
> Linux Kernel 2.5 Status  -  July 24th, 2002 (Latest kernel release is
> 2.5.27)
> 

       
>     
>  Dynamic Probes
> (Suparna Bhattacharya, dprobes team)  Beta        


The first major piece of this,which forms the core 
infrastructure for Dynamic Probes, now reworked in the 
form of a simpler minimalist patch for 2.5, based on  
suggestions and review comments from Rusty is already 
available.

It was sent to Linus by Rusty this Saturday, posted
to lkml, under the title "Kernel Probes for i386 2.5.26", 
and sort of distills the essence of the dprobes mechanism 
into a self-sufficient and more generic patch.

The patch contains the probing mechanism for kernel space 
probe points (it takes care of all the low level details 
of breakpoint + single step, including handling several 
subtle issues, tricky conditions and races) and provides 
an in-kernel interface that can be used by modules to 
register a probepoint(breakpoint) and a handler routine 
to be invoked when the probe is hit.  

We are now working on follow on patches to extend the
generic infrastructure with fine-grained serialization, 
data watchpoint probes and user space probing support,
as we have in the full-blown Dynamic Probes 
implementation.

Regards
Suparna
