Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262357AbVA0Sfz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262357AbVA0Sfz (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Jan 2005 13:35:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262611AbVA0Sfz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Jan 2005 13:35:55 -0500
Received: from wproxy.gmail.com ([64.233.184.200]:11316 "EHLO wproxy.gmail.com")
	by vger.kernel.org with ESMTP id S262357AbVA0Sfb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Jan 2005 13:35:31 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:reply-to:to:subject:mime-version:content-type:content-transfer-encoding;
        b=ADhPwdz1RX6AnHlhL5Sx+ontbdV2mGa2uSuzdXm+g0ZLnoUR4I01BjZVmxtzucOaDLy1GXcOqx6f6rPi1pI9UMNAz0mCWMDKffk5cBy/jpJMbf2NOkil7yY5zcWjoOG/eHsptfFJtMF/l/fxe1FB/Dnpjpxak8nB49KWqPtUeyI=
Message-ID: <2ec2c15a05012710356feafc81@mail.gmail.com>
Date: Thu, 27 Jan 2005 10:35:28 -0800
From: Prashant Viswanathan <vprashant@gmail.com>
Reply-To: Prashant Viswanathan <vprashant@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: Compactflash (Sandisk 512) hangs on access
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I have been trying unsuccessfully over the last 2 weeks to get
compactflash working on my Linux system based on mini-ITX (Via CL
motherboard, pentium compatible).

I use a CF->IDE adapter to access it just like a IDE hard disk. My
compactflash is Sandisk SDCFH-512. Linux can detect it. I can even
mount it and do a fdisk on it. However, the moment I try to do
anything substantial like copy multiple files or copy 1000 blocks
using dd, I lose access to it. Linux loses access to it totally. I
can't even do a fdisk on it. I get an error like "Unable to open
/dev/hdc".

I have looked at newsgroups and tried the following things
* Used another CF (same brand) to make sure it wasn't due to a bad CF.
 Moreover I can access it perfectly well using a USB flash
reader/writer (shows up as a SCSI disk).
* Tried a compactflash from another manufacturer.
* Upgraded my Linux kernel from 2.4.26 to 2.6.7
* Disabled DMA on the IDE drive using hdparm
* Built and used kernels with and without devfs.
* Used compactflash as a slave on the IDE channel, as a master and on
both primary and secondary channels.

I get errors like (from dmesg)
"hdc: irq timeout: status=0xff { Busy }" (no dma)
or
"hdc: lost interrupt" (when i had dma enabled)

Is there some nasty race condition that I am hitting?

Also, now I can't seem to turn dma back on.

<snip>
everest root # hdparm -d1 /dev/hdc

/dev/hdc:
setting using_dma to 1 (on)
HDIO_SET_DMA failed: Operation not permitted
using_dma    =  0 (off)
</snip>


I would appreciate any help/suggestions/pointers.

Thanks a lot in advance for reading through this and any help.
Prashant


P.S Please CC me on the responses.
