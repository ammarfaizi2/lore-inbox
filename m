Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263259AbTIWLpc (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Sep 2003 07:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263345AbTIWLpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Sep 2003 07:45:32 -0400
Received: from smtp3.att.ne.jp ([165.76.15.139]:16582 "EHLO smtp3.att.ne.jp")
	by vger.kernel.org with ESMTP id S263259AbTIWLpb (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Sep 2003 07:45:31 -0400
Message-ID: <145601c381c8$07956760$44ee4ca5@DIAMONDLX60>
From: "Norman Diamond" <ndiamond@wta.att.ne.jp>
To: "Andries Brouwer" <aebr@win.tue.nl>
Cc: "Vojtech Pavlik" <vojtech@suse.cz>, <linux-kernel@vger.kernel.org>,
       "John Bradford" <john@grabjohn.com>
References: <1b7301c37a73$861bea70$2dee4ca5@DIAMONDLX60> <20030921110125.GB18677@ucw.cz> <0a5f01c38043$f9c35c80$44ee4ca5@DIAMONDLX60> <20030921171632.A11359@pclin040.win.tue.nl> <0c2001c38104$34c2a690$44ee4ca5@DIAMONDLX60> <20030922221453.A1064@pclin040.win.tue.nl>
Subject: Re: 2.6.0-test5 vs. Japanese keyboards
Date: Tue, 23 Sep 2003 20:44:12 +0900
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

Andries Brouwer and Norman Diamond:

> > > I think no kernel changes are required to use Japanese keyboards
> > > today.
> > > (But kbd has to be recompiled with NR_KEYS set to 256.)
> >
> > I'm not convinced yet.  defkeymap.c_shipped is included in the
> > downloadable .bz2 file and it is inadequate.
>
> But defkeymap is inadequeate for German, it is inadequate for French,
> why would it be adequate for Japanese?

I think that if defkeymap.c_shipped were inadequate for German and French
then you already would have fixed it.  I don't have experience with those
keyboards but would guess that defkeymap.c_shipped is probably adequate for
loadkeys to load a working keymap for German or French.

We have already discussed the fact that defkeymap.c_shipped is not adequate
to load a working keymap for Japanese.  In order to be capable of loading a
working keymap, defkeymap.c_shipped needs patching.  This is why the patch
looked so big.  Of course a working defkeymap.c_shipped should be generated
automatically from a different keymap file which doesn't need nearly as big
a patch.  Nonetheless defkeymap.c_shipped is part of the kernel, isn't it?
No matter how what method and how small an originating patch are used in
getting this one fixed, it is a part of the kernel that is getting fixed
here, isn't it?

> It is just the random default you get when no keymap was loaded.

It is that plus more.  It includes limits that prevent certain keymaps from
getting set when loaded.

