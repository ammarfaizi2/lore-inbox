Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271432AbTGQLQx (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 17 Jul 2003 07:16:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271433AbTGQLQx
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 17 Jul 2003 07:16:53 -0400
Received: from mx2.it.wmich.edu ([141.218.1.94]:27130 "EHLO mx2.it.wmich.edu")
	by vger.kernel.org with ESMTP id S271432AbTGQLQv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 17 Jul 2003 07:16:51 -0400
Message-ID: <3F168920.8080007@wmich.edu>
Date: Thu, 17 Jul 2003 07:31:44 -0400
From: Ed Sweetman <ed.sweetman@wmich.edu>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030628
X-Accept-Language: en
MIME-Version: 1.0
To: ookhoi@humilis.net
CC: Takashi Iwai <tiwai@suse.de>, Linux-Kernel <linux-kernel@vger.kernel.org>,
       eugene.teo@eugeneteo.net
Subject: Re: 2.6 sound drivers?
References: <20030716225826.GP2412@rdlg.net> <20030716231029.GG1821@matchmail.com> <20030716233045.GR2412@rdlg.net> <1058426808.1164.1518.camel@workshop.saharacpt.lan> <20030717085704.GA1381@eugeneteo.net> <s5hu19lzevt.wl@alsa2.suse.de> <20030717111958.GB30717@favonius>
In-Reply-To: <20030717111958.GB30717@favonius>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ookhoi wrote:
> Takashi Iwai wrote (ao):
> 
>>At Thu, 17 Jul 2003 16:57:04 +0800,
>>Eugene Teo wrote:
>>
>>>One thing I noticed abt this ALSA driver is that if I am playing
>>>say, xmms at the moment, any additional sound output will be delayed
>>>until I stop xmms. Is there any workaround? 
>>>
>>>Using Intel(r) AC'97 Audio Controller - Sigmatel 9723 Codec
>>
>>the intel chip supports only one stream for playback, so the
>>succeeding open is blocked since ALSA opens the device in the blocking
>>mode as default.  and it's so for OSS-emulation, too.
>>
>>for the oss-emulation, you can change this behavior via the module
>>option nonblock_open of snd-pcm-oss module.  please check
>>Documentation/sound/alsa/OSS-Emulation.txt.
> 
> 
> Wouldn't esd (the enlightment sound daemon) take care of this in
> userspace? I can have sound out of xmms, firebird, mpg321 and mplayer at
> the same time with esd.

Most people would rather not use esd, especially when you dont need to 
use any userspace deamon to do the job.

