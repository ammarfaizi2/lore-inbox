Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261589AbTIZUE4 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 26 Sep 2003 16:04:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261620AbTIZUE4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 26 Sep 2003 16:04:56 -0400
Received: from pop.gmx.de ([213.165.64.20]:41660 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S261589AbTIZUEy (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 26 Sep 2003 16:04:54 -0400
X-Authenticated: #18658533
Date: Fri, 26 Sep 2003 22:04:41 +0200
From: Nikola Knezevic <nikkne@gmx.ch>
X-Mailer: The Bat! (v1.62r) Personal
Reply-To: Nikola Knezevic <nikkne@gmx.ch>
Organization: necto
X-Priority: 3 (Normal)
Message-ID: <14910696880.20030926220441@gmx.ch>
To: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: ALSA requests module to early, before / is mounted
In-Reply-To: <s5hhe2z7jst.wl@alsa2.suse.de>
References: <1409343736.20030926151652@gmx.ch> <s5hhe2z7jst.wl@alsa2.suse.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Samo sto izbi 15:37, kad Takashi rece:

>> Hi, I'm really annoyed to see 'No soundcards found.' in logs:)

TI> you didn't build in emu10k1 driver.  so, at that stage, there is
TI> really no available card :)

But I build one. modprobe snd-emu10k1 loads it.

>> Not an expert, but according to logs, ALSA is modprobeing to early, so
>> it doesn't load snd-emu10k.

TI> yep, this should be avoided before root is mounted.

But for the time being, it isn't...

>>  There is no call for modprobe snd-emu10k1 in
>> rc.modules, so after booting I have to call it manually. Yes, I could
>> put that call in rc.modules, but isn't it supposed to be called by ALSA?

TI> yes, but only if you set up /etc/modprobe.conf correctly to load the
TI> modules automatically.
TI> at least, you have to specify which card is the first one
TI> (snd-card-0).

Did that long time ago, problem remains. Also, I'm using devfs.

TI> i recommend you either to build all ALSA stuffs as modules or to build
TI> them into the kernel.

Something is build as modules, something went into kernel. Please see my
message named: PROBLEM: <oops when unplugging USB Flash disk, somewhere
in SCSI subsystem>, there is my .config file.



-- 
... Virus check complete. All viruses functioning normaly!
 
Nikola Knezevic
 [homepage: http://users.hemo.net/indy] 
 [jabberID: indy@jabber.at]

