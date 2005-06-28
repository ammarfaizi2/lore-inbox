Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261378AbVF1URa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261378AbVF1URa (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 28 Jun 2005 16:17:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261356AbVF1URE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 28 Jun 2005 16:17:04 -0400
Received: from wproxy.gmail.com ([64.233.184.202]:31070 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S261264AbVF1UN7 convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 28 Jun 2005 16:13:59 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=GiSwhCiHfp/z6EyN/6Y4+yUyiNuoCsSseY8cG2Z4YP9YlrYZpVqaWs7CfvVEtWybh7gVpChC5E9FNR42ZCQWYSi+M+fcu5TYPZDXdgc7aotgB1s1WXn7zMTY7d1MwWZMW6YO8HjiElrwmdWdeJ+lDeb1Xfb55BMCF4ol8m5r7Hk=
Message-ID: <94e67edf05062813131fbe6638@mail.gmail.com>
Date: Tue, 28 Jun 2005 16:13:58 -0400
From: Sreeni <sreeni.pulichi@gmail.com>
Reply-To: Sreeni <sreeni.pulichi@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Memory Management during Program Loading
In-Reply-To: <94e67edf050628122441f6178@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <94e67edf05062810497c7a20b5@mail.gmail.com>
	 <200506281800.j5SI0FEe011475@turing-police.cc.vt.edu>
	 <94e67edf0506281112545d4766@mail.gmail.com>
	 <200506281858.j5SIw2dr013640@turing-police.cc.vt.edu>
	 <94e67edf05062812096ece6cf7@mail.gmail.com>
	 <94e67edf050628122441f6178@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

 We need the code in the physical memory area which the bus analyzer can see.
 Basically we need to get the right "code" and "data" segment into that
 bus analyzer/monitor activated physical area.
 
 thanks,
 
 Sreeni
 
> >>>>
> 
> Or is the *real* question here "We have a bus analyzer that can't see all of
> the physical memory, so we need the code we're interested in to be in the
> part of physical memory it can see"?  If that's the case, totally different
> answers will probably apply (as we don't have to do things in a "secure" manner,
> we just need to get the right pages in the right frames before the analyzer is
> turned on).....
> 
> >>>
> 
> On 6/28/05, Sreeni <sreeni.pulichi@gmail.com> wrote:
> > My main aim is to run a particular application in a known and fixed
> > physical memory location. When kernel loads this binary, is there a
> > way to force it to load at that fixed memory location. For example I
> > always wanna run a program "hello_world.bin" from physical address
> > location 0x007F_0000 to 0x007F_FFFF. I want my data, stack etc to be
> > in this location only.
> >
> > The word "secure" is our internal terminology which seems to be bit confusing.
> >
> > Thanks
> > Sreeni
> >
> > On 6/28/05, Valdis.Kletnieks@vt.edu <Valdis.Kletnieks@vt.edu> wrote:
> > > On Tue, 28 Jun 2005 14:12:43 EDT, Sreeni said:
> > >
> > > > We have a "Bus Monitor hardware" which monitors and polices the bus at
> > > > the specified physical address.
> > >
> > > What does this hardware do, exactly, in addition to the usual memory-protection
> > > capabilities of the main processor?  I suspect the answer to your query will
> > > depend largely on what your monitor does, exactly, and what capabilities
> > > it has, and what threat model you're trying to secure against....
> > >
> > > > Basically we need to run "secure" program under the supervision of the
> > > > Bus monitor hardware.
> > >
> > > Is there an actual "threat model" here, as in "the attacker might try XYZ,
> > > and this monitor is a defense because it does ABC, rendering XYZ ineffective"?
> > >
> > > I'm unclear on how the monitor can provide any *real* security when it quite
> > > likely does *not* have access to the entire state of the system (in particular,
> > > if there's a security-critical value that's still in a CPU register or L1
> > > cache line...)
> > >
> > > > Kernel can see the "secure" memory region, and kernel is reponsible for enabling
> > > > the "Bus monitor Hardware".
> > >
> > > The problem is that you're using an unsecured kernel to initially load the secure
> > > memory region - so an attacker is free to load broken code into the secure
> > > area.  The usual "trusted system" solution for this is to ensure that the kernel
> > > *also* runs inside the tamper-proof evironment....
> > >
> > > Or is the *real* question here "We have a bus analyzer that can't see all of
> > > the physical memory, so we need the code we're interested in to be in the
> > > part of physical memory it can see"?  If that's the case, totally different
> > > answers will probably apply (as we don't have to do things in a "secure" manner,
> > > we just need to get the right pages in the right frames before the analyzer is
> > > turned on).....
> > >
> > >
> > >
> >
> >
> > --
> > ~Sreeni
> >       -iDream
> >
> 
> 
> --
> ~Sreeni
>       -iDream
> 


-- 
~Sreeni
       -iDream
