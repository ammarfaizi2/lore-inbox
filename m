Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S273255AbRIUKig>; Fri, 21 Sep 2001 06:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S273261AbRIUKi1>; Fri, 21 Sep 2001 06:38:27 -0400
Received: from indyio.rz.uni-sb.de ([134.96.7.3]:62973 "EHLO
	indyio.rz.uni-sb.de") by vger.kernel.org with ESMTP
	id <S273255AbRIUKiN>; Fri, 21 Sep 2001 06:38:13 -0400
Message-ID: <3BAB189F.D4B76FEE@stud.uni-saarland.de>
Date: Fri, 21 Sep 2001 10:38:23 +0000
From: Studierende der Universitaet des Saarlandes 
	<masp0008@stud.uni-sb.de>
Reply-To: manfred@colorfullife.com
Organization: Studierende Universitaet des Saarlandes
X-Mailer: Mozilla 4.08 [en] (X11; I; Linux 2.0.36 i686)
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: [PATCH] Midi close race
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

+       if (open_devs < 2)
+               del_timer(&poll_timer);

Probably you need del_timer_sync():
Otherwise the timer could be running on another cpu.

+       open_devs--;

--
	Manfred
(OT: Are there any mail archives that store the cc list? I'm not
subscribed to l-k, and if I answer a mail the cc list is always lost)
