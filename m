Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267818AbUJDPAM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267818AbUJDPAM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Oct 2004 11:00:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268157AbUJDPAM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Oct 2004 11:00:12 -0400
Received: from jade.aracnet.com ([216.99.193.136]:7397 "EHLO
	jade.spiritone.com") by vger.kernel.org with ESMTP id S267818AbUJDPAE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Oct 2004 11:00:04 -0400
Date: Mon, 04 Oct 2004 07:57:40 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Erich Focht <efocht@hpce.nec.com>, Andrew Morton <akpm@osdl.org>
cc: pj@sgi.com, nagar@watson.ibm.com, ckrm-tech@lists.sourceforge.net,
       lse-tech@lists.sourceforge.net, hch@infradead.org, steiner@sgi.com,
       jbarnes@sgi.com, sylvain.jeaugey@bull.net, djh@sgi.com,
       linux-kernel@vger.kernel.org, colpatch@us.ibm.com, Simon.Derr@bull.net,
       ak@suse.de, sivanich@sgi.com
Subject: Re: [Lse-tech] [PATCH] cpusets - big numa cpu and memory placement
Message-ID: <842970000.1096901859@[10.10.2.4]>
In-Reply-To: <200410041605.30395.efocht@hpce.nec.com>
References: <20040805100901.3740.99823.84118@sam.engr.sgi.com> <200410032221.26683.efocht@hpce.nec.com> <20041003134842.79270083.akpm@osdl.org> <200410041605.30395.efocht@hpce.nec.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> My optimistic assumption that it is easy to build cpusets into CKRM is
> only valid for adding a cpuset controller into the CKRM framework and
> forgetting about the other controllers. The problems start with the
> other controllers... As Hubertus said: CKRM and cpusets are
> orthogonal.
> 
> Now CKRM consists of a set of more or less independent (orthogonal)
> controllers. There is a cpu cycles and memory controller. Their aims
> are different from that of cpuset and they cannot fulfil the
> requirements of cpusets. But they make sense for themselves.
 ...

> If CKRM wants to be a universal resource controller in the kernel then
> a resource dependency tree and hierarchy might need to get somehow
> into the CKRM infrastructure. The cpu cycles controller should notice
> that there is another controller above it (cpusets) and might ask
> that controller which processes it should take into account for its
> job. The memory controller might get a different answer... Uhmmm, this
> looks like a difficult problem.

I see that the two mechanisms could have conflicting requirements. But
surely this is the case whether we merge the two into one integrated
system, or try to run CKRM and cpusets independantly at the same time? 
I'd think the problems would be easier to tackle if the systems knew
about each other, and talked to each other.

I don't think anyone is suggesting that either system as is could replace
the other ... more that a combined system could be made for both types
of resource control that would be a better overall solution.

M.

