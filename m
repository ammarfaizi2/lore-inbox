Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262865AbSKAMYs>; Fri, 1 Nov 2002 07:24:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264954AbSKAMYs>; Fri, 1 Nov 2002 07:24:48 -0500
Received: from service.sh.cvut.cz ([147.32.127.214]:54800 "EHLO
	service.sh.cvut.cz") by vger.kernel.org with ESMTP
	id <S262865AbSKAMYr>; Fri, 1 Nov 2002 07:24:47 -0500
Date: Fri, 1 Nov 2002 13:31:01 +0100
From: Michal Rokos <m.rokos@sh.cvut.cz>
To: Takashi Iwai <tiwai@suse.de>
Cc: linux-kernel@vger.kernel.org, alsa-devel@lists.sourceforge.net
Subject: Re: Alsa vs ALi5451
Message-ID: <20021101123101.GB5133@nightmare.sh.cvut.cz>
References: <20021029214043.GA28410@nightmare.sh.cvut.cz> <s5hk7jzbzg4.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <s5hk7jzbzg4.wl@alsa2.suse.de>
User-Agent: Mutt/1.3.28i
X-Crypto: GnuPG/1.0.6 http://www.gnupg.org
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Oct 30, 2002 at 06:37:15PM +0100, Takashi Iwai wrote:
> >     I'm having problem with ALi5451 audio chipset.
> > 
> >     Insmod segfaults and lsmod says that initializing the snd-ali5451. The wierd is the OSS trident module is working just fine (with some limitation - I can't make it work throught the phones), but it's workin'. So I guess it's alsa problem.
> >     
> >     Please, keep me in CC - I'm not on list.
> 
> does the attached patch cure?

	No - yes, but just a bit. There's no coredump anymore.

	modprobe snd-ali5451 now says "ali create: chip init error"
	nothing more. Sound doesn't work.

		Michal


nb15:~# lsmod
Module                  Size  Used by    Not tainted
snd-ali5451            16608   0  (unused)
snd-pcm                86112   0  [snd-ali5451]
snd-timer              16280   0  [snd-pcm]
snd-ac97-codec         35172   0  [snd-ali5451]
snd                    40356   0  [snd-ali5451 snd-pcm snd-timer
snd-ac97-codec]
soundcore               6724   0  [snd]
8139too                18108   1
mii                     3848   0  [8139too]
nls_iso8859-2           4092   1  (autoclean)
nls_cp852               4316   1  (autoclean)
vfat                   11840   1  (autoclean)
fat                    45240   0  (autoclean) [vfat]
crc32                   1732   1  [8139too]

	looks good, but doesn't work

nb15:~# alsactl -d power
alsactl: power:1257: No soundcards found...

	but no cards found...

-- 
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
Ing. Michal Rokos                    Czech Technical University, Prague
e-mail: m.rokos@sh.cvut.cz    icq: 36118339     jabber: majkl@jabber.cz
-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
