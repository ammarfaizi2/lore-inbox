Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932367AbWDCIOs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932367AbWDCIOs (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Apr 2006 04:14:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932382AbWDCIOs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Apr 2006 04:14:48 -0400
Received: from smtp2.Stanford.EDU ([171.67.16.125]:55198 "EHLO
	smtp2.Stanford.EDU") by vger.kernel.org with ESMTP id S932367AbWDCIOs
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Apr 2006 04:14:48 -0400
From: Felix Schmitt <fschmitt@stanford.edu>
To: linux-kernel@vger.kernel.org
Subject: Minor(maybe even impossible) request: WPA with Hermes?
Date: Mon, 3 Apr 2006 01:15:00 -0700
User-Agent: KMail/1.8.3
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Message-Id: <200604030115.00344.fschmitt@stanford.edu>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,
I would like to run WPA (not WPA2) with my Lucent WaveLan/IEEE (pcmcia) 
(11mbit/s), but the linux wireless extension seems only to be implemented in 
the atmel (2.6.16 kernel), the ipw2100 and the ipw2200 wireless drivers. I 
conclude that from wpa_supplement (using the wext driver) complaining:
ioctl[SIOCSIWENCODEEXT]: Operation not supported
[...]
I am not that good at this stuff, but
- Since the WaveLan/IEEE is 802.11b compatible, it should be able to handle 
WPA (which is --- roughly speaking --- a spiced-up WEP, unlike WPA2 which is 
802.11i) ?
- Is there a WPA capability for the Hermes-based cards planned in the future? 
(there are drivers from Agere, version 7.22, but they are horribly old with 
outdated kernel patches. I would rather like to use the linux wireless 
extensions...)

Thanks very much for your help!

----++== Please CC me on the answer. ==++----

Felix

======== HW-info ========
=======================
gentoo, linux-2.6.15-gentoo-r1, sony vaio srx-pcg41p, 256mb, P3 800MHz

~ # cardctl ident
Socket 0:
  no product info available
Socket 1:
  product info: "Lucent Technologies", "WaveLAN/IEEE", "Version 01.01", ""
  manfid: 0x0156, 0x0002
  function: 6 (network)

wireless # /etc/init.d/net.eth1 start
 * Starting eth1
 *   Starting wpa_supplicant on eth1 ...
ioctl[SIOCSIWAUTH]: Operation not supported
WEXT auth param 7 value 0x1 - ioctl[SIOCSIWENCODEEXT]: Operation not supported
ioctl[SIOCSIWENCODE]: Invalid argument
ioctl[SIOCSIWENCODEEXT]: Operation not supported
ioctl[SIOCSIWENCODE]: Invalid argument
ioctl[SIOCSIWENCODEEXT]: Operation not supported
ioctl[SIOCSIWENCODE]: Invalid argument
ioctl[SIOCSIWENCODEEXT]: Operation not supported
ioctl[SIOCSIWENCODE]: Invalid argument
ioctl[SIOCSIWAUTH]: Operation not supported
WEXT auth param 4 value 0x0 - ioctl[SIOCSIWAUTH]: Operation not supported
 *     timed out5 value 0x1 -

~ $ lsmod
Module                  Size  Used by
orinoco_tmd             3680  0
orinoco_plx             4736  0
orinoco_pci             4896  0
snd_pcm_oss            41536  0
ieee80211_crypt_wep     3520  0
ieee80211_crypt_tkip     8768  0
ieee80211_crypt_ccmp     5664  0
ieee80211              26120  0
ieee80211_crypt         4288  4 
ieee80211_crypt_wep,ieee80211_crypt_tkip,ieee80211_crypt_ccmp,ieee80211
snd_mixer_oss          14144  1 snd_pcm_oss
vfat                    9280  1
fat                    39900  1 vfat
sd_mod                 11760  0
usbhid                 25892  0
usb_storage            29572  0
scsi_mod               75688  2 sd_mod,usb_storage
orinoco_cs             14632  1
pcmcia                 28876  5 orinoco_cs
firmware_class          7264  1 pcmcia
crc32                   3872  3 
ieee80211_crypt_wep,ieee80211_crypt_tkip,pcmcia
orinoco                34036  4 orinoco_tmd,orinoco_plx,orinoco_pci,orinoco_cs
hermes                  6080  5 
orinoco_tmd,orinoco_plx,orinoco_pci,orinoco_cs,orinoco
e100                   30884  0
slip                    8384  0
ppp_async               7840  0
ppp_generic            20884  1 ppp_async
slhc                    5504  2 slip,ppp_generic
crc_ccitt               1792  1 ppp_async
snd_intel8x0m          12908  1
uhci_hcd               26704  0
ehci_hcd               24680  0
usbcore               101604  5 usbhid,usb_storage,uhci_hcd,ehci_hcd
snd_intel8x0           25404  1
snd_ac97_codec         79936  2 snd_intel8x0m,snd_intel8x0
snd_ac97_bus            1856  1 snd_ac97_codec
snd_pcm                67560  4 
snd_pcm_oss,snd_intel8x0m,snd_intel8x0,snd_ac97_codec
snd_timer              17956  1 snd_pcm
snd                    39940  11 
snd_pcm_oss,snd_mixer_oss,snd_intel8x0m,snd_intel8x0,snd_ac97_codec,snd_pcm,snd_timer
soundcore               6656  1 snd
snd_page_alloc          7944  3 snd_intel8x0m,snd_intel8x0,snd_pcm
yenta_socket           21996  7
rsrc_nonstatic         10336  1 yenta_socket
pcmcia_core            32368  3 pcmcia,yenta_socket,rsrc_nonstatic
===== end HW-info ========
=======================
