Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262100AbSJVEJF>; Tue, 22 Oct 2002 00:09:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262112AbSJVEJF>; Tue, 22 Oct 2002 00:09:05 -0400
Received: from e3.ny.us.ibm.com ([32.97.182.103]:4603 "EHLO e3.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S262100AbSJVEJD>;
	Tue, 22 Oct 2002 00:09:03 -0400
Subject: Re: Kernel Probes - Is this the same as dynamic probes?
From: "Suparna Bhattacharya" <suparna@sparklet.in.ibm.com>
Date: Tue, 22 Oct 2002 15:09:17 +0530
Message-Id: <pan.2002.10.22.15.09.17.212128.1768@sparklet.in.ibm.com>
References: <20021022032409.GA26557@gorgor.wingnux.com>
X-Comment-To: "Mike Grundy" <grund@wingnux.com>
Pan-Reverse-Path: suparna@sparklet.in.ibm.com
Pan-Mail-To: Mike Grundy <grund@wingnux.com>
Pan-Server: ibm-ltc
Organization: IBM
Pan-Attribution: On Tue, 22 Oct 2002 08:58:48 +0530, Mike Grundy wrote:
To: undisclosed-recipients:;
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 22 Oct 2002 08:58:48 +0530, Mike Grundy wrote:

> Hi Folks -
> 
> Rob posed the question in his merge candidate list. Kprobes is an api
> for placing arbitrary break (probes) points in kernel code and provides
> for handlers (your function) to execute before and after the probed
> instruction is executed.
> 
> Dynamic probes on the other hand does the same thing ;-)
> 
> Vamsi and co. designed kprobes to provide the core of the dprobes
> engine: probe point management and insertion, probe point interrupt
> handler, and post interrupt clean up (replacing the original
> instruction, single stepping it and then putting the probe back) in a
> lightweight patch so that it would be more palitable for inclusion in
> the kernel.
> 
> The next version of dprobes could use the api as well as any module
> thrown together to debug a problem (without having to reboot).
> 
> Anyway getting back to my quip about dprobes doing the same thing,
> dprobes can put probes in kernel or userland code, has a debug engine we
> call the dprobes_interpreter that runs probe point handler programs
> (kind of pseudo assembler programs) that can change / record register
> values, change / record memory locations, core the process or call LKCD
> and much more.
> 
> kprobes doesn't have two things (IIRC) it needs to handle userland probe
> points, I don't know if this was a planned addition or if Vamsi figured
> out a way to handle it within the existing kprobes api.

Yes there's a patch to add user space probes enablement to kprobes which
Vamsi should be posting shortly along with patches for watchpoint
support using debug registers (he'll be back in office later today). 

> 
> dprobes has support for i386, s390, s390x, ppc and ppc64. kprobes has
> i386 support right now, and after we review and beat upon the code I
> posted to the dprobes list tonight, we'll have s390 and s390x support as
> well.
> 
> Comments welcome.
> 
> Thanks
> Mike
> 
> --
> If we blow up, whatever's left of me is kicking your butt! - To
> unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org More majordomo info
> at  http://vger.kernel.org/majordomo-info.html Please read the FAQ at 
> http://www.tux.org/lkml/
