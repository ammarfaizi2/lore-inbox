Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317419AbSFROPE>; Tue, 18 Jun 2002 10:15:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317421AbSFROPD>; Tue, 18 Jun 2002 10:15:03 -0400
Received: from hirsch.in-berlin.de ([192.109.42.6]:54408 "EHLO
	hirsch.in-berlin.de") by vger.kernel.org with ESMTP
	id <S317419AbSFROPC>; Tue, 18 Jun 2002 10:15:02 -0400
X-Envelope-From: kraxel@bytesex.org
Date: Tue, 18 Jun 2002 15:16:37 +0200
From: Gerd Knorr <kraxel@suse.de>
To: Adrian Bunk <bunk@fs.tum.de>, Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: 2.4.19-pre build failure
Message-ID: <20020618151637.B4941@bytesex.org>
References: <20020618111041.A3317@bytesex.org> <Pine.NEB.4.44.0206181221230.10290-100000@mimas.fachschaften.tu-muenchen.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.NEB.4.44.0206181221230.10290-100000@mimas.fachschaften.tu-muenchen.de>
User-Agent: Mutt/1.3.20i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > init/do_mounts.o: In function `rd_load_disk':
> > init/do_mounts.o(.text.init+0xb08): undefined reference to `change_floppy'
> 
> Does the following fix it for you?
> 
> -#if defined(CONFIG_BLOCK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)
> +#if defined(CONFIG_BLK_DEV_RAM) || defined(CONFIG_BLK_DEV_FD)

Yes, works.

  Gerd

-- 
You can't please everybody.  And usually if you _try_ to please
everybody, the end result is one big mess.
				-- Linus Torvalds, 2002-04-20
