Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271733AbTHDNYI (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Aug 2003 09:24:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271731AbTHDNYI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Aug 2003 09:24:08 -0400
Received: from natsmtp00.webmailer.de ([192.67.198.74]:16573 "EHLO
	post.webmailer.de") by vger.kernel.org with ESMTP id S271733AbTHDNW4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Aug 2003 09:22:56 -0400
Date: Mon, 4 Aug 2003 15:22:11 +0200
From: Martin Pitt <martin@piware.de>
To: Oleg Drokin <green@namesys.com>
Cc: linux-kernel@vger.kernel.org, vitaly@namesys.com
Subject: Re: PROBLEM: 2.6.0-test1/2 reiserfsck journal replaying hangs
Message-ID: <20030804132207.GA29529@donald.balu5>
References: <20030803102321.GA428@donald.balu5> <20030804075420.GB4396@namesys.com> <20030804084306.GB15110@donald.balu5> <20030804091703.GC3911@namesys.com> <20030804101310.GA1187@donald.balu5> <20030804101628.GD3911@namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20030804101628.GD3911@namesys.com>
User-Agent: Mutt/1.5.4i
X-AntiVirus: OK! AntiVir MailGate Version 2.0.1.1; AVE: 6.20.0.1; VDF: 6.20.0.55
	 at server1 has not found any known virus in this email.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

Am 2003-08-04 14:16 +0400 schrieb Oleg Drokin:
> Hello!
> 
> On Mon, Aug 04, 2003 at 12:13:12PM +0200, Martin Pitt wrote:
> 
> > > What was screen looking like at the hang time (can you capture it somehow?),
> > That's very difficult, no consoles are active at that time. There are
> > no error messages and no messages that don't appear with 2.4.x, apart
> > from the warnings about missing module stuff. I can photograph it if
> > you want.
> 
> Yeah, sure.

I did that. I will send you the screenshot per private mail for not
cluttering up the mailing list.

> > > can you press sysrq-T at the time of a hang and then send us the traces?
> > That's even more difficult, it produces several screenfulls of text
> > scrolling away very fast. I'd need a serial console for this purpose
> > but it will last a while to set this up since I don't have the
> > necessary hardware here. I could do it tomorrow.
> 
> Well, as I understand, you first press sysrq-T, then ^C, then thing boots and you can
> colled sysrq-t output from dmesg or boot logs.

It does not work that way. Both with 2.4.x and 2.6.0-test2, after
pressing sysrq-something you can only choose actions from the menu (i.
e. eventually reboot). Every key press is interpreted as magic key
menu selection, I do not even have to hold down alt+sysrq to choose
's'ync, 'b'oot and so on. There is no such thing as "e'x'it from this
menu". This may be regarded as another bug.

Syslog is not started at the point of root fs check, thus the dump is
not saved. I cannot call dmesg since after sysrq+t I'm stuck in the
emergency menu. So I booted normally (^C, ^D) and then did a sysrq+t,
rebooting and saving the previous syslog (boot messages and trace) in
kernmsg.txt. I do not think that it will be helpful since fsck has
finished at that time, but I attach it nevertheless.

Any other chance? I can also try other combinations (modular kernel,
no devfs, etc. but actually I like it the way it is).

Thanks!

Martin
-- 
Martin Pitt
home:  www.piware.de
eMail: martin@piware.de

Es gibt zwei Regeln für Erfolg im Leben:
1. Erzähle den Leuten nie alles, was Du weißt.
