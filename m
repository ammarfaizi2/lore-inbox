Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264047AbTFVXaq (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Jun 2003 19:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264143AbTFVXaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Jun 2003 19:30:46 -0400
Received: from hermes.fachschaften.tu-muenchen.de ([129.187.202.12]:29645 "HELO
	hermes.fachschaften.tu-muenchen.de") by vger.kernel.org with SMTP
	id S264047AbTFVXap (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Jun 2003 19:30:45 -0400
Date: Mon, 23 Jun 2003 01:44:47 +0200
From: Adrian Bunk <bunk@fs.tum.de>
To: ambx1@neo.rr.com
Cc: Kernel Mailing List <linux-kernel@vger.kernel.org>, perex@suse.cz,
       alsa-devel@alsa-project.org
Subject: 2.5.73: ALSA ISA pnp_init_resource_table compile errors
Message-ID: <20030622234447.GB3710@fs.tum.de>
References: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0306221150440.17823-100000@old-penguin.transmeta.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 22, 2003 at 11:53:14AM -0700, Linus Torvalds wrote:
>...
> Summary of changes from v2.5.72 to v2.5.73
> ============================================
>...
> Adam Belay:
>   o [PNP] Resource Management Cleanups and Updates
>...

This patch removed pnp_init_resource_table, but several drivers under 
sound/isa/ still use it, resulting in compile errors like the following:

<--  snip  -->

...
  CC      sound/isa/ad1816a/ad1816a.o
sound/isa/ad1816a/ad1816a.c: In function `snd_card_ad1816a_pnp':
sound/isa/ad1816a/ad1816a.c:143: warning: implicit declaration of 
function `pnp_init_resource_table'
...
  LD      .tmp_vmlinux1
sound/built-in.o(.text+0x349c7): In function `snd_card_ad1816a_pnp':
: undefined reference to `pnp_init_resource_table'
sound/built-in.o(.text+0x34ad3): In function `snd_card_ad1816a_pnp':
: undefined reference to `pnp_init_resource_table'
make: *** [.tmp_vmlinux1] Error 1

<--  snip  -->


cu
Adrian

-- 

       "Is there not promise of rain?" Ling Tan asked suddenly out
        of the darkness. There had been need of rain for many days.
       "Only a promise," Lao Er said.
                                       Pearl S. Buck - Dragon Seed

