Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261758AbTILQwc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Sep 2003 12:52:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261763AbTILQwc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Sep 2003 12:52:32 -0400
Received: from fw.osdl.org ([65.172.181.6]:33184 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S261758AbTILQw0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Sep 2003 12:52:26 -0400
Date: Fri, 12 Sep 2003 09:52:23 -0700 (PDT)
From: Judith Lebzelter <judith@osdl.org>
To: Tom Rini <trini@kernel.crashing.org>
cc: Judith Lebzelter <judith@osdl.org>, <linux-kernel@vger.kernel.org>,
       <plm-devel@lists.sourceforge.net>
Subject: Re: PowerPC Cross-compile of 2.6 kernels
In-Reply-To: <20030912150611.GE13672@ip68-0-152-218.tc.ph.cox.net>
Message-ID: <Pine.LNX.4.33.0309120906450.24847-100000@osdlab.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 12 Sep 2003, Tom Rini wrote:

> On Wed, Sep 10, 2003 at 04:41:05PM -0700, Judith Lebzelter wrote:
> > Hello,
> >
> > In response to requests at OLS, we've added cross-compile
> > capability to the PLM, and the first architecture
> > implemented is PowerPC.  The powerpc code is
> > generated via a cross-compiler set up using Dan
> > Kegels's crosstool-0.22 on an i386 host using gcc-3.3.1,
> > glibc-2.3.2 and built for the powerpc-750.
> >
> > The filter run is the compile regress developed by John
> > Cherry at OSDL.  Refer to his prior mail on lkml for the
> > results of this filter on ia386 and IA64.
> >
> > Look at
> >     http://www.osdl.org/plm-cgi/plm?module=search
> > and look up linux-2.6.0-test5 or any later kernels for the
> > results of this filter under 'PPC-Cross Compile Regress'.
> >
> > Does anyone have any input regarding requests for
> > additional architectures or improvements to the
> > filters?  Please cc me in any responses to lkml as I do
> > not currently monitor this list, though other OSDL
> > employees do.
>
> Is there any way to seed the config so that it will override what
> allmodconfig (or allyesconfig) sets?  Both of these targets by nature
> pick an 'odd' machine to compile for.
>

The 'allmodconfig' is what we run, and it chose
#
# Platform support
#
CONFIG_PPC=y
CONFIG_PPC32=y
CONFIG_6xx=y

#
# IBM 4xx options
#
CONFIG_EMBEDDEDBOOT=y
CONFIG_8260=y
CONFIG_PPC_STD_MMU=y
CONFIG_SERIAL_CONSOLE=y
# CONFIG_EST8260 is not set
# CONFIG_SBS8260 is not set
# CONFIG_RPX6 is not set
# CONFIG_TQM8260 is not set
CONFIG_WILLOW_1=y

I had to change this to do TQM8260 because the header file willow.h is
missing and the number of errors for this one file made the compile look
far worse than it actually was.  If you suggest something, I will
change it.

I also realize that my output should include any changes I make to the
configurations and have that changed right away.

We are also adding the 'allyesconfig' and will apply the same platform
changes as to 'allmodconfig'.

Thanks;

Judith
>


