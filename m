Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267550AbTBDXLi>; Tue, 4 Feb 2003 18:11:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267552AbTBDXLi>; Tue, 4 Feb 2003 18:11:38 -0500
Received: from fmr01.intel.com ([192.55.52.18]:24822 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267550AbTBDXLg>;
	Tue, 4 Feb 2003 18:11:36 -0500
Subject: Re: [PATCH][2.5.59-bk]Sysfs interface for ZT5550 Redundant Host
	Controller
From: Rusty Lynch <rusty@linux.co.intel.com>
To: Greg KH <greg@kroah.com>
Cc: Scott Murray <scottm@somanetworks.com>,
       lkml <linux-kernel@vger.kernel.org>,
       Stanley Wang <stanley.wang@linux.co.intel.com>
In-Reply-To: <20030204230808.GB15544@kroah.com>
References: <1044397997.1114.6.camel@vmhack> 
	<20030204230808.GB15544@kroah.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 04 Feb 2003 15:19:31 -0800
Message-Id: <1044400772.1114.12.camel@vmhack>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-02-04 at 15:08, Greg KH wrote:
> On Tue, Feb 04, 2003 at 02:33:15PM -0800, Rusty Lynch wrote:
> > Last week I finally got access to a decent (but old) technical specification
> > for the ZT5550 redundant host controller.  The document was published for
> > the ZT5550C, but I am hoping that newer versions of the RHC just add more
> > functionality to all the documented reserved bits in the document I am looking
> > at.
> > 
> > The following patch adds a sysfs interface to most of the bits accessible
> > via the indirect register (through the HCINDEX and HCDATA addresses in the
> > Command and Status Register (CSR).  The only bits I did not add access to
> > were the ones that are cleared by reading. There are a lot of bits to get 
> > access to, which makes this patch a little bigger then I first expected, 
> > so I created a new config option so only people who actually want to mess 
> > with the RHC would pay for it.
> > 
> > Enabling this code will cause a new directory called zt5550_rhc to be
> > created in the root of sysfs, with the following tree:
> 
> Ick, don't place directories in the root of sysfs, unless you want Pat
> to come after you with a big stick. 
> 
> What's wrong with putting this directory either under the pci device
> that is the zt5550 (if it is a pci device), or at the least, under the
> devices/ directory.

It was just laziness. I can create a new subsystem that isn't rooted in 
any other subsystem without any other information.  I'll go figure out
how to root this in the zt5550 device directory.

> 
> Other than that, I like your macro abuse :)
> 

Yea, one thing leads to another.  If wouldn't have stopped myself then
the entire file would have been implemented as one macro line.

> thanks,
> 
> greg k-h


