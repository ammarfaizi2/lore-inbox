Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWCZV2q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWCZV2q (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Mar 2006 16:28:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932129AbWCZV2q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Mar 2006 16:28:46 -0500
Received: from nproxy.gmail.com ([64.233.182.187]:58163 "EHLO nproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932126AbWCZV2p convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Mar 2006 16:28:45 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=Jgai5bGICp2nNCsYuvBEyBVQwcudoO602uJ26zm1KkjEjcolJlKRX/8ematOJCAIs2B7UuE/DDBECrVfVAhY4S9dThSJQE0AbueNtwXQPpOFtUFnty/JAcDFlCg9PXiXJNRJMWA6GRuUGTQZ7WDOzlKwkxUoDLjDIYOpgN7iWT4=
Message-ID: <ecb4efd10603261328y45d14ab4h1606d70abdab056a@mail.gmail.com>
Date: Sun, 26 Mar 2006 16:28:44 -0500
From: "Clem Taylor" <clem.taylor@gmail.com>
To: linux-kernel@vger.kernel.org, linux-ide@vger.kernel.org
Subject: sata_sil qc timeout on 2.6.15 & 2.6.16, 2.6.14 is fine...
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I have a Silicon Image 3114 controller on a dual opteron box with 4
ST3160023AS drives. The root is a software RAID5 with xfs. I have not
been able to get 2.6.15 or 2.6.16 to boot on this machine. 2.6.14
boots up just fine.

With 2.6.16 the sata probing process is very slow and I get the
following output:
ata1: SATA link up 1.5 Gbps (SStatus 113)
ata1: dev 0 ATA-6, max UDMA/133, 312581808 sectors: LBA48
ata1: qc timeout (cmd 0xef)
ata1: failed to set xfermode, disabled
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
... repeats for ata[234] and then fails to find the root device ...

With 2.6.14:
ata1: dev 0 cfg 49:2f00 82:346b 83:7d01 84:4003 85:3469 86:3c01 87:4003 88:207f
ata1: dev 0 ATA, max UDMA/133, 312581808 sectors: lba48
ata1: dev 0 configured for UDMA/100
scsi0 : sata_sil
... ata[234] output, boots just fine ...

                                      Any ideas?
                                      Clem
