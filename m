Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280839AbRKTDan>; Mon, 19 Nov 2001 22:30:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280856AbRKTDad>; Mon, 19 Nov 2001 22:30:33 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63335 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S280839AbRKTDaX>; Mon, 19 Nov 2001 22:30:23 -0500
To: Larry McVoy <lm@bitmover.com>
Cc: RaXlNXXez de Arenas Coronado <dervishd@jazzfree.com>,
        linux-kernel@vger.kernel.org
Subject: Re: LOBOS (kexec)
In-Reply-To: <E165yPH-000040-00@DervishD>
	<20011119181731.D23210@work.bitmover.com>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 19 Nov 2001 20:11:28 -0700
In-Reply-To: <20011119181731.D23210@work.bitmover.com>
Message-ID: <m1elmu6srj.fsf_-_@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Larry McVoy <lm@bitmover.com> writes:

> I've been wanting Linux which can boot Linux for a long time.
> See http://www.bitmover.com/ml for some slides on why, for those of you
> who are guess, yes it is the same OS cluster idea for SMP scaling I've
> been pushing on for 7 years.  It's finally getting some attention as
> well, the IBM guys are looking at it, a FreeBSD guy is looking at it,
> and the UML guy thinks he can do a UML implementation in such a way 
> that putting it on real hardware would be a "simple" port.

I am maintaining a version of this functionality against 2.4.x
called kexec.  And I plan to work on integration into linux with 2.5.x.
After the details are worked out I will look at a backport to 2.4.x

The hard part is not linux booting linux but the passing of the
firmware/BIOS tables from one kernel to the next.  Especially those
that can only be obtained by a 16bit query.  It is my assumption that
after the OS runs you cannot return to the firmware, it's state is
hopelessly mangled.  That may not be totally true but it is fairly
close to the truth. 

I am doing this a part of the linuxBIOS effort and as such it is just
maturing enough that I can really start concentrating on this aspect
of the problem.  I do not want an interface that is mushy.  I want an
interface that is extensible.  But is pretty much frozen for all time
like the ELF file format.

My patches show up from time to time at:
ftp://download.linuxnetworx.com/pub/src/kernel-patches/

Hopefully soon I will get my port to 2.4.14 put up there soon.  
I have been maintaining and this since 2.4.0-pre9 or so.  And I have
been using this actively.  And I have an alpha port.  I would port to
other architectures but I don't have the machines available.

Eric

