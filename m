Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129153AbQKYIJK>; Sat, 25 Nov 2000 03:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129228AbQKYIJA>; Sat, 25 Nov 2000 03:09:00 -0500
Received: from vger.timpanogas.org ([207.109.151.240]:25102 "EHLO
        vger.timpanogas.org") by vger.kernel.org with ESMTP
        id <S129153AbQKYIIv>; Sat, 25 Nov 2000 03:08:51 -0500
Date: Sat, 25 Nov 2000 02:38:50 -0500 (EST)
From: "Mike A. Harris" <mharris@opensourceadvocate.org>
To: Linux Kernel mailing list <linux-kernel@vger.kernel.org>
Subject: [NSOTON] Voice modem/speakerphone drivers/software?
Message-ID: <Pine.LNX.4.30.0011250232530.5879-100000@asdf.capslock.lan>
X-Unexpected-Header: The Spanish Inquisition
Copyright: Copyright 2000 by Mike A. Harris - All rights reserved
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

My new 56k internal modem has speakerphone jacks, etc, and voice
recording capabilities allegedly.  AOPEN 56k.  Although it works
fine (but not at 56k) for dialin, I'm wondering if I can actually
use the speakerphone and voice recording features in Linux.  The
.INF file that came with it contains stuff like:

HKR, SpeakerPhoneEnable,      1,, "at#vls=6<cr>"
HKR, SpeakerPhoneEnable,      2,, "at#cls=8<cr>"
HKR, SpeakerPhoneEnable,      3,, "at#spk=1,10,2<cr>"
HKR, SpeakerPhoneDisable,    1,, "at#spk=0,16,,<cr>"
HKR, SpeakerPhoneDisable,    2,, "at#vls=0<cr>"
HKR, SpeakerPhoneMute,        1,, "at#vls=6<cr>"
HKR, SpeakerPhoneMute,        2,, "at#spk=0,,,<cr>"
HKR, SpeakerPhoneUnMute,      1,, "at#vls=6<cr>"
HKR, SpeakerPhoneUnMute,      2,, "at#spk=1,,,<cr>"
HKR, SpeakerPhoneSetVolumeGain,  1,, "at#vls=6<cr>"
HKR, SpeakerPhoneSetVolumeGain,  2,, "at#spk=,<Vol>,<Gain><cr>"

HKR, StartPlay,               1,, "at#vtx<cr>"
HKR, StopPlay,                1,, "None"
HKR, StopPlay,                2,, "NoResponse"
HKR, StartRecord,             1,, "at#vrx<cr>"
HKR, StopRecord,              1,, "None"
HKR, StopRecord,              2,, "NoResponse"
HKR,, TerminateRecord,,      "<h10><cr>"
HKR,, TerminatePlay,,        "<h10><h03>"
HKR,, AbortPlay,,            "<h10><h18>"
HKR, LineSetPlayFormat,       1,, "at#vls=0<cr>"
HKR, LineSetRecordFormat,     1,, "None"
HKR, LineSetRecordFormat,     2,, "NoResponse"
HKR, HandsetSetRecordFormat,   1,,"at#vsr=7200<cr>"
HKR, HandsetSetRecordFormat,   2,,"at#vbs=4<cr>"
HKR, HandsetSetPlayFormat,     1,,"at#vsr=7200<cr>"
HKR, HandsetSetPlayFormat,     2,,"at#vbs=4<cr>"
HKR, OpenHandset,               1,, "at#cls=8<cr>"
HKR, OpenHandset,               2,, "at#vls=1<cr>"
HKR, CloseHandset,                   1,, "at#vls=0<cr>"
HKR, CloseHandset,                   2,, "at#cls=0<cr>"



I could probably script up some nasty perl to get it to work, but
does anyone know of existing software for Linux to exploit these
capabilities?  Does it need to be connected to a sound card for
actual recording, or does the DSP in the modem work?

----------------------------------------------------------------------
      Mike A. Harris  -  Linux advocate  -  Open source advocate
          This message is copyright 2000, all rights reserved.
  Views expressed are my own, not necessarily shared by my employer.
----------------------------------------------------------------------

Be up to date on nerd news and stuff that matters:  http://slashdot.org

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
