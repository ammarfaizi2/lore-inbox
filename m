Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261234AbTILVcs (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 17:32:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261282AbTILVcr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 17:32:47 -0400
Received: from fed1mtao06.cox.net ([68.6.19.125]:64141 "EHLO
	fed1mtao06.cox.net") by vger.kernel.org with ESMTP id S261234AbTILVcp
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 17:32:45 -0400
Date: Fri, 12 Sep 2003 14:32:43 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Judith Lebzelter <judith@osdl.org>
Cc: linux-kernel@vger.kernel.org, plm-devel@lists.sourceforge.net
Subject: Re: PowerPC Cross-compile of 2.6 kernels
Message-ID: <20030912213243.GB22885@ip68-0-152-218.tc.ph.cox.net>
References: <20030912165635.GJ13672@ip68-0-152-218.tc.ph.cox.net> <Pine.LNX.4.33.0309121042310.29740-100000@osdlab.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.33.0309121042310.29740-100000@osdlab.pdx.osdl.net>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 12, 2003 at 01:13:48PM -0700, Judith Lebzelter wrote:
> On Fri, 12 Sep 2003, Tom Rini wrote:
> 
> > On Fri, Sep 12, 2003 at 09:52:23AM -0700, Judith Lebzelter wrote:
> >
> > > On Fri, 12 Sep 2003, Tom Rini wrote:
> > >
> > > > On Wed, Sep 10, 2003 at 04:41:05PM -0700, Judith Lebzelter wrote:
> > > > > Hello,
> > > > >
> > > > > In response to requests at OLS, we've added cross-compile
> > > > > capability to the PLM, and the first architecture
> > > > > implemented is PowerPC.  The powerpc code is
> > > > > generated via a cross-compiler set up using Dan
> > > > > Kegels's crosstool-0.22 on an i386 host using gcc-3.3.1,
> > > > > glibc-2.3.2 and built for the powerpc-750.
> > > > >
> > > > > The filter run is the compile regress developed by John
> > > > > Cherry at OSDL.  Refer to his prior mail on lkml for the
> > > > > results of this filter on ia386 and IA64.
> > > > >
> > > > > Look at
> > > > >     http://www.osdl.org/plm-cgi/plm?module=search
> > > > > and look up linux-2.6.0-test5 or any later kernels for the
> > > > > results of this filter under 'PPC-Cross Compile Regress'.
> > > > >
> > > > > Does anyone have any input regarding requests for
> > > > > additional architectures or improvements to the
> > > > > filters?  Please cc me in any responses to lkml as I do
> > > > > not currently monitor this list, though other OSDL
> > > > > employees do.
> > > >
> > > > Is there any way to seed the config so that it will override what
> > > > allmodconfig (or allyesconfig) sets?  Both of these targets by nature
> > > > pick an 'odd' machine to compile for.
> > > >
> > >
> > > The 'allmodconfig' is what we run, and it chose
> > > #
> > > # Platform support
> > > #
> > > CONFIG_PPC=y
> > > CONFIG_PPC32=y
> > > CONFIG_6xx=y
> > >
> > > #
> > > # IBM 4xx options
> > > #
> > > CONFIG_EMBEDDEDBOOT=y
> > > CONFIG_8260=y
> > > CONFIG_PPC_STD_MMU=y
> > > CONFIG_SERIAL_CONSOLE=y
> > > # CONFIG_EST8260 is not set
> > > # CONFIG_SBS8260 is not set
> > > # CONFIG_RPX6 is not set
> > > # CONFIG_TQM8260 is not set
> > > CONFIG_WILLOW_1=y
> > >
> > > I had to change this to do TQM8260 because the header file willow.h is
> > > missing and the number of errors for this one file made the compile look
> > > far worse than it actually was.  If you suggest something, I will
> > > change it.
> >
> > Don't select 8260 at all, and then the default choice should be
> > CONFIG_PPC_MULTIPLATFORM, which is normally the best choice.
> >
> 
> I have changed it.  Thanks for the input.

Okay.  And this motivated me to fix the root issue, and make 8260 be
just another classic PPC set of boards.  I'll let you know when this
gets into Linus' tree.

-- 
Tom Rini
http://gate.crashing.org/~trini/
