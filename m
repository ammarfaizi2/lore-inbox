Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131130AbRCGRks>; Wed, 7 Mar 2001 12:40:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131127AbRCGRk2>; Wed, 7 Mar 2001 12:40:28 -0500
Received: from mail.inf.tu-dresden.de ([141.76.2.1]:2374 "EHLO
	mail.inf.tu-dresden.de") by vger.kernel.org with ESMTP
	id <S131060AbRCGRkR>; Wed, 7 Mar 2001 12:40:17 -0500
Date: Wed, 7 Mar 2001 18:40:00 +0100
To: linux-kernel@vger.kernel.org
Subject: static scheduling - SCHED_IDLE?
Message-ID: <20010307184000.A26594@ugly.wh8.tu-dresden.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.15i
From: Oswald Buddenhagen <ob6@inf.tu-dresden.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

hi there,

i found, that linux is missing a static low-priority scheduling class
(or did i miss something? in this case feel free to stomp me into the
ground :).  it would be ideal for typical number-crunchers running in
the background like the different distributed.net-like clients.
within this class, static priorities like those for SCHED_RR would be
required, so one could have for example such a priorization:

[-] idle-task/apmd (here never running)
[idle/1] distributed.net client or other toy (when the machine is really idle)
[idle/50] mp3 compressor (when no "real" work has to be done)
[other/nice 10] not time-critical job
[other/nice 0] the usual jobs, like a make process, etc.
[other/nice -10] x-server, etc.
[rr/50] some real-time app, like a computer-controlled toaster :)

what do you recon?

best regards

-- 
Hi! I'm a .signature virus! Copy me into your ~/.signature, please!
--
Nothing is fool-proof to a sufficiently talented fool.
