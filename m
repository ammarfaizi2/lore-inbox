Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262403AbTEII4G (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 04:56:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262407AbTEII4G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 04:56:06 -0400
Received: from a089148.adsl.hansenet.de ([213.191.89.148]:24775 "EHLO
	sfhq.hn.org") by vger.kernel.org with ESMTP id S262403AbTEII4F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 04:56:05 -0400
Message-ID: <3EBB6FFF.3080709@portrix.net>
Date: Fri, 09 May 2003 11:08:15 +0200
From: Jan Dittmer <j.dittmer@portrix.net>
Organization: portrix.net GmbH
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4b) Gecko/20030507
X-Accept-Language: en
MIME-Version: 1.0
To: Giuliano Pochini <pochini@shiny.it>
CC: Torrey Hoffman <thoffman@arnor.net>,
       Linux Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ALSA busted in 2.5.69
References: <XFMail.20030509100906.pochini@shiny.it>
In-Reply-To: <XFMail.20030509100906.pochini@shiny.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Giuliano Pochini wrote:
> On 08-May-2003 Torrey Hoffman wrote:
> 
>>ALSA isn't working for me in 2.5.69.  It appears to be because
>>/proc/asound/dev is missing the control devices.
>>open("/dev/snd/controlC0", O_RDWR)      = -1 ENOENT (No such file or
>>directory)
>>[...]
> 
> 
> If you are not using devfs, you need to create the devices. There is a
> script in the ALSA-driver package to do that. Otherwise I can't help
> you because I never tried devfs and linux 2.5.x.
> 

I've the same problem, using devfs: (.69-mm3)

ds666:/dev/snd# ls -l
total 0
crw-rw----    1 root     audio    116,   0 Jan  1  1970 controlC0
crw-rw----    1 root     audio    116,  32 Jan  1  1970 controlC1
crw-rw----    1 root     audio    116,  64 Jan  1  1970 controlC2
crw-rw----    1 root     audio    116,  96 Jan  1  1970 controlC3
crw-rw----    1 root     audio    116, 128 Jan  1  1970 controlC4
crw-rw----    1 root     audio    116, 160 Jan  1  1970 controlC5
crw-rw----    1 root     audio    116, 192 Jan  1  1970 controlC6
crw-rw----    1 root     audio    116, 224 Jan  1  1970 controlC7

CONFIG_SND=y
CONFIG_SND_SEQUENCER=y
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=y
CONFIG_SND_PCM_OSS=y
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=y
CONFIG_SND_EMU10K1=y
CONFIG_SND_VIA82XX=m

CONFIG_DEVFS_FS=y
CONFIG_DEVFS_MOUNT=y
CONFIG_DEVPTS_FS=y


