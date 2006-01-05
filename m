Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932114AbWAESof@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932114AbWAESof (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Jan 2006 13:44:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932135AbWAESof
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Jan 2006 13:44:35 -0500
Received: from nevyn.them.org ([66.93.172.17]:5010 "EHLO nevyn.them.org")
	by vger.kernel.org with ESMTP id S932114AbWAESoe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Jan 2006 13:44:34 -0500
Date: Thu, 5 Jan 2006 13:43:29 -0500
From: Daniel Jacobowitz <dan@debian.org>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Martin Bligh <mbligh@mbligh.org>, Matt Mackall <mpm@selenic.com>,
       Chuck Ebbert <76306.1226@compuserve.com>, Adrian Bunk <bunk@stusta.de>,
       Andrew Morton <akpm@osdl.org>, Ingo Molnar <mingo@elte.hu>,
       Linus Torvalds <torvalds@osdl.org>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Dave Jones <davej@redhat.com>,
       Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [patch 00/2] improve .text size on gcc 4.0 and newer  compilers
Message-ID: <20060105184329.GB15337@nevyn.them.org>
Mail-Followup-To: Arjan van de Ven <arjan@infradead.org>,
	Martin Bligh <mbligh@mbligh.org>, Matt Mackall <mpm@selenic.com>,
	Chuck Ebbert <76306.1226@compuserve.com>,
	Adrian Bunk <bunk@stusta.de>, Andrew Morton <akpm@osdl.org>,
	Ingo Molnar <mingo@elte.hu>, Linus Torvalds <torvalds@osdl.org>,
	linux-kernel <linux-kernel@vger.kernel.org>,
	Dave Jones <davej@redhat.com>,
	Tim Schmielau <tim@physik3.uni-rostock.de>
References: <200601041959_MC3-1-B550-5EE2@compuserve.com> <43BC716A.5080204@mbligh.org> <1136463553.2920.22.camel@laptopd505.fenrus.org> <20060105170255.GK3356@waste.org> <43BD5E6F.1040000@mbligh.org> <1136484577.2920.56.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1136484577.2920.56.camel@laptopd505.fenrus.org>
User-Agent: Mutt/1.5.8i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 05, 2006 at 07:09:36PM +0100, Arjan van de Ven wrote:
> 
> > There are tools already around to do this sort of thing as well - 
> > "profile directed optimization" or whatever they called it. Seems to be 
> > fairly commonly done with userspace, but not with the kernel. I'm not 
> > sure why not ... possibly because it's not available for gcc ?
> 
> gcc has this for sure
> the problem is that it expects the profile info in a special format
> that.. gets written to a file. So to do it in the kernel you need
> SomeMagic(tm), for example to use the kernel profiler but to let it
> output it somehow in a gcc compatible format.

Right - at some point I remember a discussion of nifty Eclipse plugins
to allow test runs on a custom workload and rebuild with feedback,
but it never materialized.

-- 
Daniel Jacobowitz
CodeSourcery
