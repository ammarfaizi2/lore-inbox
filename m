Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264531AbUEDR2y@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264531AbUEDR2y (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 4 May 2004 13:28:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264532AbUEDR2y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 4 May 2004 13:28:54 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:61398 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S264531AbUEDR2x
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 4 May 2004 13:28:53 -0400
Date: Tue, 4 May 2004 14:29:41 -0300
From: Marcelo Tosatti <marcelo.tosatti@cyclades.com>
To: Christoph Hellwig <hch@infradead.org>,
       Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [RFC] Revised CKRM release
Message-ID: <20040504172941.GD11346@logos.cnet>
References: <4090BBF1.6080801@watson.ibm.com> <20040430174117.A13372@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040430174117.A13372@infradead.org>
User-Agent: Mutt/1.5.5.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 30, 2004 at 05:41:18PM +0100, Christoph Hellwig wrote:
> > The basic concepts and motivation of CKRM remain the same as described
> > in the overview at http://ckrm.sf.net. Privileged users can define
> > classes consisting of groups of kernel objects (currently tasks and
> > sockets) and specify shares for these classes. Resource controllers,
> > which are independent of each other, can regulate and monitor the
> > resources consumed by classes e.g the CPU controller will control the
> > CPU time received by a class etc. Optional classification engines,
> > implemented as kernel modules, can assist in the automatic
> > classification of the kernel objects (tasks/sockets currently) into
> > classes.
> 
> I'd still love to see practical problems this thing is solving.  It's
> a few thousand lines of code, not written to linux style guidelines,
> sometimes particularly obsfucated with callbacks all over the place.
> 
> I'd hate to see this in the kernel unless there's a very strong need
> for it and no way to solve it at a nicer layer of abstraction, e.g.
> userland virtual machines ala uml/umlinux.

I have been reading CKRM docs this week and I think something which provides the 
same functionality is required for v2.7.

I haven't read the code yet, though. It probably should be converted to 
"linux style" and simplified whenever possible.

Right now our resource-limit infrastructure is very basic and limited. CKRM 
provides advanced/fine grained resource management.
