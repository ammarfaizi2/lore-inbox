Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262272AbVCOFst@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262272AbVCOFst (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 00:48:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262269AbVCOFst
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 00:48:49 -0500
Received: from e6.ny.us.ibm.com ([32.97.182.146]:47594 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S262272AbVCOFsb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 00:48:31 -0500
Subject: Re: [Fastboot] Re: Query: Kdump: Core Image ELF Format
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Andrew Morton <akpm@osdl.org>, gdb <gdb@sources.redhat.com>,
       Dave Anderson <anderson@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>, fastboot <fastboot@lists.osdl.org>
In-Reply-To: <m1br9skn0b.fsf@ebiederm.dsl.xmission.com>
References: <1110286210.4195.27.camel@wks126478wss.in.ibm.com>
	 <m1br9um313.fsf@ebiederm.dsl.xmission.com>
	 <1110350629.31878.7.camel@wks126478wss.in.ibm.com>
	 <m1ll8wlx82.fsf@ebiederm.dsl.xmission.com>
	 <1110430955.3574.11.camel@wks126478wss.in.ibm.com>
	 <m1br9skn0b.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain
Date: Tue, 15 Mar 2005 11:19:47 +0530
Message-Id: <1110865787.3576.7.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 (2.0.2-3) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-03-09 at 23:56 -0700, Eric W. Biederman wrote:
> Vivek Goyal <vgoyal@in.ibm.com> writes:
> 
> > I want to fill the virtual addresses of linearly mapped region. That is
> > physical addresses from 0 to MAXMEM (896 MB) are mapped by kernel at
> > virtual addresses PAGE_OFFSET to (PAGE_OFFSET + MAXMEM). Values of
> > PAGE_OFFSET and MAXMEM are already known and hard-coded.
> 
> PAGE_OFFSET has a common value of 0xc0000000, on x86.  However
> that value is by no means fixed.  The 4G/4G split changes it
> as do some other patches floating around at the time.
> On x86-64 I don't know how stable those kinds of offsets are.

Agreed. Then how about, exporting this information to user space.
Probably through sysfs. May be the range of linearly mapped region can
be exported. (PAGE_OFFSET to (PAGE_OFFSET + x)).

>  
> > I think I used the terminology kernel virtual address and that is adding
> > to the confusion. Kernel virtual addresses are not necessarily linearly
> > mapped. What I meant was kernel logical addresses whose associated
> > physical addresses differ only by a constant offset.
> 
> I know what you meant.  I simply meant that things don't look that
> constant to me.  Especially in Linux where there are enough people
> to try most of the reasonable possibilities.
> 
> I don't even think it is a bad idea.  But I do think we have a different
> idea of what is constant.
> 
> Eric
> 

