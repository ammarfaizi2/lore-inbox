Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267328AbTAVFvp>; Wed, 22 Jan 2003 00:51:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267329AbTAVFvp>; Wed, 22 Jan 2003 00:51:45 -0500
Received: from TYO201.gate.nec.co.jp ([210.143.35.51]:43904 "EHLO
	TYO201.gate.nec.co.jp") by vger.kernel.org with ESMTP
	id <S267328AbTAVFvo>; Wed, 22 Jan 2003 00:51:44 -0500
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Greg Ungerer <gerg@snapgear.com>,
       Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>,
       linux-kernel@vger.kernel.org
Subject: Re: common RODATA in vmlinux.lds.h (2.5.59)
References: <Pine.LNX.4.44.0301212045000.1577-100000@chaos.physics.uiowa.edu>
	<3E2E0F38.7090506@snapgear.com>
	<buoptqp954l.fsf@mcspd15.ucom.lsi.nec.co.jp>
	<20030122054230.GA954@mars.ravnborg.org>
Reply-To: Miles Bader <miles@gnu.org>
System-Type: i686-pc-linux-gnu
Blat: Foop
From: Miles Bader <miles@lsi.nec.co.jp>
Date: 22 Jan 2003 15:00:25 +0900
In-Reply-To: <20030122054230.GA954@mars.ravnborg.org>
Message-ID: <buolm1d911i.fsf@mcspd15.ucom.lsi.nec.co.jp>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:
> > [To be honest, I think the stuff with `LOAD_OFFSET' is a bit of a waste;
> > it seems cleaner to just have archs define their own sections as
> > appropriate, and use RODATA_CONTENTS directly -- it's the input sections
> > and related symbols that are always changing (and so better centralized),
> > after all, not the output sections.]
> 
> There were some reports of failed boots that boiled down to
> mis-alignment of a single section.
> With your suggestion we will end up in the same problem.
> __start_ksymbtab will in some cases have a value less than the actual
> start of the first symbol.

Then it would seem an alignment directive should probably be included
before __start_ksymbtab (and possibly other places).  [but I can't see
what it has to do with having separate sections or not.]

-Miles
-- 
"Most attacks seem to take place at night, during a rainstorm, uphill,
 where four map sheets join."   -- Anon. British Officer in WW I
