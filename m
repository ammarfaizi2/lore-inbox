Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932504AbWBPQxb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932504AbWBPQxb (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Feb 2006 11:53:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932546AbWBPQxb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Feb 2006 11:53:31 -0500
Received: from pentafluge.infradead.org ([213.146.154.40]:4251 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S932504AbWBPQxa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Feb 2006 11:53:30 -0500
Subject: Re: 2.6.16-rc3 qlogic panic ?
From: Arjan van de Ven <arjan@infradead.org>
To: Badari Pulavarty <pbadari@us.ibm.com>
Cc: Andrew Vasquez <andrew.vasquez@qlogic.com>,
       lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <1140108589.29800.2.camel@dyn9047017100.beaverton.ibm.com>
References: <1140108589.29800.2.camel@dyn9047017100.beaverton.ibm.com>
Content-Type: text/plain
Date: Thu, 16 Feb 2006 17:52:45 +0100
Message-Id: <1140108765.4117.89.camel@laptopd505.fenrus.org>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.3 (2.2.3-2.fc4) 
Content-Transfer-Encoding: 7bit
X-SRS-Rewrite: SMTP reverse-path rewritten from <arjan@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2006-02-16 at 08:49 -0800, Badari Pulavarty wrote:
> Andrew,
> 
> I am not sure if its already reported. I get following panic
> while using qla2200 on 2.6.16-rc3.
> 
> Thanks,
> Badari
> 
> Unable to handle kernel NULL pointer dereference at 0000000000000000
> RIP:
> <ffffffff88042690>{:qla2xxx:qla2x00_mem_free+648}
> PGD 1bddac067 PUD 1be314067 PMD 0
> Oops: 0000 [1] SMP
> CPU 0
> Modules linked in: thermal processor fan button battery ac parport_pc lp
> parport ipv6 sg qlogicfc qla2200 qla2300 qla2xxx ohci_hcd hw_random
> usbcore dm_mod
> Pid: 4601, comm: modprobe Tainted: GF     2.6.16-rc3 #1

why are you using insmod -f ? are you sure that that wasn't an
incompatible module ?

(also loading BOTH qlogicfc and qla2200 is BAD)


