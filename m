Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932190AbWGRVvc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932190AbWGRVvc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jul 2006 17:51:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932148AbWGRVvc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jul 2006 17:51:32 -0400
Received: from nf-out-0910.google.com ([64.233.182.191]:61766 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932190AbWGRVvb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jul 2006 17:51:31 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:from:to:subject:date:user-agent:cc:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=Euwv2zGcfzPNfKYdC4+sSH5rOxccZ0ygWynqEeTtiLFrbzR1pO8d0TUPK/oW6H04AzPCk+Mm6m0KnrVgGTNOuxR++NEjYMeLvsOs0LbDDgF5eFb9XNkwYzdRBcj2gnOG0EpGoA0XrjEz3xiXIZbjhNeOm8+uIRBnrfGFXB8hpUs=
From: Jesper Juhl <jesper.juhl@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: 2.6.18-rc2 allyesconfig doesn't build - undefined references to hdlc_set_carrier
Date: Tue, 18 Jul 2006 23:52:39 +0200
User-Agent: KMail/1.9.3
Cc: Paul Fulghum <paulkf@microgate.com>, Jesper Juhl <jesper.juhl@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200607182352.40222.jesper.juhl@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

For your information;

Just tried an allyesconfig build of 2.6.18-rc2 and it fails with this error : 

...
  LD      init/built-in.o
  LD      .tmp_vmlinux1
drivers/built-in.o(.text+0x122457): In function `mgsl_isr_io_pin':
drivers/char/synclink.c:1348: undefined reference to `hdlc_set_carrier'
drivers/built-in.o(.text+0x1296ee): In function `hdlcdev_open':
drivers/char/synclink.c:7847: undefined reference to `hdlc_set_carrier'
drivers/built-in.o(.text+0x12b4aa): In function `hdlcdev_open':
drivers/char/synclinkmp.c:1755: undefined reference to `hdlc_set_carrier'
drivers/built-in.o(.text+0x12c610): In function `isr_io_pin':
drivers/char/synclinkmp.c:2526: undefined reference to `hdlc_set_carrier'
drivers/built-in.o(.text+0x131eca): In function `hdlcdev_open':
drivers/char/synclink_gt.c:1500: undefined reference to `hdlc_set_carrier'
drivers/built-in.o(.text+0x1329b0):drivers/char/synclink_gt.c:2001: more undefined references to `hdlc_set_carrier' follow
make: *** [.tmp_vmlinux1] Error 1


Some info about my environment : 

juhl@dragon:~/download/kernel/linux-2.6.18-rc2$ scripts/ver_linux
If some fields are empty or look unusual you may have an old version.
Compare to the current minimal requirements in Documentation/Changes.

Linux dragon 2.6.18-rc1 #2 SMP PREEMPT Thu Jul 6 23:23:45 CEST 2006 i686 athlon-4 i386 GNU/Linux

Gnu C                  3.4.6
Gnu make               3.81
binutils               2.15.92.0.2
util-linux             2.12r
mount                  2.12r
module-init-tools      3.2.2
e2fsprogs              1.39
reiserfsprogs          3.6.19
quota-tools            3.13.
PPP                    2.4.4b1
Linux C Library        2.3.6
Dynamic linker (ldd)   2.3.6
Linux C++ Library      6.0.3
Procps                 3.2.7
Net-tools              1.60
Kbd                    1.12
Sh-utils               5.97
udev                   071
Modules Loaded         snd_seq_oss snd_seq_midi_event snd_seq snd_pcm_oss snd_mixer_oss uhci_hcd usbcore snd_emu10k1 snd_rawmidi snd_ac97_codec snd_ac97_bus snd_pcm snd_seq_device snd_timer snd_page_alloc snd_util_mem snd_hwdep snd agpgart



 Kind regards,

   Jesper Juhl <jesper.juhl@gmail.com>


