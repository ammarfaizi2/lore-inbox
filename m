Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S274996AbTHQCXs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Aug 2003 22:23:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S275007AbTHQCXr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Aug 2003 22:23:47 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:41636 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S274996AbTHQCXq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Aug 2003 22:23:46 -0400
Message-ID: <102601c36466$784bef30$1aee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Mikael Pettersson" <mikpe@csd.uu.se>
Cc: <linux-kernel@vger.kernel.org>
References: <0a5b01c36305$4dec8b80$1aee4ca5@DIAMONDLX60><20030815111442.A12422@flint.arm.linux.org.uk><0d7c01c3632a$668da140$1aee4ca5@DIAMONDLX60> <16188.55901.775494.576967@gargle.gargle.HOWL>
Subject: Re: Trying to run 2.6.0-test3
Date: Sun, 17 Aug 2003 10:51:09 +0900
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2800.1158
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Mikael Pettersson" <mikpe@csd.uu.se> replied to me:

>  > [...] cardmgr doesn't start automatically in 2.6.0-test3.
>
> You probably need fixes to /etc/rc.d/init.d/pcmcia (drop module ".o"
> extensions from modprobe commands) and /etc/hotplug/net.agent (case
> $ACTION needs "add|register" not just "register").

Very close.  /etc/rc.d/pcmcia is a SuSE script which "knows" that some
things weren't compiled into the kernel, it "knows" that the things were
modules.  I didn't want to spend a few hours learning enough bash
programming to make the thing deal with all the possibilities of 2.4 and
2.6.  Instead, I changed the .config to compile PCMCIA stuff as modules (and
also some network stuff and serial stuff that are giving problems), and
munged some ".o" to ".ko" extensions.  Fortunately it isn't completely
necessary to delete the ".ko" extension.

/etc/hotplug/net.agent was editable exactly as you said.

When I have time I'll hunt for the SuSE scripts hotplug scripts for serial
stuff that is still giving problems.

