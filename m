Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130743AbRCEXIS>; Mon, 5 Mar 2001 18:08:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130753AbRCEXIB>; Mon, 5 Mar 2001 18:08:01 -0500
Received: from panic.ohr.gatech.edu ([130.207.47.194]:65501 "HELO
	havoc.gtf.org") by vger.kernel.org with SMTP id <S130743AbRCEXHm>;
	Mon, 5 Mar 2001 18:07:42 -0500
Message-ID: <3AA41C3C.A8DE3254@mandrakesoft.com>
Date: Mon, 05 Mar 2001 18:07:40 -0500
From: Jeff Garzik <jgarzik@mandrakesoft.com>
Organization: MandrakeSoft
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.3-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Sergey Kubushin <ksi@cyberbills.com>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.2ac12
In-Reply-To: <Pine.LNX.4.31ksi3.0103051439250.12620-100000@nomad.cyberbills.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sergey Kubushin wrote:
> === Cut ===
> make -C aic7xxx modules
> make[3]: Entering directory `/tmp/build-kernel/usr/src/linux-2.4.2ac12/drivers/scsi/aic7xxx'
> make -C aicasm
> make[4]: Entering directory `/tmp/build-kernel/usr/src/linux-2.4.2ac12/drivers/scsi/aic7xxx/aicasm'
> gcc -I/usr/include -ldb1 aicasm_gram.c aicasm_scan.c aicasm.c aicasm_symbol.c -o aicasm
> aicasm_symbol.c:39: db1/db.h: No such file or directory

Amazingly you've hit one of the few problems caused by something outside
the kernel tree.  db v1.85 has been superceded by db2 and db3.  db1 is
where the "original" Berkeley db stuff now lives.  Apparently aicasm
needs db 1.

So, update your packages, or create the proper symlinks if you've
already got db1 installed in some other location.

-- 
Jeff Garzik       | "You see, in this world there's two kinds of
Building 1024     |  people, my friend: Those with loaded guns
MandrakeSoft      |  and those who dig. You dig."  --Blondie
