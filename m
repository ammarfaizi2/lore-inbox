Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266765AbTBGWeT>; Fri, 7 Feb 2003 17:34:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266772AbTBGWeT>; Fri, 7 Feb 2003 17:34:19 -0500
Received: from th24.opsion.fr ([62.39.122.34]:45062 "HELO th24.opsion.fr")
	by vger.kernel.org with SMTP id <S266765AbTBGWeR>;
	Fri, 7 Feb 2003 17:34:17 -0500
Message-Id: <5.2.0.9.2.20030207233027.00c438e8@pop3.ibelgique.com>
X-Mailer: QUALCOMM Windows Eudora Version 5.2.0.9
Date: Fri, 07 Feb 2003 23:44:57 +0100
To: linux-kernel@vger.kernel.org
From: Laurent Grawet <laurent.grawet@ibelgique.com>
Subject: Re: kernel 2.4.x + via-based kt266 mobo = IDE cdr ...
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

I have exactly the same problem/symptoms like several other users !
Here is a interesting report that has been made on Viaarena Linux forum by 
Dam. This bring us useful information and better understanding of the 
situation :

http://forums.viaarena.com/messageview.cfm?catid=28&threadid=28308&STARTPAGE=1

--------- SNIP

  Thursday, February 06, 2003 9:56 PM


Hi there.

One more guy with the same problem. But I've got a kind of solution, but it 
is not a good one.

Using cdda2wav, you can use the -n option to tell cdda2wav the number of 
sector to read at a time.
I'm able to rip a cd using -n 1 . I can go up to -n 15 then it start hdc: 
lost interrupt ... Problem is that
performance is not great at -n 1.

I once contacted the cdrdao author, Andreas, and talk with him about this 
prog. I ended editing cdrdao sources
to try to reduce the number of sector read at a time to 1 (same as for 
cdda2wav). Problem disappeared but
performance were unacceptable.

Also there is the option to not write the rip to a file (for debugging 
purpose), using -N. Using that
option, I no more experience problem, but of course, I don't rip anything.

So it seemed to me that the problem is related to writing to a disk while 
ripping. So I tried cdda2wav with -N and
at the same time launched a cp -R /usr/src/linux /tmp. Everything happened 
correctly, slowly but without lost interrupts.

I think this is more of a kernel bug then a bios bug (why would it work 
under windows ?). Searching lkml gives many
results with people with this problem, but no solutions.

I think we should start bother people on the lkml.

---------- SNIP

 > I think we should start bother people on the lkml.
Well, this has just been done Dam   :-)

Exactly the same behaviour here...

Could Linux Guru's help us ?
We have this problem for too long time...

Thanks,

Laurent

** Please, CC me your answer to LKML **


-- 
| Laurent Grawet
| ON1MGL
|
| [e-mail]
|    Home...... mailto:laurent.grawet@ibelgique.com
|               mailto:on1mgl@ibelgique.com
|    Office.... mailto:laurent.grawet@fundp.ac.be
|
| [ax25]
|               on1mgl@on0cha.#clr.ht.bel.eu

_____________________________________________________________________
Envie de discuter en "live" avec vos amis ? Télécharger MSN Messenger
http://www.ifrance.com/_reloc/m la 1ère messagerie instantanée de France

