Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263292AbSJCNtQ>; Thu, 3 Oct 2002 09:49:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263295AbSJCNtQ>; Thu, 3 Oct 2002 09:49:16 -0400
Received: from pc1-cwma1-5-cust51.swa.cable.ntl.com ([80.5.120.51]:28656 "EHLO
	irongate.swansea.linux.org.uk") by vger.kernel.org with ESMTP
	id <S263292AbSJCNtP>; Thu, 3 Oct 2002 09:49:15 -0400
Subject: Re: [rfc] [patch] kernel hooks
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: Richard J Moore <richardj_moore@uk.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Michael Grundy <vamsi_krishna@in.ibm.com>,
       Mikael Pettersson <mikpe@csd.uu.se>, suparna <bsuparna@in.ibm.com>,
       vamsi@linux.ibm.com
In-Reply-To: <OFAC358F0A.6BBBEF7D-ON80256C47.004A301E@portsmouth.uk.ibm.com>
References: <OFAC358F0A.6BBBEF7D-ON80256C47.004A301E@portsmouth.uk.ibm.com>
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.8 (1.0.8-10) 
Date: 03 Oct 2002 15:00:52 +0100
Message-Id: <1033653652.28022.20.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2002-10-03 at 14:32, Richard J Moore wrote:
> 
> > You must also ensure that the code you are modifying isnt on an IRQ path
> > (if it is you must do spin locks and then be very careful about cross
> > cpu tlb deadlocks). Finally you have no choice but to ensure you never
> > use it on the NMI path
> 
> Why do we need a spinlock? We change one byte, we are not concered about
> when exactly that takes effect, only that there are always valid
> instructions in the pipeline.

Because you are programming for real silicon not for the imaginary
perfect processor. Read the x86 errata

