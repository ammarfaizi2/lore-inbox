Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262964AbUCRVCb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 16:02:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262962AbUCRVCb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 16:02:31 -0500
Received: from fw.osdl.org ([65.172.181.6]:41402 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262960AbUCRVAg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 16:00:36 -0500
Date: Thu, 18 Mar 2004 12:57:33 -0800
From: "Randy.Dunlap" <rddunlap@osdl.org>
To: David Lang <david.lang@digitalinsight.com>
Cc: mingo@elte.hu, torvalds@osdl.org, hch@infradead.org, drepper@redhat.com,
       linux-kernel@vger.kernel.org, akpm@osdl.org
Subject: Re: sched_setaffinity usability
Message-Id: <20040318125733.65c1f33f.rddunlap@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0403181248440.4976@dlang.diginsite.com>
References: <40595842.5070708@redhat.com>
	<20040318112913.GA13981@elte.hu>
	<20040318120709.A27841@infradead.org>
	<Pine.LNX.4.58.0403180748070.24088@ppc970.osdl.org>
	<20040318182407.GA1287@elte.hu>
	<Pine.LNX.4.58.0403181248440.4976@dlang.diginsite.com>
Organization: OSDL
X-Mailer: Sylpheed version 0.9.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
X-Face: +5V?h'hZQPB9<D&+Y;ig/:L-F$8p'$7h4BBmK}zo}[{h,eqHI1X}]1UhhR{49GL33z6Oo!`
 !Ys@HV,^(Xp,BToM.;N_W%gT|&/I#H@Z:ISaK9NqH%&|AO|9i/nB@vD:Km&=R2_?O<_V^7?St>kW
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 18 Mar 2004 12:49:12 -0800 (PST) David Lang wrote:

| On Thu, 18 Mar 2004, Ingo Molnar wrote:
| 
| > * Linus Torvalds <torvalds@osdl.org> wrote:
| >
| > > sysconf() is a user-level implementation issue, and so is something
| > > like "number of CPU's". Damn, the simplest way to do it is as a
| > > environment variable, for christ sake! Just make a magic environment
| > > variable called __SC_ARRAY, and make it be some kind of binary
| > > encoding if you worry about performance.
| >
| > i am not arguing for any sysconf() support at all - it clearly belongs
| > into glibc. Just doing 'man sysconf' shows that it should be in
| > user-space. No argument about that.
| >
| > But how about the original issue Ulrich raised: how does user-space
| > figure out the NR_CPUS value supported by the kernel? (not the current #
| > of CPUs, that can be figured out using /proc/cpuinfo)
| 
| Doesn't /proc/config.gz answer this question?

I guess it could, but it's another CONFIG option...

--
~Randy
