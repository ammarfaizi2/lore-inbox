Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271242AbRHTOeS>; Mon, 20 Aug 2001 10:34:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271246AbRHTOeJ>; Mon, 20 Aug 2001 10:34:09 -0400
Received: from [195.66.192.167] ([195.66.192.167]:61192 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S271242AbRHTOdy>; Mon, 20 Aug 2001 10:33:54 -0400
Date: Mon, 20 Aug 2001 17:35:57 +0300
From: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
X-Mailer: The Bat! (v1.44)
Reply-To: VDA <VDA@port.imtp.ilyichevsk.odessa.ua>
Organization: IMTP
X-Priority: 3 (Normal)
Message-ID: <632639585.20010820173557@port.imtp.ilyichevsk.odessa.ua>
To: linux-kernel@vger.kernel.org
Subject: depmod -a: unresolved symbols
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Looks like it gonna be a silly question.
I am getting some messages about unresolved symbols from depmod -a
each time I boot. Thought that is harmless until today.

Now I'm trying to set up an NFS and "modprobe nfsd" fails:
nfsd.o: unresolved symbol nfsd_linkage

In kernel sources I see:
nfsd_linkage defined and EXPORT_SYMBOLed in fs/filesystems.c
(linked in vmlinux and bzimage, I see it in System.map),
referenced from fs/nfsd/nfsctl.c (later linked into nfsd.o)
So, why modprobe can't see it?

kernel: 2.4.5
I did
make dep && \
make clean && \
make bzImage && \
make modules && \
make modules_install

Please CC me. I'm not on the list.
-- 
Best regards,
 VDA                          mailto:VDA@port.imtp.ilyichevsk.odessa.ua


