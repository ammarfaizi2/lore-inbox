Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S279890AbRJ3Hfm>; Tue, 30 Oct 2001 02:35:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S279889AbRJ3Hfc>; Tue, 30 Oct 2001 02:35:32 -0500
Received: from [62.245.135.174] ([62.245.135.174]:45956 "EHLO mail.teraport.de")
	by vger.kernel.org with ESMTP id <S279894AbRJ3HfR>;
	Tue, 30 Oct 2001 02:35:17 -0500
Message-ID: <3BDE5853.540BCCA5@TeraPort.de>
Date: Tue, 30 Oct 2001 08:35:47 +0100
From: Martin Knoblauch <Martin.Knoblauch@TeraPort.de>
Organization: TeraPort GmbH
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.4.13-ac4 i686)
X-Accept-Language: en, de
MIME-Version: 1.0
To: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Very high "cached" value
X-MIMETrack: Itemize by SMTP Server on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 10/30/2001 08:35:48 AM,
	Serialize by Router on lotus/Teraport/de(Release 5.0.7 |March 21, 2001) at
 10/30/2001 08:35:54 AM,
	Serialize complete at 10/30/2001 08:35:54 AM
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

 running 2.4.13-ac4+preempt, I found a rather strange xosview display
this morning, complaining about a negative field. Inspection of
/proc/meminfo gives a pretty unlikely value for "cached":

/home/martink> cat /proc/meminfo
        total:    used:    free:  shared: buffers:  cached:
Mem:  327233536 323653632  3579904  6352896 131874816
18446744073682300928
Swap: 674455552   475136 673980416
MemTotal:       319564 kB
MemFree:          3496 kB
MemShared:        6204 kB
Buffers:        128784 kB
Cached:       4294940220 kB
SwapCached:        464 kB
Active:         103016 kB
Inact_dirty:    126400 kB
Inact_clean:      1540 kB
Inact_target:    65508 kB
HighTotal:           0 kB
HighFree:            0 kB
LowTotal:       319564 kB
LowFree:          3496 kB
SwapTotal:      658648 kB
SwapFree:       658184 kB

 This is on a Toshiba 7200 Notebook with 320 MB and about twice as much
swap.

Martin
-- 
------------------------------------------------------------------
Martin Knoblauch         |    email:  Martin.Knoblauch@TeraPort.de
TeraPort GmbH            |    Phone:  +49-89-510857-309
C+ITS                    |    Fax:    +49-89-510857-111
http://www.teraport.de   |    Mobile: +49-170-4904759
