Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129233AbQKGHwt>; Tue, 7 Nov 2000 02:52:49 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129177AbQKGHwj>; Tue, 7 Nov 2000 02:52:39 -0500
Received: from shell.webmaster.com ([209.133.28.73]:9436 "EHLO
	shell.webmaster.com") by vger.kernel.org with ESMTP
	id <S129121AbQKGHwa>; Tue, 7 Nov 2000 02:52:30 -0500
From: "David Schwartz" <davids@webmaster.com>
To: "J. Dow" <jdow@earthlink.net>, <dank@alumni.caltech.edu>,
        <atmproj@yahoo.com>, <linux-kernel@vger.kernel.org>
Subject: RE: malloc(1/0) ??
Date: Mon, 6 Nov 2000 23:52:28 -0800
Message-ID: <NCBBLIEPOCNJOAEKBEAKAEAJLMAA.davids@webmaster.com>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook IMO, Build 9.0.2416 (9.0.2911.0)
In-Reply-To: <04c301c0488a$694d6360$0a25a8c0@wizardess.wiz>
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4133.2400
Importance: Normal
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> From: "Dan Kegel" <dank@alumni.caltech.edu>
> > atmproj@yahoo.com asked:
> > > [Why does this program not crash?]
> > >
> > > main()
> > > {
> > >    char *s;
> > >    s = (char*)malloc(0);
> > >    strcpy(s,"fffff");
> > >    printf("%s\n",s);
> > > }
> >
> > It doesn't crash because the standard malloc is
> > optimized for speed, not for finding bugs.
> >
> > Try linking it with a debugging malloc, e.g.
> >   cc bug.c -lefence
> > and watch it dump core.
>
> I'm not sure that is fully responsive, Dan. Why doesn't the
> strcpy throw a hissyfit and coredump?

	Why should it? Do you think that when you allocate memory, the chunk of
mappable memory you got always ends on the exact byte you asked it to? When
you invoke undefined behavior, anything can happen.

	DS

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
