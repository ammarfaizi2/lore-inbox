Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267568AbTA3TB3>; Thu, 30 Jan 2003 14:01:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267605AbTA3TB3>; Thu, 30 Jan 2003 14:01:29 -0500
Received: from air-2.osdl.org ([65.172.181.6]:25290 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id <S267568AbTA3TB1>;
	Thu, 30 Jan 2003 14:01:27 -0500
Date: Thu, 30 Jan 2003 11:03:59 -0800 (PST)
From: "Randy.Dunlap" <rddunlap@osdl.org>
X-X-Sender: <rddunlap@dragon.pdx.osdl.net>
To: Yichen Xie <yxie@cs.stanford.edu>
cc: <linux-kernel@vger.kernel.org>, <mc@cs.stanford.edu>
Subject: Re: [CHECKER] 87 potential array bounds error/buffer overruns in
 2.5.53
In-Reply-To: <000001c2c5a4$5c4465d0$09830c80@stanfordja31z2>
Message-ID: <Pine.LNX.4.33L2.0301301102575.4084-100000@dragon.pdx.osdl.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


URL for original email:
  http://www.lkml.org/archive/2003/1/26/98/index.html

| Attached are 87 potential buffer overruns in 2.5.53. Most arise from
| improper bounds checks, and some might be security holes where the array
| index comes from an untrusted source (e.g. copy_from_user). In the bug
| report, "len" refers to the length of the array or buffer being
| accessed, and "off" refers to the offset/index that is being used to
| access it. (off >= len) corresponds to a buffer overrun, while (off < 0)
| signals an underrun.


Here is a summary report of patches for these reported problems.
I suggest that we ask the kernel-janitors project to try to
finish this off.

---------------------------------------------------------

# Summary for
#  buffer-specific errors       = 87
#  /dev/null-specific errors = 0
#  Common errors 		      	  = 0
#  Total 				  = 87
# BUGs	|	File Name


These reported errors are fixed (pending, not merged):
1	|	/scsi/aic79xx_pci.c
1	|	/input/sunkbd.c
9	|	/scsi/aachba.c
4	|	/i386/numa.c
3	|	/drivers/DAC960.c
3	|	/drivers/ibmphp_pci.c
2	|	/net/qos.c
2	|	/hardware/diva.c
2	|	/ftape/ftape-read.c
1	|	/drivers/dpt_i2o.c
1	|	/drivers/cciss.c
1	|	/message/i2o_core.c
1	|	/char/rioroute.c
1	|	/net/af_bluetooth.c
1	|	/drivers/cpqphp_pci.c
1	|	/net/scc.c
1	|	/sound/dev_table.c
2	|	/drivers/specialix.c
1	|	/dvb/av7110.c
1	|	/media/bttv-cards.c
1	|	/drivers/ll_rw_blk.c
1	|	/net/rtnetlink.c
1	|	/net/orinoco.c
1	|	/drivers/riscom8.c
1	|	/drivers/i82092.c
1	|	/net/smc-ircc.c
1	|	/fs/devfs/base.c
1	|	/drivers/cpqfcTSworker.c
1	|	/drivers/3c59x.c
1	|	/drivers/sx.c


These (potential) reported errors are unfixed:
1	|	/char/riocmd.c
1	|	/char/rioboot.c
1	|	/sound/sb_card.c
3	|	/video/init301.c
1	|	/video/sis_main.c
1	|	/video/sis/init.c
1	|	/message/mptbase.c
1	|	/isdn/isdn_common.c
1	|	/hardware/os_4bri.c
2	|	/net/skxmac2.c
2	|	/drivers/psi240i.c
2	|	/drivers/eexpress.c
3	|	/message/i2o_block.c
2	|	/drivers/tg3.c
1	|	/net/3c359.c
1	|	/drivers/qlogicfc.c
1	|	/media/msp3400.c
1	|	/drivers/cdrom.c
1	|	/media/radio-terratec.c
1	|	/fs/cifssmb.c
1	|	/ide/siimage.c


These reported problems aren't errors:
1	|	/usb/ohci-hub.c
1	|	/drivers/ide-probe.c
5	|	/char/i2cmd.c
1	|	/fs/xfs_bmap_btree.c


These are already changed/modified/different from the reported problems.
1	|	/cpu/powernow-k6.c


###
-- 
~Randy

