Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269204AbTCBNSl>; Sun, 2 Mar 2003 08:18:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269205AbTCBNSl>; Sun, 2 Mar 2003 08:18:41 -0500
Received: from [66.70.28.20] ([66.70.28.20]:46353 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S269204AbTCBNSk>; Sun, 2 Mar 2003 08:18:40 -0500
Date: Sun, 2 Mar 2003 14:04:30 +0100
From: DervishD <raul@pleyades.net>
To: jw schultz <jw@pegasys.ws>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
Message-ID: <20030302130430.GI45@DervishD>
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk> <buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DB2CA.32539D41@daimi.au.dk> <buon0kirym1.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DCB89.9086582F@daimi.au.dk> <buo65r6ru6h.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030227092121.GG15254@pegasys.ws>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030227092121.GG15254@pegasys.ws>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi J.W. :)

 jw schultz dixit:
> The idea of storing the list of mounted filesystems on a
> mounted filesystem is a bad idea from the get-go.

    I'm with you on this, with an exception. It's a bad idea provided
you have some way to know what filesystems are mounted, together with
the options, etc... /bin/mount knows all those options, obviously,
and the kernel not always (AFAIK). Don't know why.

> Let the data reside in the kernel and have a procfs or sysfs
> entity for it.  A symlink from /etc/mtab can keep the old
> tools happy.

    That's what I propose, too. Even if this lead to technical
difficulties, /etc/mtab is, IMHO, obsolete and a better solution
tried instead. Obviously I don't have such a solution, but I think
that a procfs based solution and a symlink for mtab will work quite
good. I know: some systems don't have procfs, but I think that those
systems will have a read-only /etc anyway... Other solution is to
link /etc/mtab to a point at /var. If 'mount' treats specially the
mtab if it is a symlink... well, IMHO this is not correct. Yes, this
can lead to an attack, but: 'mount' is a setuid program, and only
root can symlink /etc/mtab, true?

    Raúl
