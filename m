Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267463AbTACIVU>; Fri, 3 Jan 2003 03:21:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267466AbTACIVT>; Fri, 3 Jan 2003 03:21:19 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:60219 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S267463AbTACIVS>; Fri, 3 Jan 2003 03:21:18 -0500
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: Arjan van de Ven <arjanv@redhat.com>, Andy Pfiffer <andyp@osdl.org>,
       Michal Jaegermann <michal@harddata.com>,
       "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: export of sys_call_table
References: <20021003153943.E22418@openss7.org>
	<1033682560.28850.32.camel@irongate.swansea.linux.org.uk>
	<20021003171013.B22986@mail.harddata.com>
	<1033691520.28254.6.camel@andyp>
	<1033723207.1733.4.camel@localhost.localdomain>
	<3DA045F1.8E0FDCEA@daimi.au.dk>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 03 Jan 2003 01:28:44 -0700
In-Reply-To: <3DA045F1.8E0FDCEA@daimi.au.dk>
Message-ID: <m165t6ljr7.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont <kasperd@daimi.au.dk> writes:

> Arjan van de Ven wrote:
> > 
> > I wonder why kmonte can't just use a reboot notifier.... existing
> > infrastructure already ;(
> 
> Because it doesn't hook sys_reboot to get notified about reboots.
> It hooks sys_reboot to add new calls, it could have been a new
> system call, but what monte does is slightly related to a reboot.
> 
> I have myself added a feature to monte where it was essential to
> hook the sys_reboot call and do something else when a reboot was
> requested. Maybe I could have used a reboot notifier.
> 
> What really bothers me about monte is:
> 1) Doesn't work on SMP
> 2) Doesn't seem to be maintened (does it even work on 2.5)?
> 3) Is not completely stable
> 4) Only available as a module, cannot be compiled in kernel.
> 5) I couldn't get my additional feature working with the latest
>    version of monte.
> 
> Perhaps there is some better alternative which I don't know?

kexec...
It was an inch from being accepted into 2.5 last time I looked.

Eric
