Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265696AbTFSBwf (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 21:52:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265699AbTFSBwf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 21:52:35 -0400
Received: from vopmail.neto.com ([209.223.15.78]:23557 "EHLO vopmail.neto.com")
	by vger.kernel.org with ESMTP id S265696AbTFSBwb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 21:52:31 -0400
Message-ID: <3EF11BA1.6070606@neto.com>
Date: Wed, 18 Jun 2003 21:10:41 -0500
From: John T Copeland <johnc@neto.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030315
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linuxkernel <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Andre H <andre@linux-ide.org>
Subject: Followup on siimage
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

After the problems I encountered with SATA controller Sil3112A, I 
compiled a kernel without the Sil3112A, siimage, in the kernel.  Guess 
what?  My "normal" PATA drives, hda and hdb, don't have DMA activated 
with the 2.4.21 kernel.  Also when I try to arm them with hdparm I get 
the following:
root:~> hdparm -d1 -X66 /dev/hda
/dev/hda:
 setting using_dma to 1 (on)
 HDIO_SET_DMA failed: Opereation not permitted
 setting xfermode to 66 (UltraDMA mode2)
 using_dma    =   0 (off)

It would appear that DMA is broken in 2.4.21 or at least with my system.
Abit NF7-S rev 2.0 mother board with BIOS 1.2.
BTW I can turn on DMA on the PATA drives, hda and hdb with kernel 
2.4.20, no problem.  Tho they don't come up that way on boot.  The BIOS 
has DMA equal auto on all PATA drives.

Thought this might be another data point to help find the problem.  As 
before I am willing to help with testing, etc, etc, etc as much as needed.

Thanks
JohnC

