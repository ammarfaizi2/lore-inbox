Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261402AbTCTHMB>; Thu, 20 Mar 2003 02:12:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261404AbTCTHMB>; Thu, 20 Mar 2003 02:12:01 -0500
Received: from sarge.hbedv.com ([217.11.63.11]:28824 "EHLO sarge.hbedv.com")
	by vger.kernel.org with ESMTP id <S261402AbTCTHMA>;
	Thu, 20 Mar 2003 02:12:00 -0500
Date: Thu, 20 Mar 2003 08:22:59 +0100
From: Wolfram Schlich <wolfram@schlich.org>
To: Linux-Kernel mailinglist <linux-kernel@vger.kernel.org>
Subject: Re: Hardlocks with 2.4.21-pre5, pdc202xx_new (PDC20269) and shared IRQs
Message-ID: <20030320072259.ALLYOURBASEAREBELONGTOUS.E6336@bla.fasel.org>
Mail-Followup-To: Linux-Kernel mailinglist <linux-kernel@vger.kernel.org>
References: <20030319221608.ALLYOURBASEAREBELONGTOUS.A29767@bla.fasel.org> <1048124539.647.18.camel@irongate.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1048124539.647.18.camel@irongate.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Organization: Axis of Weasel(s)
X-Complaints-To: bla@fasel.org
X-IRC: wschlich at irc.freenode.net
X-Messenger: ICQ: 35713642, MSN: bla@fasel.org, YIM: wolfram_schlich, AIM: wolframschlich
X-Registered-Linux-User: 187858 (http://counter.li.org)
X-Warning: E-Mail may contain unsmilyfied humor and/or satire.
X-What-Happen: Somebody set up us the bomb.
X-Accept-Language: de, en, fr
X-GPG-Key: 0xCD4DF205 (http://wolfram.schlich.org/wschlich.asc, x-hkp://wwwkeys.de.pgp.net)
X-GPG-Fingerprint: 39EC 98CA 4130 E59A 1041  AD06 D3A1 C51D CD4D F205
X-Editor: VIM - Vi IMproved 6.1 (2002 Mar 24, compiled Mar 24 2002 15:02:51)
X-Face: |P()Q^fx-{=,K-3g?5@Id4o|o{Xf_5v:z3WIhR3fOW-$,*=[#[Qq<,@P!OsXbR|i6n=]B<3mzGC++F@K#wvoLEnIZuTR6wPCMQfxq!';9w[TiP3Bhz"r&$7eGFq7us@Z5Qd$3W[3W3:U7biTNZgf"<]LqwS
X-Operating-System: Linux prometheus 2.4.21-pre5-grsec-1.9.9c #3 SMP Thu Mar 20 00:10:58 CET 2003 i686 unknown
X-Uptime: 8:22am up 7:36, 2 users, load average: 0.00, 0.02, 0.00
X-AntiVirus: checked by AntiVir MailGate (version: 2.0.1.9; AVE: 6.18.0.2; VDF: 6.18.0.15; host: mx.bla.fasel.org)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

* Alan Cox <alan@lxorguk.ukuu.org.uk> [2003-03-20 01:31]:
> On Wed, 2003-03-19 at 22:16, Wolfram Schlich wrote:
> > When one of the Promise controllers is sharing the same IRQ with one of
> > the NICs (don't matter which, I tried all) and data is copied *to* the
> > machine over the network, the system deadlocks. When data is copied
> > *from* the system over the network, it works all ok. Unfortunately the
> > system BIOS doesn't give me any possibility of setting the IRQ
> > channels by hand, so all I can do is put the cards into other slots.
> > 
> 
> Thats very useful information. There certain have been (and it seems
> still are) some cases with shared IRQ that are not quite handled right.
> The 2.4.21pre5/pre5-ac work has partly been about fixing it. Deadlocks
> suprise me however, since the problems I've seen have been I/O
> errors.

Well, now I have trashed my array :-)
-> http://marc.theaimsgroup.com/?l=linux-raid&m=104811878405765&w=2

Btw., it spits out *lots* of messages when IRQ sharing is *disabled*
in the kernel config and just dies quietly when it's *enabled*
(having it dying before didn't mess up my array... ;)).

> However there is another known problem that does cause deadlocks with
> the AMD76x, especially if the onboard IDE is used. Shove a PS/2 mouse
> in the box, reboot and retest - if you dont already have one

?! I'm using the onboard IDE for two CDROM drives and one smaller
hard disk which I use rarely... and I didn't use any of these devices
in the cases in which I had the described problems... Anyway, why should I
connect a PS/2 mouse to the machine? Is it gonna solve all my
problems at once? ;-)
-- 
Mit freundlichen Gruessen / Yours sincerely
Wolfram Schlich; Friedhofstr. 8, D-88069 Tettnang; +49-(0)178-SCHLICH
