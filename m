Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263393AbSJFOL7>; Sun, 6 Oct 2002 10:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261619AbSJFOL7>; Sun, 6 Oct 2002 10:11:59 -0400
Received: from daimi.au.dk ([130.225.16.1]:41696 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S263393AbSJFOL6>;
	Sun, 6 Oct 2002 10:11:58 -0400
Message-ID: <3DA045F1.8E0FDCEA@daimi.au.dk>
Date: Sun, 06 Oct 2002 16:17:21 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.18-10smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Arjan van de Ven <arjanv@redhat.com>
CC: Andy Pfiffer <andyp@osdl.org>, Michal Jaegermann <michal@harddata.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: export of sys_call_table
References: <20021003153943.E22418@openss7.org>
		<1033682560.28850.32.camel@irongate.swansea.linux.org.uk> 
		<20021003171013.B22986@mail.harddata.com>  <1033691520.28254.6.camel@andyp> <1033723207.1733.4.camel@localhost.localdomain>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven wrote:
> 
> I wonder why kmonte can't just use a reboot notifier.... existing
> infrastructure already ;(

Because it doesn't hook sys_reboot to get notified about reboots.
It hooks sys_reboot to add new calls, it could have been a new
system call, but what monte does is slightly related to a reboot.

I have myself added a feature to monte where it was essential to
hook the sys_reboot call and do something else when a reboot was
requested. Maybe I could have used a reboot notifier.

What really bothers me about monte is:
1) Doesn't work on SMP
2) Doesn't seem to be maintened (does it even work on 2.5)?
3) Is not completely stable
4) Only available as a module, cannot be compiled in kernel.
5) I couldn't get my additional feature working with the latest
   version of monte.

Perhaps there is some better alternative which I don't know?

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:aaarep@daimi.au.dk
or mailto:mcxumhvenwblvtl@skrammel.yaboo.dk
