Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315539AbSFEQi4>; Wed, 5 Jun 2002 12:38:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315540AbSFEQiz>; Wed, 5 Jun 2002 12:38:55 -0400
Received: from zikova.cvut.cz ([147.32.235.100]:1028 "EHLO zikova.cvut.cz")
	by vger.kernel.org with ESMTP id <S315539AbSFEQiz>;
	Wed, 5 Jun 2002 12:38:55 -0400
From: "Petr Vandrovec" <VANDROVE@vc.cvut.cz>
Organization: CC CTU Prague
To: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Wed, 5 Jun 2002 18:38:23 +0200
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Content-transfer-encoding: 7BIT
Subject: Re: [RFC] remove the fat_cvf
CC: linux-kernel@vger.kernel.org
X-mailer: Pegasus Mail v3.50
Message-ID: <73BA70C46BF@vcnet.vc.cvut.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On  6 Jun 02 at 0:31, OGAWA Hirofumi wrote:
> This patch is first stuff to remove fat_cvf. AFAIK, it seems the
> fat_cvf isn't used for a long time. And fat_cvf makes change of fatfs
> difficult.
> 
> Is the fat_cvf needed? If it's not needed, I will submit the
> following patch at this weekend..

ftp://fb9nt.uni-duisburg.de/pub/linux/dmsdos/README reads:
--
PLEASE NOTE:

 The DMSDOS project is dead. I no longer maintain it due to lack of time.
 The latest supported kernel is 2.2.15 with dmsdos 0.9.2.1.
 There will never be a kernel 2.4.x port. Dmsdos 0.9.2.3-pre2 was an
 attempt to port the code, but it has failed. Don't use it.
--        
and it is latest dmsdos related file I found (and 0.9.2.1 is latest
I used on 2.2.17), so I believe that it is safe to remove cvf code
from fatfs. Both Stacker and Doublespace supported FAT16 only, so
current usual 120GB disk would require 120 logical units with estimated
compression ratio 2:1. IMHO adding dmsdosfs into mtools is the best 
solution for those who still need it.
                                            Best regards,
                                                    Petr Vandrovec
                                                    vandrove@vc.cvut.cz
                                                    
