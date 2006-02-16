Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751251AbWBPRSG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbWBPRSG (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 12:18:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751385AbWBPRSF
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 12:18:05 -0500
Received: from e32.co.us.ibm.com ([32.97.110.150]:34176 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751251AbWBPRSE
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 12:18:04 -0500
Subject: Re: 2.6.16-rc3 qlogic panic ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Arjan van de Ven <arjan@infradead.org>
Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1140108765.4117.89.camel@laptopd505.fenrus.org>
References: <1140108589.29800.2.camel@dyn9047017100.beaverton.ibm.com>
	 <1140108765.4117.89.camel@laptopd505.fenrus.org>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 09:19:08 -0800
Message-Id: <1140110348.29800.12.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-16 at 17:52 +0100, Arjan van de Ven wrote:
> On Thu, 2006-02-16 at 08:49 -0800, Badari Pulavarty wrote:
> > Andrew,
> > 
> > I am not sure if its already reported. I get following panic
> > while using qla2200 on 2.6.16-rc3.
> > 
> > Thanks,
> > Badari
> > 
> > Unable to handle kernel NULL pointer dereference at 0000000000000000
> > RIP:
> > <ffffffff88042690>{:qla2xxx:qla2x00_mem_free+648}
> > PGD 1bddac067 PUD 1be314067 PMD 0
> > Oops: 0000 [1] SMP
> > CPU 0
> > Modules linked in: thermal processor fan button battery ac parport_pc lp
> > parport ipv6 sg qlogicfc qla2200 qla2300 qla2xxx ohci_hcd hw_random
> > usbcore dm_mod
> > Pid: 4601, comm: modprobe Tainted: GF     2.6.16-rc3 #1
> 
> why are you using insmod -f ? are you sure that that wasn't an
> incompatible module ?

I am not using "insmod -f" intentionally. It happend on the boot.


> (also loading BOTH qlogicfc and qla2200 is BAD)

Okay. I built qlogicfc and qla2200 as modules. I removed qlogicfc module
completely, I don't the panic any more. 

Thanks,
Badari

