Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268401AbUIHVdg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268401AbUIHVdg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 8 Sep 2004 17:33:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269164AbUIHVdg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 8 Sep 2004 17:33:36 -0400
Received: from smtp-out6.blueyonder.co.uk ([195.188.213.9]:52666 "EHLO
	smtp-out6.blueyonder.co.uk") by vger.kernel.org with ESMTP
	id S268401AbUIHVdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 8 Sep 2004 17:33:33 -0400
Message-ID: <413F7AAC.2040004@blueyonder.co.uk>
Date: Wed, 08 Sep 2004 22:33:32 +0100
From: Sid Boyce <sboyce@blueyonder.co.uk>
Reply-To: sboyce@blueyonder.co.uk
User-Agent: Mozilla Thunderbird 0.6 (X11/20040502)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Tonnerre <tonnerre@thundrix.ch>
CC: linux-kernel@vger.kernel.org
Subject: Re: -bk15 oops on mounting cdrom
References: <413F2935.4020009@blueyonder.co.uk> <20040908155931.GB2726@thundrix.ch>
In-Reply-To: <20040908155931.GB2726@thundrix.ch>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 08 Sep 2004 21:33:57.0086 (UTC) FILETIME=[8BF06FE0:01C495EB]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tonnerre wrote:

>Salut,
>
>On Wed, Sep 08, 2004 at 04:45:57PM +0100, Sid Boyce wrote:
>  
>
>>Modules linked in: nls_iso8859_1 nvidia parport_pc lp parport sg st sd_mod sr_mod scsi_mod thermal snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss sk98lin snd_intel8x0 processor ub usblp fan usbhid snd_ac97_codec snd_pcm snd_timer snd_page_alloc gameport snd_mpu 401_uart snd_rawmidi snd_seq_device snd button ipv6 soundcore ohci1394 ieee1394 ehci_hcd nvidia_agp agpgart ohci_hcd evdev usbcore forcedeth vfat fat dm_mod
>>0060:[cache_free_debugcheck+385/640]    Tainted: P   VLI
>>    
>>
>
>You  may  want  to  reproduce  that  bug  without  the  nvidia  module
>loaded. This doesn't sound like  much, but I even had strange problems
>after registering a simple webcam to the kernel which kept it crashing
>while accessing  data structures that  have clearly been  there before
>(but  yet it  claimed that  the  memory address  wasn't assigned).  It
>turned  out that my  customer had  the NVidia  module loaded.  Once he
>unloaded it, everything was running fine.
>
>So please consider  a clean boot without ever  loading nvidia, and try
>to reproduce the bug.
>
>			    Tonnerre
>  
>
It's repeatable under anything other than 2.6.8-rc4-mm1, the earliest 
kernel I have here. As a test, I attached another cdrom as hdd and got 
the same oops under 2.6.9-rc1-bk15, same problem and as far as I can 
tell anything from 2.6.8.1 onwards gives the same fault.
Now running under 2.6.8-rc4-mm1 without problems, so it looks like a 
kernel bug.
barrabas:/ftp/sep04 # ls /media/dvd
.            autorun.inf  content      COPYING.de    directory.yast  
gpg-pubkey-3d25d3d9-36e12d04.asc  LIESMICH      media.1      README.DOS
..           boot         control.xml  COPYRIGHT     docu            
gpg-pubkey-9c800aca-39eef481.asc  LIESMICH.DOS  pubring.gpg  suse
ARCHIVES.gz  ChangeLog    COPYING      COPYRIGHT.de  dosutils        
INDEX.gz                          ls-lR.gz      README       SuSEgo.ico
barrabas:/ftp/sep04 # ls /media/dvd/suse
.  ..  i586  i686  noarch  setup

Regards
Sid.

-- 
Sid Boyce .... Hamradio G3VBV and keen Flyer
=====LINUX ONLY USED HERE=====

