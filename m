Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272773AbRJTLza>; Sat, 20 Oct 2001 07:55:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272818AbRJTLzT>; Sat, 20 Oct 2001 07:55:19 -0400
Received: from dark.pcgames.pl ([195.205.62.2]:25542 "EHLO dark.pcgames.pl")
	by vger.kernel.org with ESMTP id <S272773AbRJTLzK>;
	Sat, 20 Oct 2001 07:55:10 -0400
Date: Sat, 20 Oct 2001 13:54:54 +0200 (CEST)
From: Krzysztof Oledzki <ole@ans.pl>
X-X-Sender: <ole@dark.pcgames.pl>
To: <linux-kernel@vger.kernel.org>
Subject: bug in "raid5: measuring checksumming speed"
Message-ID: <Pine.LNX.4.33.0110201342410.19999-100000@dark.pcgames.pl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

It seems that there is something wrong with measuring checksumming speed -
on my two P3 boxes linux chooses pIII_sse but pII_mmx and p5_mmx are
reported as faster instructions:

2.4.10-ac10/Pentium3 733:
raid5: measuring checksumming speed
   8regs     :  1266.400 MB/sec
   32regs    :   898.400 MB/sec
   pIII_sse  :  1508.000 MB/sec
   pII_mmx   :  1643.600 MB/sec
   p5_mmx    :  1730.400 MB/sec
raid5: using function: pIII_sse (1508.000 MB/sec)

Podobnie na drugim systemie:
2.4.10-ac10/Pentium3 933:
raid5: measuring checksumming speed
   8regs     :  1603.600 MB/sec
   32regs    :  1138.000 MB/sec
   pIII_sse  :  1910.000 MB/sec
   pII_mmx   :  2081.600 MB/sec
   p5_mmx    :  2189.600 MB/sec
raid5: using function: pIII_sse (1910.000 MB/sec)

Best regards,

                                Krzysztof Oledzki


