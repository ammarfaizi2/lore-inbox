Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932218AbVJCKCL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932218AbVJCKCL (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 06:02:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932224AbVJCKCK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 06:02:10 -0400
Received: from zproxy.gmail.com ([64.233.162.204]:23609 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932218AbVJCKCJ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 06:02:09 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=CKn66i62nzNq31H/SzVemRfM44USqwAl2GLG1L+JApyaoTKe/AbaHLaYdLLocYNcKWlhBJMGs5KPmHOIfQtD2CbtlaNYA7os3w6r+ttCHeRF62vszEmkzXpfj45GQZurJVVWP3cFbrmC1DL34r+q7yfzYQ1iFudTMCHxfLD7u1k=
Message-ID: <aec7e5c30510030302u8186cfer642c7b9337613de@mail.gmail.com>
Date: Mon, 3 Oct 2005 19:02:08 +0900
From: Magnus Damm <magnus.damm@gmail.com>
Reply-To: Magnus Damm <magnus.damm@gmail.com>
To: David Lang <david.lang@digitalinsight.com>
Subject: Re: [PATCH 00/07][RFC] i386: NUMA emulation
Cc: Dave Hansen <haveblue@us.ibm.com>, Magnus Damm <magnus@valinux.co.jp>,
       linux-mm <linux-mm@kvack.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0510030031170.11095@qynat.qvtvafvgr.pbz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20050930073232.10631.63786.sendpatchset@cherry.local>
	 <1128093825.6145.26.camel@localhost>
	 <aec7e5c30510021908la86daf9je0584fb0107f833a@mail.gmail.com>
	 <Pine.LNX.4.62.0510030031170.11095@qynat.qvtvafvgr.pbz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/3/05, David Lang <david.lang@digitalinsight.com> wrote:
> On Mon, 3 Oct 2005, Magnus Damm wrote:
>
> > On 10/1/05, Dave Hansen <haveblue@us.ibm.com> wrote:
> >> On Fri, 2005-09-30 at 16:33 +0900, Magnus Damm wrote:
> >>> These patches implement NUMA memory node emulation for regular i386 PC:s.
> >>>
> >>> NUMA emulation could be used to provide coarse-grained memory resource control
> >>> using CPUSETS. Another use is as a test environment for NUMA memory code or
> >>> CPUSETS using an i386 emulator such as QEMU.
> >>
> >> This patch set basically allows the "NUMA depends on SMP" dependency to
> >> be removed.  I'm not sure this is the right approach.  There will likely
> >> never be a real-world NUMA system without SMP.  So, this set would seem
> >> to include some increased (#ifdef) complexity for supporting SMP && !
> >> NUMA, which will likely never happen in the real world.
> >
> > Yes, this patch set removes "NUMA depends on SMP". It also adds some
> > simple NUMA emulation code too, but I am sure you are aware of that!
> > =)
> >
> > I agree that it is very unlikely to find a single-processor NUMA
> > system in the real world. So yes, "[PATCH 02/07] i386: numa on
> > non-smp" adds _some_ extra complexity. But because SMP is set when
> > supporting more than one cpu, and NUMA is set when supporting more
> > than one memory node, I see no reason why they should be dependent on
> > each other. Except that they depend on each other today and breaking
> > them loose will increase complexity a bit.
>
> hmm, observation from the peanut gallery, would it make sene to look at
> useing the NUMA code on single proc machines that use PAE to access more
> then 4G or ram on a 32 bit system?

Hm, maybe? =) What would you like to accomplish by that?

/ magnus
