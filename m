Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266366AbUJWKTu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266366AbUJWKTu (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Oct 2004 06:19:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266463AbUJWKTu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Oct 2004 06:19:50 -0400
Received: from pop.gmx.net ([213.165.64.20]:10187 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S266366AbUJWKTr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Oct 2004 06:19:47 -0400
Date: Sat, 23 Oct 2004 12:19:46 +0200 (MEST)
From: "Bodo Eggert" <7eggert@nurfuerspam.de>
To: root@chaos.analogic.com
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
References: <Pine.LNX.4.61.0410180724110.18025@chaos.analogic.com>
Subject: Re: Fw: signed kernel modules?
X-Priority: 3 (Normal)
X-Authenticated: #2358466
Message-ID: <28998.1098526786@www44.gmx.net>
X-Mailer: WWW-Mail 1.6 (Global Message Exchange)
X-Flags: 0001
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Sun, 17 Oct 2004, Bodo Eggert wrote:
> > Richard B. Johnson wrote:

> >> One can make a 'certified' kernel with 'certified' modules
> >> for some hush-hush project. Adding this kind of junk isn't
> >> how it's done. You just take your favorite kernel with the
> >> modules you require, you verify that it meets your security
> >> requirements, then you CRC the kernel and its modules. You
> >> keep the CRCs somewhere safe, available from a read-only
> >> source like a CD/ROM or a network file-server.
[...]

> > If a malicious module loads, you lose instantly. You cannot relaibly
> check
> > module integrity on this system anymore. E.g. the malicious module might
> > patch the module checker to check a signed module instead of the
> malicious
> > one. Or the Exploit saves the old module, puts in the patched one, loads
> it
> > and puts the old one back in place.

> What malicious module?  They have all been certified. That ARE NO
> OTHER modules.

At least until an attacker uploads a malicious module or modifies one of the
(untill then) certified modules. (He can, because your kernel doesn't check
them while loading.)

> If you don't do it this way, i.e., if you allow
> anybody to load a module, then you have no security, regardless of
> what's in the module, the loader, or the kernel. Any crap inside
> either of these is crap. Then can all be modified to do anything
> so gigibytes of "protective" software is absouye bullshit, and
> a lot of memory wasted.

If your box is r00ted, you'll want to notice this fact and do something
against it. If you don't prevent loading malicious modules, the attacker can
hide his presence and use your system right under your eyes, and you won't
notice (even while checking the checksumes).

Signing modules is (off cause) just one step, the next one(s) would be to
prevent all other modifications to the kernel memory.

-- 
Geschenkt: 3 Monate GMX ProMail + 3 Ausgaben der TV Movie mit DVD
++++ Jetzt anmelden und testen http://www.gmx.net/de/go/mail ++++

