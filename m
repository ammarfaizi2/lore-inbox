Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266712AbRG1O6K>; Sat, 28 Jul 2001 10:58:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266696AbRG1O6A>; Sat, 28 Jul 2001 10:58:00 -0400
Received: from mailout05.sul.t-online.com ([194.25.134.82]:10507 "EHLO
	mailout05.sul.t-online.de") by vger.kernel.org with ESMTP
	id <S266688AbRG1O5y>; Sat, 28 Jul 2001 10:57:54 -0400
Date: 28 Jul 2001 16:37:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: linux-kernel@vger.kernel.org
Message-ID: <85kynGlmw-B@khms.westfalen.de>
In-Reply-To: <E15QF5E-0006ZL-00@the-village.bc.nu>
Subject: Re: Strange remount behaviour with ext3-2.4-0.9.4
X-Mailer: CrossPoint v3.12d.kh7 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
In-Reply-To: <20010728090836.B1625@weta.f00f.org> <E15QF5E-0006ZL-00@the-village.bc.nu>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

alan@lxorguk.ukuu.org.uk (Alan Cox)  wrote on 27.07.01 in <E15QF5E-0006ZL-00@the-village.bc.nu>:

> > more-or-less need need a tree-based fs and reference counting for all
> > the magic bits).  In fact, doing it as the fs layer means you could
> > have r/w snapshots with COW semantics.
>
> You dont want r/w snapshots for archiving.

Not for archiving, but when you want to run something and then throw it  
away again, for example. You could do that by just holding onto a ro  
snapshot and then replacing the rw tree with it later, but by having two  
rw trees you don't need to stop your regular operations.

For this to really be useful, you'd want it as an inheritable per-process  
thing, similar to aviro's namespace thing.

MfG Kai
