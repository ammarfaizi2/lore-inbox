Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271762AbRHRCNy>; Fri, 17 Aug 2001 22:13:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271763AbRHRCNo>; Fri, 17 Aug 2001 22:13:44 -0400
Received: from www.ccsi.com ([216.236.168.10]:49395 "EHLO ccsi.com")
	by vger.kernel.org with ESMTP id <S271762AbRHRCNc>;
	Fri, 17 Aug 2001 22:13:32 -0400
Message-Id: <200108180208.f7I28tO12324@ccsi.com>
Content-Type: text/plain; charset=US-ASCII
From: leroyljr <leroyljr@ccsi.com>
Reply-To: leroyljr@ccsi.com
To: linux-kernel@vger.kernel.org
Subject: More Driver Troubles
Date: Fri, 17 Aug 2001 21:11:01 -0500
X-Mailer: KMail [version 1.3]
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, I reported a problem with compiling the AIC7xxx deal the other day.

You suggested,"If you manually go into drivers/scsi/aic7xxx/aicasm and do a 
make clean, the error should go away."

OK, that worked.  But now I have undefined symbols in the driver which causes
a kernel panic when I boot up because it's my root device.

Here are the ones I was able to write down:

(undefined symbols in):
scsi_unregister_Rsmp_8dcd2990
scsi_register_Rsmp_5f04f644
scsi_unregister_module_Rsmp_81d85a75
scsi_report_bus_reset_Rsmp_5024965f
scsi_block_requests_Rsmp_43878139
scsi_partsize_Rsmp_276f0d01
scsi_register_module_Rsmp_fa20b7b0

Yeah, it's SMP. Hope this helps.
