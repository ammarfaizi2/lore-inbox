Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267849AbTAMTuQ>; Mon, 13 Jan 2003 14:50:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S268155AbTAMTuQ>; Mon, 13 Jan 2003 14:50:16 -0500
Received: from khms.westfalen.de ([62.153.201.243]:57226 "EHLO
	khms.westfalen.de") by vger.kernel.org with ESMTP
	id <S267849AbTAMTuM>; Mon, 13 Jan 2003 14:50:12 -0500
Date: 13 Jan 2003 20:56:00 +0200
From: kaih@khms.westfalen.de (Kai Henningsen)
To: rusty@rustcorp.com.au
cc: linux-kernel@vger.kernel.org
Message-ID: <8do$n39mw-B@khms.westfalen.de>
In-Reply-To: <20030111224007$7807@gated-at.bofh.it>
Subject: Re: [PATCH] Make `obsolete params' work correctly if MODULE_SYMBOL_PRE
X-Mailer: CrossPoint v3.12d.kh10 R/C435
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Organization: Organisation? Me?! Are you kidding?
References: <20030111224007$7807@gated-at.bofh.it>
X-No-Junk-Mail: I do not want to get *any* junk mail.
Comment: Unsolicited commercial mail will incur an US$100 handling fee per received mail.
X-Fix-Your-Modem: +++ATS2=255&WO1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

rusty@rustcorp.com.au (Rusty Russell)  wrote on 11.01.03 in <20030111224007$7807@gated-at.bofh.it>:

> In message <Pine.LNX.4.44.0301102134150.9532-100000@home.transmeta.com> you
> wri te:
> >
> > On Sat, 11 Jan 2003, Rusty Russell wrote:
> > >
> > > Just in case someone names a variable over 2000 chars, and uses it as
> > > an old-style module parameter?
> >
> > No. Just because variable-sized arrays aren't C, and generate crappy code.
> >
> > >  	for (i = 0; i < num; i++) {
> > > +		char sym_name[strlen(obsparm[i].name)
> > > +			     + sizeof(MODULE_SYMBOL_PREFIX)];
> >
> > It's still there.
>
> OK, *please* explain to me in little words so I can understand.

Do "char sym_name[CONSTANT];". What's so hard to understand about that?

> Variable-sized arrays are C, as of C99.  They've been a GNU extension
> forever.

Actually, the gcc thing and the C99 thing are significantly different, and  
neither is a sub- or superset of the other. In fact, gcc's C99-conformance  
page (http://gcc.gnu.org/c99status.html) still lists VLAs as "broken".

See here for at least some explanation:
        http://gcc.gnu.org/ml/gcc/2002-10/msg00470.html

> While gcc 2.95.4 generates fairly horrible code, gcc 3.0 does better
> (the two compilers I have on my laptop).
>
> Both generate correct code.

For the GNU extension, maybe.

MfG Kai
