Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287493AbSCFAfm>; Tue, 5 Mar 2002 19:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292565AbSCFAfc>; Tue, 5 Mar 2002 19:35:32 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:11787 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287493AbSCFAfS>; Tue, 5 Mar 2002 19:35:18 -0500
Subject: Re: [PATCH] remove BKL from ext2_get_block() version 2
To: haveblue@us.ibm.com (Dave Hansen)
Date: Wed, 6 Mar 2002 00:50:20 +0000 (GMT)
Cc: marcelo@conectiva.com.br (Marcelo Tosatti),
        alan@lxorguk.ukuu.org.uk (Alan Cox), linux-kernel@vger.kernel.org,
        viro@math.psu.edu (Alexander Viro)
In-Reply-To: <200203060023.g260NIB09974@localhost.localdomain> from "Dave Hansen" at Mar 05, 2002 04:23:18 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16iPdM-0004x1-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> The patch is against 2.4.19-pre2.  The patch significantly lowers BKL contention (50%) on a 2-way PII-300 running dbench 4.  Dbench throughput is not significantly affected, but that is probably a function of my puny little machine more than the effectiveness of the patch.  I'll have some results on a much more beefy 8-way PIII tomorrow.  Earlier versions of the patch reduced BKL contention during dbench by 60% on the 8-way.  CPU utilization spinning on the BKL has been as high as 40%.

I certainly am not interested in it. 2.4 locking changes for very big boxes
strike me as a little dangerous.
