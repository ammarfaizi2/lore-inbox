Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129749AbRCGATt>; Tue, 6 Mar 2001 19:19:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129740AbRCGATj>; Tue, 6 Mar 2001 19:19:39 -0500
Received: from cr626425-a.bloor1.on.wave.home.com ([24.156.35.8]:23303 "EHLO
	spqr.damncats.org") by vger.kernel.org with ESMTP
	id <S129741AbRCGAT3>; Tue, 6 Mar 2001 19:19:29 -0500
Message-ID: <3AA57D2A.34223B4E@damncats.org>
Date: Tue, 06 Mar 2001 19:13:30 -0500
From: John Cavan <johnc@damncats.org>
X-Mailer: Mozilla 4.75 [en] (X11; U; Linux 2.4.2-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Phil Oester <kernel@theoesters.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: Error compiling aic7xxx driver on 2.4.2-ac13
In-Reply-To: <000f01c0a697$3b1924f0$0200a8c0@theoesters.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Phil Oester wrote:
> 
> one more try...
> 
> anyone else get the following:
> 
> make[5]: Entering directory
> `/usr/src/linux-2.4.2-ac13/drivers/scsi/aic7xxx/aicasm'
> lex  -t aicasm_scan.l > aicasm_scan.c
> gcc -I/usr/include -ldb aicasm_gram.c aicasm_scan.c aicasm.c
> aicasm_symbol.c -o aicasm
> aicasm_symbol.c:39: db/db_185.h: No such file or directory
> make[5]: *** [aicasm] Error 1
> make[5]: Leaving directory
> `/usr/src/linux-2.4.2-ac13/drivers/scsi/aic7xxx/aicasm'

The location of db_185.h is somewhat vendor dependent. In my case
(Mandrake cooker), the location is in /usr/include/db3 rather than
/usr/include/db. You have a couple of choices for now... symlink db3 to
db if that is your situation or back out that portion of the patch to
use the original db1 library. I personally chose the symlink, but it
does highlight the problem of having userspace dependencies in the
tree...

John
