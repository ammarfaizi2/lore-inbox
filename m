Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S131686AbQKVXIL>; Wed, 22 Nov 2000 18:08:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S131883AbQKVXIB>; Wed, 22 Nov 2000 18:08:01 -0500
Received: from mout02.kundenserver.de ([195.20.224.133]:20084 "EHLO
        mout02.kundenserver.de") by vger.kernel.org with ESMTP
        id <S131686AbQKVXH7>; Wed, 22 Nov 2000 18:07:59 -0500
Date: Wed, 22 Nov 2000 23:27:23 +0100
From: Heinz Diehl <hd@cavy.de>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: isofs crash on 2.4.0-test11-pre7 [1.] MAINTAINERS: ISO FILESYSTEM
Message-ID: <20001122232723.A4499@elfie.cavy.de>
In-Reply-To: <3A17C845.1A9845E9@epix.net> <3A1930D5.D74A40BB@oracle.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5-current-20000821i (Linux 2.4.0-test10-final i586)
In-Reply-To: <3A1930D5.D74A40BB@oracle.com>; from alessandro.suardi@oracle.com on Mon, Nov 20, 2000 at 03:10:29PM +0100
Organization: private site in Mannheim/Germany
X-PGP-Key: To get my public-key, send mail with subject 'get pgpkey'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon Nov 20 2000, Alessandro Suardi wrote:

> there is a buglet in fs/isofs/namei.c, corrected in test11-final.

Hmmm. 

/var/log/warn says 

Nov 21 23:07:06 elfie kernel: _isofs_bmap: block >= EOF (1633681408, 4096)
Nov 21 23:07:08 elfie kernel: _isofs_bmap: block >= EOF (559939584, 4096)
Nov 21 23:07:09 elfie kernel: _isofs_bmap: block < 0
Nov 21 23:07:33 elfie last message repeated 2 times
Nov 21 23:09:39 elfie kernel: _isofs_bmap: block < 0
Nov 21 23:11:25 elfie kernel: Freeing unused kernel memory: 176k freed
Nov 21 23:11:55 elfie kernel: _isofs_bmap: block < 0
Nov 21 23:11:59 elfie kernel: _isofs_bmap: block < 0
Nov 21 23:12:33 elfie kernel: _isofs_bmap: block >= EOF (1633681408, 4096)
Nov 21 23:12:38 elfie kernel: _isofs_bmap: block >= EOF (1633681408, 4096)
Nov 21 23:13:03 elfie kernel: _isofs_bmap: block >= EOF (559939584, 4096)

after I mounted the CD-ROM. Moving to the directory the CD-ROM
was mounted on, it is empty !

Going back to 2.4.0-test10-final cures the problem.

My system:

hd@elfie:~ > ver_linux
-- Versions installed: (if some fields are empty or look
-- unusual then possibly you have very old versions)
Linux elfie 2.4.0-test10-final #1 Tue Nov 21 23:18:34 CET 2000 i586 unknown
Kernel modules         2.3.19
Gnu C                  2.95.2
Gnu Make               3.79
Binutils               2.10.0.33
Linux C Library        > libc.2.2
Dynamic linker         ldd (GNU libc) 2.2
Linux C++ Library      2.9.0
Procps                 2.0.2
Mount                  2.10o
Net-tools              1.46
Kbd                    0.96
Sh-utils               1.12
Modules Loaded         serial

-- 
# Heinz Diehl, 68259 Mannheim, Germany
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
