Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262071AbUIHMN4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262071AbUIHMN4 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 08:13:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261375AbUIHMNv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 08:13:51 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:12794 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S269149AbUIHMJ7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 08:09:59 -0400
Subject: Re: Generating kernel crash dumps in elf core file format
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Amit S. Kale" <amitkale@linsyssoft.com>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>, yakker@sourceforge.net,
       suparna bhattacharya <suparna@in.ibm.com>,
       Hariprasad Nellitheertha <hari@in.ibm.com>, akpm@osdl.org
In-Reply-To: <200409081719.10253.amitkale@linsyssoft.com>
References: <200409081313.28087.amitkale@linsyssoft.com>
	 <1094636955.18148.8.camel@2fwv946.in.ibm.com>
	 <200409081719.10253.amitkale@linsyssoft.com>
Content-Type: text/plain
Organization: 
Message-Id: <1094646046.18457.23.camel@2fwv946.in.ibm.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.2 (1.2.2-5) 
Date: 08 Sep 2004 17:50:47 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-08 at 17:19, Amit S. Kale wrote:
> On Wednesday 08 Sep 2004 3:20 pm, Vivek Goyal wrote:
> > Hi Amit,
> >
> > We are already working in this direction. Kexec based crash dump
> > approach exports a device interface to read/save the crash dump in elf
> > core file format and user shall be able to analyze the dumps using gdb.
> >
> > Initial set of patches were posted by Hari on LKML for review. Please
> > have a look at following thread.
> >
> > http://marc.theaimsgroup.com/?l=linux-kernel&m=109274443023485&w=2
> >
> > Very soon Hari is going to post the final set of patches to be included
> > in -mm tree.
> 
> Hi Vivek,
> 
> Nice!
> 
> Could you also tell us about the state of user level utilities required to 
> save dumps in elf format? Are they going to be available any time soon?

Hi Amit

Simple file copy commands like cp, scp can be used. No additional user
space utilities have to be written. /proc/vmcore interface itself shall
export the dump as ELF format file.

More details are available in documentation patch.

http://marc.theaimsgroup.com/?l=linux-kernel&m=109274464705867&w=2

Thanks 
Vivek
 
> 
> Thanks.
> -Amit
> 
> >
> > Thanks
> > Vivek
> >
> > On Wed, 2004-09-08 at 13:13, Amit S. Kale wrote:
> > > Hi,
> > >
> > > We are thinking of implementing the generation of linux kernel crash
> > > dumps in elf core file format. This will enable users to analyze kernel
> > > crash dumps using gdb. It should be good tool to complement KGDB. KGDB
> > > could be used during development stage for live kernel analysis and
> > > LKCD-GDB could be used with the same capabilities for analysis of
> > > customer problems and in house release testing.
> > >
> > > We would like to know if people think this will be useful or they are
> > > more comfortable with current way of kernel panic analysis using existing
> > > LKCD.
> > >
> > > Any ideas/suggestions/pointers to existing work in this area are most
> > > welcome.
> > >
> > > Thanks.
> > > -Amit Kale
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > > in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
> 
> 

