Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315744AbSECXJD>; Fri, 3 May 2002 19:09:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315743AbSECXJC>; Fri, 3 May 2002 19:09:02 -0400
Received: from c9mailgw04.amadis.com ([216.163.188.202]:42765 "EHLO
	C9Mailgw04.amadis.com") by vger.kernel.org with ESMTP
	id <S315741AbSECXJB>; Fri, 3 May 2002 19:09:01 -0400
Date: Fri, 3 May 2002 19:08:09 -0400
From: Jason Giglio <jgiglio@vt.edu>
To: linux-kernel@vger.kernel.org
Cc: bradlist@bradm.net
Subject: 3ware 7810 and Tyan 2462 Tiger MP lockup
Message-Id: <20020503190809.7cb8c052.jgiglio@vt.edu>
X-Mailer: Sylpheed version 0.6.3 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Bradley McLean had posted a while back (3/30/02) about problems with 3ware 7810 cards and Tyan Tiger MP.  He had indicated that updating his drivers and changing a PCI riser card around fixed the problem.

I have recently encountered the problem with the newest drivers and no PCI riser cards.  It only seems to happen when using XFS, and when directly accessing the 3ware card through /dev/sda.  The symptoms are the same, hard lockup, no ping, no nothing, during heavy I/O. An added twist is that the file system is very corrupt upon rebooting.

I have sent a message to the XFS list, but I thought I'd drop a note in here that the problem is still persisting, since it is not likely a problem in XFS proper that is causing the initial lockup, considering that others had the problem with any file system previously.  It was suggested by Alan Cox that this may be an APIC issue, it happened for me with or without noapic specified.

Please CC me on replies to list.  

Thanks,
Jason

>From: Bradley McLean (bradlist@bradm.net)
>Subject: Hard hang on 3Ware7850, Dual AthlonMP, Tyan2462

>I've been following the various discussions of athlon MP problems. We too have systems that consistently hard lock up.
>Running RH7.2 with kernel.org kernels, versions 2.4.17, 2.4.18,
>or 2.4.18 plus the IO-APIC patch posted for 2.4.19pre3.
>Using the latest (release 7.4, driver version 19) 3ware code. Tyan 2462, 3.5 GB
>(2) AMD MP1900+
>(6) WB1200JB Symptoms:  Either under heavy read, or heavy write, system locks up.  No ping, no keyboard.
