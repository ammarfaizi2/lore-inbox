Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265100AbTFCQrp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 3 Jun 2003 12:47:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265103AbTFCQro
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 3 Jun 2003 12:47:44 -0400
Received: from e35.co.us.ibm.com ([32.97.110.133]:3313 "EHLO e35.co.us.ibm.com")
	by vger.kernel.org with ESMTP id S265100AbTFCQrj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 3 Jun 2003 12:47:39 -0400
Date: Tue, 03 Jun 2003 09:49:58 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: linux-kernel <linux-kernel@vger.kernel.org>
Subject: [Bug 770] New: usbaudio does not compile
Message-ID: <113000000.1054658998@flay>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

http://bugme.osdl.org/show_bug.cgi?id=770

           Summary: usbaudio does not compile
    Kernel Version: 2.5.70-bk8
            Status: NEW
          Severity: normal
             Owner: bugme-janitors@lists.osdl.org
         Submitter: a.akhavan@ndr.de


Distribution: SuSE 8.2
Hardware Environment: Acer Travelmate 800 LCi
Software Environment: gcc 3.3
Problem Description: usbaudio does not compile on 2.5.70-bk8
(I've skipped a few snapshots, so it might have been introduced at > 2.5.70-bk5)
It used to compile before. 

Error-log:
In file included from sound/usb/usbaudio.c:35:
include/linux/usb.h: In function `usb_make_path':
include/linux/usb.h:327: warning: comparison between signed and unsigned
sound/usb/usbaudio.c: In function `parse_audio_format_i_type':
sound/usb/usbaudio.c:1947: error: `iface_no' undeclared (first use in this function)
sound/usb/usbaudio.c:1947: error: (Each undeclared identifier is reported only once
sound/usb/usbaudio.c:1947: error: for each function it appears in.)
sound/usb/usbaudio.c:1947: error: `altno' undeclared (first use in this function)
sound/usb/usbaudio.c: In function `parse_audio_endpoints':
sound/usb/usbaudio.c:2172: warning: comparison between signed and unsigned
sound/usb/usbaudio.c: In function `snd_usb_audio_create':
sound/usb/usbaudio.c:2582: warning: comparison between signed and unsigned
make[2]: *** [sound/usb/usbaudio.o] Error 1
make[1]: *** [sound/usb] Error 2
make: *** [sound] Error 2


Steps to reproduce:
Pentium M + Centrino / ACPI / usb


CONFIG_SOUND=m

CONFIG_SND=m
CONFIG_SND_SEQUENCER=m
CONFIG_SND_SEQ_DUMMY=m
CONFIG_SND_OSSEMUL=y
CONFIG_SND_MIXER_OSS=m
CONFIG_SND_PCM_OSS=m
CONFIG_SND_SEQUENCER_OSS=y
CONFIG_SND_RTCTIMER=m
CONFIG_SND_VERBOSE_PRINTK=y
CONFIG_SND_DEBUG=y
CONFIG_SND_DEBUG_DETECT=y

CONFIG_SND_DUMMY=m
CONFIG_SND_VIRMIDI=m
CONFIG_SND_MTPAV=m
CONFIG_SND_SERIAL_U16550=m
CONFIG_SND_MPU401=m

CONFIG_SND_ALI5451=m
CONFIG_SND_EMU10K1=m
CONFIG_SND_YMFPCI=m
CONFIG_SND_ENS1370=m
CONFIG_SND_ENS1371=m
CONFIG_SND_INTEL8X0=m
CONFIG_SND_SONICVIBES=m
CONFIG_SND_VIA82XX=m

CONFIG_SND_USB_AUDIO=m


CONFIG_SOUND_PRIME=m
CONFIG_SOUND_BT878=m
CONFIG_SOUND_ICH=m
CONFIG_SOUND_VIA82CXXX=m
CONFIG_SOUND_OSS=m
CONFIG_SOUND_TRACEINIT=y
CONFIG_SOUND_DMAP=y

CONFIG_USB=m

CONFIG_USB_DEVICEFS=y
CONFIG_USB_BANDWIDTH=y

CONFIG_USB_EHCI_HCD=m
CONFIG_USB_OHCI_HCD=m
CONFIG_USB_UHCI_HCD=m

CONFIG_USB_AUDIO=m
CONFIG_USB_MIDI=m
CONFIG_USB_ACM=m
CONFIG_USB_PRINTER=m
CONFIG_USB_STORAGE=m
CONFIG_USB_STORAGE_DATAFAB=y
CONFIG_USB_STORAGE_FREECOM=y
CONFIG_USB_STORAGE_ISD200=y
CONFIG_USB_STORAGE_DPCM=y
CONFIG_USB_STORAGE_SDDR09=y
CONFIG_USB_STORAGE_SDDR55=y
CONFIG_USB_STORAGE_JUMPSHOT=y

CONFIG_USB_HID=m
CONFIG_USB_HIDINPUT=y
CONFIG_USB_HIDDEV=y

CONFIG_USB_AIPTEK=m
CONFIG_USB_WACOM=m
CONFIG_USB_KBTAB=m


