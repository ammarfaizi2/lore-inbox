Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751066AbVK3IW7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751066AbVK3IW7 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 03:22:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751128AbVK3IW7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 03:22:59 -0500
Received: from rwcrmhc12.comcast.net ([216.148.227.152]:39832 "EHLO
	rwcrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S1751066AbVK3IW7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 03:22:59 -0500
Subject: Re: [Perfctr-devel] Re: Enabling RDPMC in user space by default
From: Nicholas Miell <nmiell@comcast.net>
To: eranian@hpl.hp.com
Cc: Andi Kleen <ak@suse.de>, Ray Bryant <raybry@mpdtxmail.amd.com>,
       discuss@x86-64.org, linux-kernel@vger.kernel.org,
       perfctr-devel@lists.sourceforge.net
In-Reply-To: <20051130073831.GB7521@frankl.hpl.hp.com>
References: <200511291056.32455.raybry@mpdtxmail.amd.com>
	 <20051129180903.GB6611@frankl.hpl.hp.com>
	 <20051129181344.GN19515@wotan.suse.de> <1133300591.3271.1.camel@entropy>
	 <20051129215207.GR19515@wotan.suse.de> <1133303615.3271.12.camel@entropy>
	 <20051129224346.GS19515@wotan.suse.de> <1133305338.3271.30.camel@entropy>
	 <20051129231750.GU19515@wotan.suse.de> <1133306966.3271.36.camel@entropy>
	 <20051130073831.GB7521@frankl.hpl.hp.com>
Content-Type: text/plain
Date: Wed, 30 Nov 2005 00:22:42 -0800
Message-Id: <1133338962.3271.42.camel@entropy>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4.njm.1) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2005-11-29 at 23:38 -0800, Stephane Eranian wrote:
> Nicholas,
> 
> On Tue, Nov 29, 2005 at 03:29:26PM -0800, Nicholas Miell wrote:
> > On Wed, 2005-11-30 at 00:17 +0100, Andi Kleen wrote:
> > > On Tue, Nov 29, 2005 at 03:02:18PM -0800, Nicholas Miell wrote:
> > > > On Tue, 2005-11-29 at 23:43 +0100, Andi Kleen wrote:
> > > > > To give an bad analogy RDTSC usage in the last years is
> > > > > like explicit spinning wait loops for delays in the earlier
> > > > > times. They tended to work on some subset of computers,
> > > > > but were always bad and caused problems and people eventually learned
> > > > > it was better to use operating system services for this.
> > > > 
> > > > And you are now suggesting people should use RDPMC instead of OS
> > > > services?
> > > 
> > > For any kind of timers they should use the OS service 
> > > (gettimeofday/clock_gettime). The OS will go to extraordinary
> > > means to make it as fast as possible, but when it's slow
> > > then because it's not possible to do it faster accurately
> > > (that's the case right now modulo one possible optimization)
> > > 
> > > For cycle counting where they previously used RDTSC they should
> > > use RDPMC 0 now.
> > 
> > Well, if that's all you want them to use RDPMC 0 for, why not just make
> > PMCs programmable from userspace?
> > 
> Simply because write a PERFSEL (i.e. an MSR) register is a privileged operation.

Well, yeah. Design an API (or just steal from Solaris) and expose that
to userspace.

-- 
Nicholas Miell <nmiell@comcast.net>

