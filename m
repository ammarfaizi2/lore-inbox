Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283268AbRL2PVk>; Sat, 29 Dec 2001 10:21:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283588AbRL2PVa>; Sat, 29 Dec 2001 10:21:30 -0500
Received: from moutng0.kundenserver.de ([212.227.126.170]:49141 "EHLO
	moutng0.schlund.de") by vger.kernel.org with ESMTP
	id <S283268AbRL2PVW>; Sat, 29 Dec 2001 10:21:22 -0500
Date: Sat, 29 Dec 2001 16:16:55 +0100
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: [2.5.2-pre3] nfs build broken
Message-ID: <20011229151655.GA6080@elfie.cavy.de>
Mail-Followup-To: linux-kernel@vger.kernel.org
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.24-current-20011226i (Linux 2.4.17-spc i586)
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Building of NFS filesystem support somehow got broken in 2.5.2-pre3:

[....]

make[1]: Nothing to be done for modules_install'.
make[1]: Leaving directory /usr/src/linux/arch/i386/lib'
cd /lib/modules/2.5.2-pre3-xs2; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.2-pre3-xs2;
fi
depmod: *** Unresolved symbols in 
/lib/modules/2.5.2-pre3-xs2/kernel/fs/nfs/nfs.o
depmod:         seq_escape
depmod:         seq_printf
elfie:/usr/src/linux #

-- 
# Heinz Diehl, 68259 Mannheim, Germany
