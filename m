Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261695AbTI3UCS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Sep 2003 16:02:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261699AbTI3UCS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Sep 2003 16:02:18 -0400
Received: from pop.gmx.de ([213.165.64.20]:5063 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261695AbTI3UCO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Sep 2003 16:02:14 -0400
X-Authenticated: #18658533
Date: Tue, 30 Sep 2003 21:53:14 +0200
From: Nikola Knezevic <nikkne@gmx.ch>
X-Mailer: The Bat! (v1.62r) Personal
Reply-To: Nikola Knezevic <nikkne@gmx.ch>
Organization: necto
X-Priority: 3 (Normal)
Message-ID: <1211381655.20030930215314@gmx.ch>
To: Takashi Iwai <tiwai@suse.de>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: PROBLEM: ALSA requests module to early, before / is mounted
In-Reply-To: <s5hpthjboey.wl@alsa2.suse.de>
References: <1409343736.20030926151652@gmx.ch> <s5hhe2z7jst.wl@alsa2.suse.de>
 <14910696880.20030926220441@gmx.ch> <s5hpthjboey.wl@alsa2.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kad bi 17:32:53, Takashi rece:
>> But I build one. modprobe snd-emu10k1 loads it.
TI> did you put this module into initrd?
TI> otherwise there is NO way to load the MODULE at that time (before
TI> mounting the root).

Here is some oddity. I've compiled all sound stuff into kernel. I've
also have devfs enabled, and I've put in /etc/modules.conf [1]:
alias snd-card-0 snd-emu10k1
alias sound-slot-0 snd-card-0

And here is what dmesg says with 2.6.0-test6 [2]:
Advanced Linux Sound Architecture Driver Version 0.9.7 (Thu Sep 25 19:16:36 2003 UTC).
request_module: failed /sbin/modprobe -- snd-card-0. error = -16
ALSA device list:
  #0: Sound Blaster Live! (rev.7) at 0xd800, irq 10

Hah???

[1]: devfsd reads /etc/modules.conf, but module-init-tools use
modprobe.conf. Should't this be changed?
[2]: I haven't tried that with test5, but I suppose the same thing would
happen.
-- 
 .            `\!,        
 .            <. .>    
 [=======oOo==( ^ )==oOo========[ indy@hemo.net ]=======]      
 |---      _    -            --- [    member of    ]--- |        
 [========( )======_==============[ .counter attack. ]==]           
 .         ()     ( )
 .                ()

