Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263466AbTJBSyV (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 14:54:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263460AbTJBSx5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 14:53:57 -0400
Received: from mta1.cl.cam.ac.uk ([128.232.0.15]:63377 "EHLO
	wisbech.cl.cam.ac.uk") by vger.kernel.org with ESMTP
	id S263463AbTJBSxz (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 14:53:55 -0400
To: karim@opersys.com
cc: linux-kernel@vger.kernel.org
Subject: Re: [Xen-devel] Re: [ANNOUNCE] Xen high-performance x86 virtualization 
In-Reply-To: Your message of "Thu, 02 Oct 2003 14:42:08 EDT."
             <3F7C7180.2020404@opersys.com> 
Date: Thu, 02 Oct 2003 19:53:51 +0100
From: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Message-Id: <E1A58aF-0000iT-00@wisbech.cl.cam.ac.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> Keir Fraser wrote:
> > Full recursion needs full virtualization. Our approach offers much
> > better performance in the situations where full virtualization isn't
> > required -- i.e., where it's feasible to distribute a ported OS.
> 
> I noticed that the SOSP Xen paper briefly mentions Jacques Gelinas' work
> on VServers (http://www.solucorp.qc.ca/miscprj/s_context.hc). While
> Jacques' work hasn't attracted as much public attention as other Linux
> virtualization efforts, I've personally found the approach and concepts
> quite fascinating. Among other things, most of the code implementing the
> contexts is architecture-independent (save for a few syscalls added to
> arch/*/kernel/entry.S). So, thinking aloud here, I'm wondering in what
> circumstances I'd prefer using something as architecture specific as
> Xen over something as architecture independent as Jacques' VServers?
> (Granted VServers can't run Windows, but I'm asking this from the angle
> of people looking for resource isolation in the Linux context.) Among
> other things, VServers are already in use by many ISPs to provide
> simultaneous hosting of many "virtual machines" on the same box while
> maintaining strict separation between machines and still providing a
> secure environment.

One of the main differences is that we provide resource isolation, so
that each virtual machine only gets the resources that its sponsor
paid for. This allows companies providing virtual servers to
provide differentiated service according to the amount paid.

 -- Keir
