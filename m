Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277554AbRJRCKw>; Wed, 17 Oct 2001 22:10:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277565AbRJRCKm>; Wed, 17 Oct 2001 22:10:42 -0400
Received: from gecius-0.dsl.speakeasy.net ([216.254.67.146]:39413 "EHLO
	maniac.gecius.de") by vger.kernel.org with ESMTP id <S277554AbRJRCKa>;
	Wed, 17 Oct 2001 22:10:30 -0400
To: linux-kernel@vger.kernel.org
Subject: /proc/interrupts on 2.4.13-1
From: Jens Gecius <jens@gecius.de>
Date: 17 Oct 2001 22:11:03 -0400
Message-ID: <87n12pbsug.fsf@maniac.gecius.de>
User-Agent: Gnus/5.090003 (Oort Gnus v0.03) XEmacs/21.4 (Artificial Intelligence)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi folks!

/proc/interrupts shows

           CPU0       CPU1       
  0:    6700068    6617178    IO-APIC-edge  timer
  1:      15716      15044    IO-APIC-edge  keyboard
  2:          0          0          XT-PIC  cascade
  3:          0          1    IO-APIC-edge  serial
  8:          1          1    IO-APIC-edge  rtc
  9:     788995     790370   IO-APIC-level  eth0
 10:      93412      93466   IO-APIC-level  aic7xxx, Ensoniq AudioPCI
 11:    3476219    3482580   IO-APIC-level  nvidia
 12:      31650      31277   IO-APIC-level  usb-uhci, usb-uhci
 14:     505063     501971    IO-APIC-edge  ide0
 15:         10          0    IO-APIC-edge  ide1
NMI:          0          0 
LOC:   13315157   13315147 
ERR:          0
MIS:       3690

Especially the last makes me curious: does MIS mean "missed"? And:
might this be related to esd running here having some trouble to keep
playing without short little "breaks"? The count on MIS is actually
growing steadily, the uptime is currently only 37 hours.

The box is used most time with two niced seti-processes. Other than
that, cpu stat is hardly at 10%. 

-- 
Tschoe,                http://gecius.de/gpg-key.txt - Fingerprint:
 Jens                  1AAB 67A2 1068 77CA 6B0A  41A4 18D4 A89B 28D0 F097
