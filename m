Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267999AbTBMJfV>; Thu, 13 Feb 2003 04:35:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268000AbTBMJfV>; Thu, 13 Feb 2003 04:35:21 -0500
Received: from e34.co.us.ibm.com ([32.97.110.132]:4230 "EHLO e34.co.us.ibm.com")
	by vger.kernel.org with ESMTP id <S267999AbTBMJfR>;
	Thu, 13 Feb 2003 04:35:17 -0500
Date: Thu, 13 Feb 2003 15:20:33 +0530
From: Suparna Bhattacharya <suparna@in.ibm.com>
To: Andy Pfiffer <andyp@osdl.org>
Cc: "Eric W. Biederman" <ebiederm@xmission.com>, linux-kernel@vger.kernel.org,
       lkcd-devel@lists.sourceforge.net, fastboot@osdl.org
Subject: Re: [Fastboot] Re: Kexec on 2.5.59 problems ?
Message-ID: <20030213152033.A14278@in.ibm.com>
Reply-To: suparna@in.ibm.com
References: <3E45661A.90401@mvista.com> <m1d6m1z4bk.fsf@frodo.biederman.org> <20030210164401.A11250@in.ibm.com> <1044896964.1705.9.camel@andyp.pdx.osdl.net> <m13cmwyppx.fsf@frodo.biederman.org> <20030211125144.A2355@in.ibm.com> <1044983092.1705.27.camel@andyp.pdx.osdl.net> <1045007213.1959.2.camel@andyp.pdx.osdl.net> <m1k7g6xgs8.fsf@frodo.biederman.org> <1045089117.1502.5.camel@andyp.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1045089117.1502.5.camel@andyp.pdx.osdl.net>; from andyp@osdl.org on Wed, Feb 12, 2003 at 02:31:57PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 12, 2003 at 02:31:57PM -0800, Andy Pfiffer wrote:
> On Tue, 2003-02-11 at 20:29, Eric W. Biederman wrote:
> > Andy Pfiffer <andyp@osdl.org> writes:
> > > On Tue, 2003-02-11 at 09:04, Andy Pfiffer wrote:
> > > > On Mon, 2003-02-10 at 23:21, Suparna Bhattacharya wrote:
> > > > <snip>
> > > > > The following patch from Anton Blanchard's WIP kexec tree 
> > > > > for ppc64 seems to fix this for me. It just does a use_mm() 
> > > > > (routine from fs/aio.c) instead of switch_mm(). 
> > > > > 
> > > > > Andy could you try this out and see if it helps  ?
> > > > > 
> <snip>
> > > > > Regards
> > > > > Suparna
> > > > 
> > > > Will do. --Andy
> > > 
> > > Answer: hard lock-up after decompressing the kernel.  I'll see if I can
> > > get anything meaningful out of the system before it wedges.
> > 
> > Which kernel is wedging.  The kexec'd kernel.  Or the kernel with
> > the patch?
> > 
> > Eric
> 
> Correction: this patch is now working for me.  While pruning my .config
> to debug my serial console problem, kexec worked on a 2-way for me
> several times in a row without failure.  (I hadn't properly updated my
> script that invokes kexec with my preferred command line arguments).

Great !
Eventually we should probably avoid init_mm altogether (on ppc64
at least, init_mm can't be used as Anton pointed out to me) and
setup a spare mm instead. 

Regards
Suparna

-- 
Suparna Bhattacharya (suparna@in.ibm.com)
Linux Technology Center
IBM Software Labs, India

