Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262979AbTIRFs1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Sep 2003 01:48:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262977AbTIRFs1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Sep 2003 01:48:27 -0400
Received: from zcamail05.zca.compaq.com ([161.114.32.105]:24847 "EHLO
	zcamail05.zca.compaq.com") by vger.kernel.org with ESMTP
	id S262973AbTIRFsZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Sep 2003 01:48:25 -0400
Subject: Re: [PATCH] 2.4 force_successful_syscall()
From: "Aneesh Kumar K.V" <aneesh.kumar@digital.com>
To: Marcelo Tosatti <marcelo.tosatti@cyclades.com.br>
Cc: "Helgaas, Bjorn (HP)" <bjorn.helgaas@hp.com>,
       Marcelo Tosatti <marcelo@conectiva.com.br>, linux-ia64@vger.kernel.org,
       linux-kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <1063863741.1801.34.camel@satan.xko.dec.com>
References: <1063863741.1801.34.camel@satan.xko.dec.com>
Content-Type: text/plain
Organization: Digital India
Message-Id: <1063864899.1802.36.camel@satan.xko.dec.com>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 18 Sep 2003 11:31:39 +0530
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2003-09-18 at 11:12, Kumar, Aneesh wrote:
> On Thu, 2003-09-18 at 01:30, Marcelo Tosatti wrote:
> > On Wed, 10 Sep 2003, Bjorn Helgaas wrote:
> > 
> > > Here's a 2.4 backport of this change to 2.5:
> > > 
> > >
> >
> http://linux.bkbits.net:8080/linux-2.5/cset@1.1046.238.7?nav=index.html
> > > 
> > > Alpha, ppc, and sparc64 define force_successful_syscall_return() in
> > 2.5,
> > > but since it's not obvious to me how to do it correctly in 2.4, I
> left
> > > them unchanged.
> > 
> > Whats the reasoning behing this patch?
> 
> IIRC those changes were added to 2.5 by David. Architecture like Ia64
> and Alpha support error return via a different register set ( $19 for
> Alpha ). But syscalls like ptrace can have negative return value for
> successful returns. So in that particular case $19 is forced to be zero
> to indicate it is a successful return. IIUC
> force_successful_syscall_return  is a wrapper around doing that. On
> alpha actually r0 in the stack (regs.r0 ) is made zero which is  read in
> entry.S and put in $19. 


For IA64 I guess it is r10 and regs.r8. May be other can correct me if i
am wrong. 

-aneesh 


