Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263601AbTJCB70 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 2 Oct 2003 21:59:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263602AbTJCB70
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 2 Oct 2003 21:59:26 -0400
Received: from MAIL.13thfloor.at ([212.16.62.51]:5323 "EHLO mail.13thfloor.at")
	by vger.kernel.org with ESMTP id S263601AbTJCB7Y (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 2 Oct 2003 21:59:24 -0400
Date: Fri, 3 Oct 2003 03:59:23 +0200
From: Herbert Poetzl <herbert@13thfloor.at>
To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>
Cc: karim@opersys.com, linux-kernel@vger.kernel.org, vserver@solucorp.qc.ca
Subject: Re: [Xen-devel] Re: [ANNOUNCE] Xen high-performance x86 virtualization
Message-ID: <20031003015923.GA5080@DUK2.13thfloor.at>
Mail-Followup-To: Keir Fraser <Keir.Fraser@cl.cam.ac.uk>,
	karim@opersys.com, linux-kernel@vger.kernel.org,
	vserver@solucorp.qc.ca
References: <3F7C7180.2020404@opersys.com> <E1A58aF-0000iT-00@wisbech.cl.cam.ac.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1A58aF-0000iT-00@wisbech.cl.cam.ac.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 02, 2003 at 07:53:51PM +0100, Keir Fraser wrote:
> > 
> > Keir Fraser wrote:
> > > Full recursion needs full virtualization. Our approach offers much
> > > better performance in the situations where full virtualization isn't
> > > required -- i.e., where it's feasible to distribute a ported OS.
> > 
> > I noticed that the SOSP Xen paper briefly mentions Jacques Gelinas' work
> > on VServers (http://www.solucorp.qc.ca/miscprj/s_context.hc). While
> > Jacques' work hasn't attracted as much public attention as other Linux
> > virtualization efforts, I've personally found the approach and concepts
> > quite fascinating. Among other things, most of the code implementing the
> > contexts is architecture-independent (save for a few syscalls added to
> > arch/*/kernel/entry.S). So, thinking aloud here, I'm wondering in what
> > circumstances I'd prefer using something as architecture specific as
> > Xen over something as architecture independent as Jacques' VServers?
> > (Granted VServers can't run Windows, but I'm asking this from the angle
> > of people looking for resource isolation in the Linux context.) Among
> > other things, VServers are already in use by many ISPs to provide
> > simultaneous hosting of many "virtual machines" on the same box while
> > maintaining strict separation between machines and still providing a
> > secure environment.
> 
> One of the main differences is that we provide resource isolation, so
> that each virtual machine only gets the resources that its sponsor
> paid for. This allows companies providing virtual servers to
> provide differentiated service according to the amount paid.

although the resources are usually shared in vserver environments
(this _is_ considered an advantage) Jacques' VServers allow the
administrator to limit the resources available to each virtual
server (like memory, file handles, processes, cpu power and disk
space), which should provide similar functionality ...

best,
Herbert

>  -- Keir
