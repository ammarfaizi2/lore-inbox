Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S292367AbSBPNnw>; Sat, 16 Feb 2002 08:43:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S292368AbSBPNnc>; Sat, 16 Feb 2002 08:43:32 -0500
Received: from smtp.kolej.mff.cuni.cz ([195.113.25.225]:27153 "EHLO
	smtp.kolej.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S292367AbSBPNnZ>; Sat, 16 Feb 2002 08:43:25 -0500
X-Envelope-From: ktoman@email.cz
Subject: DRI & signal delivery in Linux 2.5
From: Kamil Toman <ktoman@email.cz>
To: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Evolution/1.0.21mdk 
Date: 16 Feb 2002 14:43:23 +0100
Message-Id: <1013867003.8129.56.camel@whale.kolej.mff.cuni.cz>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

	I was recently playing with a bug in radeon drm code (it looks much as
a deadlock to me). As a side effect I reread most of docs at the dri
site. There is an interesting note in DRM design guide:

"If the direct-rendering client holds the hardware lock and receives a
SIGKILL signal, deadlock may result. If the SIGKILL is detected and the
hardware lock is immediately taken from the client, the typical PC-class
graphics hardware may be left in an unknown state and may lock up (this
kind of hardware usually does not deal well with intermingling of
command streams).

Similarly, if the direct-rendering client holds the hardware lock and
receives a SIGSTOP, the X server and all other direct-rendering clients
will block until the process releases the lock.

Ideally, the client should be permitted to complete the rendering
operation that is currently in progress and have the SIGKILL or SIGSTOP
signals delivered as soon as the hardware lock is released (or, after
some reasonable timeout, so that buggy clients can be halted). This
delay of signal delivery appears to require kernel-level changes that
cannot be performed by a loadable module using the standard module
interface."

Anyone knows if there is something planned to avoid this situation in
Linux 2.5/6? I'm just curious...

[ Please cc: me, I'm not no the list ]

Have a nice day!
-- 
Kamil Toman
