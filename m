Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265261AbUEUX5x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265261AbUEUX5x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 May 2004 19:57:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264732AbUEUXyO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 May 2004 19:54:14 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:33733 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S265176AbUEUXgR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 May 2004 19:36:17 -0400
Date: Wed, 19 May 2004 19:49:19 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: Andrew Morton <akpm@osdl.org>, Fred Gleason <fredg@wava.com>
Cc: linux-kernel@vger.kernel.org
Subject: 2.6.6-mm4: readq compile error
Message-ID: <20040519174919.GG22742@fs.tum.de>
References: <20040519040421.61263a43.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040519040421.61263a43.akpm@osdl.org>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 19, 2004 at 04:04:21AM -0700, Andrew Morton wrote:
>...
> Changes since 2.6.6-mm3:
>...
> +add-i386-readq.patch
> 
>  Add readq() and writeq() implementations on ia32.
>...

This causes a compilation error due to a symbol with the same name in 
drivers/media/radio/radio-cadet.c:

<--  snip  -->

...
  CC      drivers/media/radio/radio-cadet.o
drivers/media/radio/radio-cadet.c:48: error: `readq' redeclared as 
different kind of symbol
include/asm/io.h:368: error: previous declaration of `readq'
make[3]: *** [drivers/media/radio/radio-cadet.o] Error 1

<--  snip  -->

cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

