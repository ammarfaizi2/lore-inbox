Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S133106AbRDVBcc>; Sat, 21 Apr 2001 21:32:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S133107AbRDVBcW>; Sat, 21 Apr 2001 21:32:22 -0400
Received: from leng.mclure.org ([64.81.48.142]:38930 "EHLO
	leng.internal.mclure.org") by vger.kernel.org with ESMTP
	id <S133106AbRDVBcO>; Sat, 21 Apr 2001 21:32:14 -0400
Date: Sat, 21 Apr 2001 18:32:12 -0700
From: Manuel McLure <manuel@mclure.org>
To: linux-kernel@vger.kernel.org
Subject: 2.4.3-ac10/ac11 crash at boot in PDC20265 check
Message-ID: <20010421183212.G1106@ulthar.internal.mclure.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
X-Mailer: Balsa 1.1.3
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It looks like the check for the PDC20265 added in ac10 causes some
problems. I have an MSI K7T Turbo R which has a Promise FastTrak built in -
when I try to boot ac10 or ac11 on it I get an Oops just after the "ide:
Found promise 20265 in RAID mode." message. I diffed ide-pci.c between ac5
(which worked) and ac10 (which fails) and found that the only change was
the check for the PDC20265 - I commented this out and the kernel boots fine
now.

On another topic, does anyone know how to disable the onboard FastTrak? I
don't use it, and it makes my boot time longer...

Thanks,
-- 
Manuel A. McLure KE6TAW | ...for in Ulthar, according to an ancient
<manuel@mclure.org>     | and significant law, no man may kill a cat.
<http://www.mclure.org> |             -- H.P. Lovecraft

