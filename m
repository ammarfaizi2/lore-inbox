Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310666AbSEALfI>; Wed, 1 May 2002 07:35:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310769AbSEALfH>; Wed, 1 May 2002 07:35:07 -0400
Received: from ulima.unil.ch ([130.223.144.143]:25991 "HELO ulima.unil.ch")
	by vger.kernel.org with SMTP id <S310666AbSEALfG>;
	Wed, 1 May 2002 07:35:06 -0400
Date: Wed, 1 May 2002 13:35:05 +0200
From: Gregoire Favre <greg@ulima.unil.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.5.12 compil error
Message-ID: <20020501113505.GA17077@ulima.unil.ch>
In-Reply-To: <20020501085535.GA14645@ulima.unil.ch> <Pine.GSO.4.21.0205010503150.11514-100000@weyl.math.psu.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 01, 2002 at 05:03:57AM -0400, Alexander Viro wrote:

> > sorry if it has altrady been posted: I have looked for it at google but
> > didn't found it...
> 
> you forgot to redo make dep after patching.

Hello,

yes and no: I do:
make oldconfig
make dep bzImage modules

Isn't that supposed to be enough?
If someone has an explanation, please CC to me: I am not on lk.
What I don't understand is that, effectively, running make bzImage
modules again works...

Well, more or less: the fbcon-cfg8.c is still broken as is 2.5.11, but
http://www.transvirtual.com/%7Ejsimmons/fbdev_fixs.diff apply also
cleanly and my kernel and modules are now compiled ;-))

I just got while sudo make modules_install:
cd /lib/modules/2.5.12; \
mkdir -p pcmcia; \
find kernel -path '*/pcmcia/*' -name '*.o' | xargs -i -r ln -sf ../{} pcmcia
if [ -r System.map ]; then /sbin/depmod -ae -F System.map  2.5.12; fi
depmod: *** Unresolved symbols in /lib/modules/2.5.12/kernel/fs/jfs/jfs.o
depmod: 	block_flushpage
make: *** [_modinst_post] Error 1

But I don't need jfs: I just wanted to try it...

Google is very good for those problems...

It's time to reboot :-))

Thanks you very much,

	Grégoire
________________________________________________________________
http://ulima.unil.ch/greg ICQ:16624071 mailto:greg@ulima.unil.ch
