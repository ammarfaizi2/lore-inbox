Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317269AbSGIADE>; Mon, 8 Jul 2002 20:03:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317270AbSGIADD>; Mon, 8 Jul 2002 20:03:03 -0400
Received: from pD9E238F8.dip.t-dialin.net ([217.226.56.248]:26074 "EHLO
	hawkeye.luckynet.adm") by vger.kernel.org with ESMTP
	id <S317269AbSGIADB>; Mon, 8 Jul 2002 20:03:01 -0400
Date: Mon, 8 Jul 2002 18:05:17 -0600 (MDT)
From: Thunder from the hill <thunder@ngforever.de>
X-X-Sender: thunder@hawkeye.luckynet.adm
To: Richard Gooch <rgooch@ras.ucalgary.ca>
cc: linux-kernel@vger.kernel.org, Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: 2.4.19-rc1 doesn't link
In-Reply-To: <200207082330.g68NUtH01899@vindaloo.ras.ucalgary.ca>
Message-ID: <Pine.LNX.4.44.0207081803250.10105-100000@hawkeye.luckynet.adm>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 8 Jul 2002, Richard Gooch wrote:
> init/do_mounts.o: In function `rd_load_image':
> init/do_mounts.o(.text.init+0x941): undefined reference to `change_floppy'
> init/do_mounts.o: In function `rd_load_disk':
> init/do_mounts.o(.text.init+0xa9b): undefined reference to `change_floppy'
> make: *** [vmlinux] Error 1

Strange thing. All three are #ifdef CONFIG_BLK_DEV_RAM, so if you enable 
BLK_DEV_RAM, you get all three. Do you have CONFIG_BLK_DEV_FD enabled?

							Regards,
							Thunder
-- 
(Use http://www.ebb.org/ungeek if you can't decode)
------BEGIN GEEK CODE BLOCK------
Version: 3.12
GCS/E/G/S/AT d- s++:-- a? C++$ ULAVHI++++$ P++$ L++++(+++++)$ E W-$
N--- o?  K? w-- O- M V$ PS+ PE- Y- PGP+ t+ 5+ X+ R- !tv b++ DI? !D G
e++++ h* r--- y- 
------END GEEK CODE BLOCK------

