Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbWBPR1b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbWBPR1b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 12:27:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751388AbWBPR1b
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 12:27:31 -0500
Received: from e34.co.us.ibm.com ([32.97.110.152]:36526 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1751386AbWBPR1a
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 12:27:30 -0500
Subject: Re: 2.6.16-rc3 qlogic panic ?
From: Badari Pulavarty <pbadari@us.ibm.com>
To: Andrew Vasquez <andrew.vasquez@qlogic.com>
Cc: lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <20060216171934.GA5627@andrew-vasquezs-powerbook-g4-15.local>
References: <1140108589.29800.2.camel@dyn9047017100.beaverton.ibm.com>
	 <20060216171934.GA5627@andrew-vasquezs-powerbook-g4-15.local>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 09:28:39 -0800
Message-Id: <1140110919.29800.14.camel@dyn9047017100.beaverton.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-16 at 09:19 -0800, Andrew Vasquez wrote:
> On Thu, 16 Feb 2006, Badari Pulavarty wrote:
> 
> > I am not sure if its already reported. I get following panic
> > while using qla2200 on 2.6.16-rc3.
> >
> 
> The qlogicfc driver attaches to 2100 and 2200 devices:
> 
> > Unable to handle kernel NULL pointer dereference at 0000000000000000
> > RIP:
> > <ffffffff88042690>{:qla2xxx:qla2x00_mem_free+648}
> > PGD 1bddac067 PUD 1be314067 PMD 0
> > Oops: 0000 [1] SMP
> > CPU 0
> > Modules linked in: thermal processor fan button battery ac parport_pc lp
> > parport ipv6 sg qlogicfc qla2200 qla2300 qla2xxx ohci_hcd hw_random
> > usbcore dm_mod
> 
> Choose either qlogicfc or qla2xxx to manage the 2200, not both.

Yep. I had built both qlogicfc and qla2200 as modules. I took out
qlogicfc module out, things are fine now.

Thanks,
Badari

