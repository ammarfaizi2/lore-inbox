Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbTDEAPN (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 19:15:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261504AbTDEAPN (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 19:15:13 -0500
Received: from inet-mail3.oracle.com ([148.87.2.203]:38831 "EHLO
	inet-mail3.oracle.com") by vger.kernel.org with ESMTP
	id S261501AbTDEAPM (for <rfc822;linux-kernel@vger.kernel.org>); Fri, 4 Apr 2003 19:15:12 -0500
Message-ID: <3E8E22A8.3040905@oracle.com>
Date: Sat, 05 Apr 2003 02:26:16 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4a) Gecko/20030325
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Mathias Kretschmer <mathias@lemur.sytes.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.21-pre7: compilation error in ac97_codec.c
References: <3E8E1243.70208@lemur.sytes.net>
In-Reply-To: <3E8E1243.70208@lemur.sytes.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mathias Kretschmer wrote:
> gcc -D__KERNEL__ -I/usr/src/linux-2.4.20/include -Wall 
> -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common 
> -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686 
> -nostdinc -iwithprefix include -DKBUILD_BASENAME=ac97_codec 
> -DEXPORT_SYMTAB -c ac97_codec.c
> ac97_codec.c:131: `AC97_NO_PCM_VOLUME' undeclared here (not in a function)
> ac97_codec.c:131: initializer element is not constant
> ac97_codec.c:131: (near initialization for `ac97_codec_ids[12].flags')
> ac97_codec.c:132: `AC97_NO_PCM_VOLUME' undeclared here (not in a function)
> ac97_codec.c:132: initializer element is not constant
> ac97_codec.c:132: (near initialization for `ac97_codec_ids[13].flags')
> ac97_codec.c:133: `AC97_NO_PCM_VOLUME' undeclared here (not in a function)
> ac97_codec.c:133: initializer element is not constant
> ac97_codec.c:133: (near initialization for `ac97_codec_ids[14].flags')
> ac97_codec.c:144: `AC97_DELUDED_MODEM' undeclared here (not in a function)
> ac97_codec.c:144: initializer element is not constant
> ac97_codec.c:144: (near initialization for `ac97_codec_ids[25].flags')
> ac97_codec.c: In function `ac97_probe_codec':
> ac97_codec.c:763: structure has no member named `modem'

[snip]

Same for i810_audio:

gcc -D__KERNEL__ -I/share/src/linux-2.4.21-pre7/include -Wall -Wstrict-prototypes -Wno-trigraphs -O2 -fno-strict-aliasing -fno-common -fomit-frame-pointer -pipe -mpreferred-stack-boundary=2 -march=i686   -nostdinc -iwithprefix include -DKBUILD_BASENAME=i810_audio  -c -o i810_audio.o i810_audio.c
i810_audio.c: In function `i810_ac97_init':
i810_audio.c:2930: structure has no member named `modem'
i810_audio.c: In function `i810_probe':
i810_audio.c:3261: warning: label `out_chan' defined but not used
make[3]: *** [i810_audio.o] Error 1
make[3]: Leaving directory `/share/src/linux-2.4.21-pre7/drivers/sound'
make[2]: *** [first_rule] Error 2
make[2]: Leaving directory `/share/src/linux-2.4.21-pre7/drivers/sound'
make[1]: *** [_subdir_sound] Error 2
make[1]: Leaving directory `/share/src/linux-2.4.21-pre7/drivers'
make: *** [_dir_drivers] Error 2

--alessandro

  "Se e' vero che ad ogni rinuncia corrisponde una contropartita considerevole
    privarsi dell'anima comporterebbe una lauta ricompensa"
       (Carmen Consoli, "L'eccezione")

