Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269377AbTCDLFc>; Tue, 4 Mar 2003 06:05:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269379AbTCDLFb>; Tue, 4 Mar 2003 06:05:31 -0500
Received: from [66.70.28.20] ([66.70.28.20]:26124 "EHLO
	maggie.piensasolutions.com") by vger.kernel.org with ESMTP
	id <S269377AbTCDLF2>; Tue, 4 Mar 2003 06:05:28 -0500
Date: Tue, 4 Mar 2003 12:08:16 +0100
From: DervishD <raul@pleyades.net>
To: Kasper Dupont <kasperd@daimi.au.dk>
Cc: jw schultz <jw@pegasys.ws>, Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: About /etc/mtab and /proc/mounts
Message-ID: <20030304110816.GB42@DervishD>
References: <20030219112111.GD130@DervishD> <3E5C8682.F5929A04@daimi.au.dk> <buoy942s6lt.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DB2CA.32539D41@daimi.au.dk> <buon0kirym1.fsf@mcspd15.ucom.lsi.nec.co.jp> <3E5DCB89.9086582F@daimi.au.dk> <buo65r6ru6h.fsf@mcspd15.ucom.lsi.nec.co.jp> <20030227092121.GG15254@pegasys.ws> <20030302130430.GI45@DervishD> <3E621235.2C0CD785@daimi.au.dk>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3E621235.2C0CD785@daimi.au.dk>
User-Agent: Mutt/1.4i
Organization: Pleyades
User-Agent: Mutt/1.4i <http://www.mutt.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Kasper :)

 Kasper Dupont dixit:
> > If 'mount' treats specially the
> > mtab if it is a symlink... well, IMHO this is not correct. Yes, this
> The reason for mount not to update /etc/mtab if it is a symlink is
> not security concerns, but rather that it could be a symlink to
> /proc/mounts. Another problem is the way the update is actually
> done. A lockfile named /etc/mtab~ is created, and a new mtab is
> written to /etc/mtab.tmp which is later renamed on top of mtab.

    The lockfile was the first reason why we did the symlink. The
/etc was readonly and mount failed.
 
> But if we
> are going to change mount in non-trivial ways, we should aim for a
> better longterm solution.

    You're completely right ;) But, just as I told before, I have no
good solution. I don't remember clearly, but I think that we use
finally another solution for the embedded system, by using a 'fake'
etc, writeable, and after booting, mounting a readonly etc over the
old one, or something like that. Pretty good (I suppose) for the
embedded system, but not a solution for everyday use, IMHO.

    By now I will do with /etc/mtab, but I think I will replace it
with a symlink to /proc, no matter if I lose options, etc... And
really I would like to write my own mount, just for my system, as
I've already done with other binaries. That's what I like free
software: I can write my own software without doing all the work from
zero, using the brains of people far more clever than me for helping
in the effort ;))

    BTW, thanks for your interest in the issue :))

    Raúl
