Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264348AbTKMRBQ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Nov 2003 12:01:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264355AbTKMRBQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Nov 2003 12:01:16 -0500
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:20973 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264348AbTKMRBP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Nov 2003 12:01:15 -0500
Date: Thu, 13 Nov 2003 18:01:08 +0100
From: Adrian Bunk <bunk@fs.tum.de>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
       lse-tech <lse-tech@lists.sourceforge.net>
Subject: 2.6.0-test9-mjb2: emulex driver link error
Message-ID: <20031113170108.GN10456@fs.tum.de>
References: <85450000.1068220085@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <85450000.1068220085@[10.10.2.4]>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 07, 2003 at 07:48:05AM -0800, Martin J. Bligh wrote:
>...
> emulex driver					Emulex
> 	Driver for emulex fiberchannel cards
>...

"copyin" and "copyout" aren't good names for non-static functions:

<--  snip  -->

...
  LD      drivers/built-in.o
drivers/scsi/built-in.o(.text+0x1182c0): In function `copyout':
: multiple definition of `copyout'
drivers/char/built-in.o(.text+0x58fe0): first defined here
ld: Warning: size of symbol `copyout' changed from 95 in 
drivers/char/built-in.o to 55 in drivers/scsi/built-in.o
drivers/scsi/built-in.o(.text+0x118300): In function `copyin':
: multiple definition of `copyin'
drivers/char/built-in.o(.text+0x58f60): first defined here
ld: Warning: size of symbol `copyin' changed from 125 in 
drivers/char/built-in.o to 88 in drivers/scsi/built-in.o
make[1]: *** [drivers/built-in.o] Error 1
make: *** [drivers] Error 2

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

