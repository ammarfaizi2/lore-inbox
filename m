Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130095AbQLATHn>; Fri, 1 Dec 2000 14:07:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130127AbQLATHe>; Fri, 1 Dec 2000 14:07:34 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:12378 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S130095AbQLATHY>; Fri, 1 Dec 2000 14:07:24 -0500
Subject: Re: IP fragmentation (DF) and ip_no_pmtu_disc in 2.2 vs 2.4
To: navarro@mcs.anl.gov (JP Navarro)
Date: Fri, 1 Dec 2000 18:36:42 +0000 (GMT)
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <3A27EDF5.6060609@mcs.anl.gov> from "JP Navarro" at Dec 01, 2000 12:29:09 PM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E141v36-0000Zg-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With 2.4.0-test11, when ip_no_pmtu_disc is still 0/false we're seeing 
> outbound udp packets with the IP DF bit set.  Is this change in default 
> behavior a fix or a break?

Its a change in behaviour 

> So, it appears that 2.4 fixed a problem with 2.2, correct?
> [stop non expert thinking]

2.2 only supports it for TCP

> Intel PXE uses tftp to download boot images and discards IP packets with 
> the DF bit set; so a tftpd server on 2.4 with the default 

Then Intel PXE is buggy and you should go spank whoever provided it as well
as doing the workarounds. Supporting received frames with DF set is mandatory.

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
