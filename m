Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289927AbSAKMJa>; Fri, 11 Jan 2002 07:09:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289923AbSAKMJS>; Fri, 11 Jan 2002 07:09:18 -0500
Received: from nav.interactiveinstitute.se ([195.149.141.29]:7173 "EHLO
	nav.interactiveinstitute.se") by vger.kernel.org with ESMTP
	id <S289926AbSAKMIz>; Fri, 11 Jan 2002 07:08:55 -0500
Message-Id: <200201111208.g0BC8wI29387@nav.interactiveinstitute.se>
Content-Type: text/plain; charset=US-ASCII
From: Anders Vedmar <anders.vedmar@interactiveinstitute.se>
To: linux-kernel@vger.kernel.org
Subject: 2.4.17 raid5 checksumming function selection wierdness
Date: Fri, 11 Jan 2002 13:12:53 +0100
X-Mailer: KMail [version 1.3.2]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

The raid5 code in 2.4.17 seems to select the slowest available
checksumming function.

Part of dmesg output follows:

[...]
raid5: measuring checksumming speed
   8regs     :  2148.000 MB/sec
   32regs    :  1900.400 MB/sec
   pIII_sse  :  1272.000 MB/sec
   pII_mmx   :  3291.200 MB/sec
   p5_mmx    :  4212.400 MB/sec
raid5: using function: pIII_sse (1272.000 MB/sec)
[...]

The machine is an Athlon XP 1400MHz on an MSI K7T266Pro2 board with
512 Mb of PC2100 DDR.

-- 
/A
