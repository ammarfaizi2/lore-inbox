Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291605AbSBNMam>; Thu, 14 Feb 2002 07:30:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291608AbSBNMac>; Thu, 14 Feb 2002 07:30:32 -0500
Received: from smtp-out-1.wanadoo.fr ([193.252.19.188]:21909 "EHLO
	mel-rto1.wanadoo.fr") by vger.kernel.org with ESMTP
	id <S291605AbSBNMaQ>; Thu, 14 Feb 2002 07:30:16 -0500
Message-ID: <3C6BAD61.5BC1AFC@wanadoo.fr>
Date: Thu, 14 Feb 2002 13:28:17 +0100
From: Jean-Luc Coulon <jean-luc.coulon@wanadoo.fr>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.17 i586)
X-Accept-Language: fr-FR, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: 2.4.18-pre9-ac[23], make modules_install fails
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I've the following problem with make modules_install and
2.4.18-pre9-ac[23]. I've not tested ac1 and then vanilla 2.4.18-pre9
works fine.

mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{}
pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map -b
/usr/src/linux/debian/tmp-image -r 2.4.18-pre9-ac3; fi
depmod: *** Unresolved symbols in
/usr/src/linux/debian/tmp-image/lib/modules/2.4.18-pre9-ac3/kernel/drivers/scsi/sd_mod.o
depmod:         blkdev_varyio

----------
Regards
		jean-Luc
