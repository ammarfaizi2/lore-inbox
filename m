Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271699AbTHDKNT (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 06:13:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271700AbTHDKNT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 06:13:19 -0400
Received: from natsmtp01.webmailer.de ([192.67.198.81]:2722 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S271699AbTHDKNR
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 06:13:17 -0400
Date: Mon, 4 Aug 2003 12:13:12 +0200
From: Martin Pitt <martin@piware.de>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org, vitaly@namesys.com
Subject: Re: PROBLEM: 2.6.0-test1/2 reiserfsck journal replaying hangs
Message-ID: <20030804101310.GA1187@donald.balu5>
References: <20030803102321.GA428@donald.balu5> <20030804075420.GB4396@namesys.com> <20030804084306.GB15110@donald.balu5> <20030804091703.GC3911@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030804091703.GC3911@namesys.com>
User-Agent: Mutt/1.5.4i
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.1; AVE: 6.20.0.1; VDF: 6.20.0.55
	 at server1 has not found any known virus in this email.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Am 2003-08-04 13:12 +0400 schrieb Oleg Drokin:
> > 3.6.6, the kernel Changes says that 3.6.3 is required at least, thus
> > it should be okay.

> Hi Martin, would you try 3.6.11 reiserfsprogs and tell us about the result?

I upgraded reiserfsck and tried again. Now a note appears that I
obviously created my partitions with an older version of reiserfsprogs
and that the journal header was fixed.

Otherwise, it behaves similar, the last message is "Replaying journal"
and that hangs forever.

Am 2003-08-04 13:17 +0400 schrieb Oleg Drokin:
> On Mon, Aug 04, 2003 at 10:43:07AM +0200, Martin Pitt wrote:
> > > So you are starrting reiserfsck on rootfs and it starts to
> > > replay a journal? That's really weird (but seems there is nthing to do with
> > > kernel, though).
> > Well, it is started automatically. Actually, the line "replaying
> > journal" appears with every boot and it also lasts a while, so I
> > suppose it is actually done. fsck and replaying works with all other
> > file systems, it only hangs with the root fs.
> 
> Hm, have you tried to press any other keys prior to ^C?

Yes, but only very few work: after ^C and PrintScreen a prompt
appears: "press Control-D for normal startup or enter root password"
(something similar; ^D works well) and SysRq-... work normally (magic
key). 

> What was screen looking like at the hang time (can you capture it somehow?),

That's very difficult, no consoles are active at that time. There are
no error messages and no messages that don't appear with 2.4.x, apart
from the warnings about missing module stuff. I can photograph it if
you want.

> can you press sysrq-T at the time of a hang and then send us the traces?

That's even more difficult, it produces several screenfulls of text
scrolling away very fast. I'd need a serial console for this purpose
but it will last a while to set this up since I don't have the
necessary hardware here. I could do it tomorrow.

Thanks and have a nice day!

Martin
-- 
Martin Pitt
home:  www.piware.de
eMail: martin@piware.de

Es gibt zwei Regeln für Erfolg im Leben:
1. Erzähle den Leuten nie alles, was Du weißt.
