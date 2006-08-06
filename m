Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750937AbWHFSn0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750937AbWHFSn0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 6 Aug 2006 14:43:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750954AbWHFSn0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 6 Aug 2006 14:43:26 -0400
Received: from vcs5.camavision.com ([63.228.164.252]:45276 "EHLO
	marajade.camavision.com") by vger.kernel.org with ESMTP
	id S1750899AbWHFSnZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Aug 2006 14:43:25 -0400
Message-ID: <44D6383E.7050000@squeakycode.net>
Date: Sun, 06 Aug 2006 13:43:10 -0500
From: andy <andy@squeakycode.net>
User-Agent: Thunderbird 1.5.0.5 (Windows/20060719)
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: asus m5n, i2c-i805 missing temp1_auto_temp_min
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi list,

I have an asus m5n laptop, with kernel 2.6.16.9, and this works:

if cd '/sys/devices/pci0000:00/0000:00:1f.3/i2c-0/0-002e'; then
     echo 55000 > temp1_auto_temp_min
     echo 50000 > temp1_auto_temp_off
fi

However in kernel 2.6.16.27, and 2.6.17.7 it does not.  It reports that 
directory is not found (I can get to '/sys/devices/pci0000:00/' and 
thats it).  Its only for setting the fan on/off temp's, so its not a big 
deal, but it makes my laptop quieter when its not doing anything, so I 
kinda like it.

Is there a new way of doing this?  Or was it moved to another module? 
Or broken?

I am not subscribed to the lkml so if you need info from me please cc me 
directly.


lsmod shows:

Module                  Size  Used by
joydev                  8512  0
psmouse                38536  0
evdev                   8448  0
eeprom                  5648  0
lm85                   31780  0
hwmon_vid               2432  1 lm85
hwmon                   2324  1 lm85
i2c_i801                7820  0
i2c_core               17296  3 eeprom,lm85,i2c_i801
cpufreq_ondemand        5148  1
snd_pcm_oss            49440  0
snd_mixer_oss          17280  1 snd_pcm_oss
ipv6                  244224  20
ohci_hcd               19076  0
intel_agp              20764  1
uhci_hcd               30480  0
ehci_hcd               31112  0
shpchp                 42944  0
i8xx_tco                6036  0
snd_intel8x0           29852  0
snd_ac97_codec         94240  1 snd_intel8x0
snd_ac97_bus            1920  1 snd_ac97_codec
snd_pcm                80392  3 snd_pcm_oss,snd_intel8x0,snd_ac97_codec
snd_timer              20868  1 snd_pcm
snd                    45796  6 
snd_pcm_oss,snd_mixer_oss,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
soundcore               7392  1 snd
snd_page_alloc          8712  2 snd_intel8x0,snd_pcm
yenta_socket           24844  1
rsrc_nonstatic         12160  1 yenta_socket
pcmcia_core            35984  2 yenta_socket,rsrc_nonstatic
ohci1394               31792  0
ieee1394               89272  1 ohci1394
8139too                22912  0
mii                     5120  1 8139too
xfs                   551860  1
exportfs                4736  1 xfs
agpgart                28976  1 intel_agp


Thanks for your time,

-Andy
