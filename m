Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280891AbRKYPSZ>; Sun, 25 Nov 2001 10:18:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280867AbRKYPSQ>; Sun, 25 Nov 2001 10:18:16 -0500
Received: from smtpnotes.altec.com ([209.149.164.10]:17158 "HELO
	smtpnotes.altec.com") by vger.kernel.org with SMTP
	id <S280823AbRKYPR7>; Sun, 25 Nov 2001 10:17:59 -0500
X-Lotus-FromDomain: ALTEC
From: Wayne.Brown@altec.com
To: Arnaldo Carvalho de Melo <acme@conectiva.com.br>
cc: lkml <linux-kernel@vger.kernel.org>
Message-ID: <86256B0F.0053E736.00@smtpnotes.altec.com>
Date: Sun, 25 Nov 2001 09:16:17 -0600
Subject: Re: Linux 2.5.0
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



Thanks.  I had hoped the version number was the only change, but wanted to be
sure.  I'll be keeping just one source tree for both 2.4.x and 2.5.x and
switching between the versions by applying and reversing patches as needed, so
it's important that my copy of the source stay *exactly* in sync with Linus'
copy (otherwise I've have just altered the version in the Makefile myself).
With the help of your patch I've just built both 2.4.16-pre1 and 2.5.1-pre1 from
the same 2.4.15 source, which is what I wanted.

Wayne




Arnaldo Carvalho de Melo <acme@conectiva.com.br> on 11/25/2001 01:53:40 AM

To:   Anuradha Ratnaweera <anuradha@gnu.org>
cc:   James Davies <james_m_davies@yahoo.com>, Wayne
      Brown/Corporate/Altec@Altec, lkml <linux-kernel@vger.kernel.org>

Subject:  Re: Linux 2.5.0



Em Sun, Nov 25, 2001 at 01:31:57PM +0600, Anuradha Ratnaweera escreveu:
> On Sun, Nov 25, 2001 at 05:14:53PM +1000, James Davies wrote:
> > On Sun, 25 Nov 2001 16:52, Wayne.Brown@altec.com wrote:
> > > Is there going to be an "official" patch from 2.4.15 to 2.5.0?  I'd rather
> > > not ftp the whole kernel tarball over a modem connection, and I don't have
> > > the disk space on my laptop to keep both the complete 2.4 and 2.5 source
at
> > > the same time anyway.
> >
> > 2.4.15 is the same as 2.5.0
>
> I think he is concerned about the _official_ 2.4.15 and the _official_ 2.5.0,
> because, subsequent patches for 2.5.0 will not _cleanly_ apply on 2.4.15 tree
> (although fixing them should be extremely trivial).
>
> Can somebody confirm that the difference is only the version numbers in the
> Makefile, and no other changes in Documentation/ etc?

hey, the _oficial_ word from Linus is that it had changed only the version:

[acme@brinquedo b]$ diff -uNr 2.4.15 2.5.0
diff -uNr 2.4.15/Makefile 2.5.0/Makefile
--- 2.4.15/Makefile     Thu Nov 22 17:22:58 2001
+++ 2.5.0/Makefile      Fri Nov 23 04:23:44 2001
@@ -1,7 +1,7 @@
 VERSION = 2
-PATCHLEVEL = 4
-SUBLEVEL = 15
-EXTRAVERSION =-greased-turkey
+PATCHLEVEL = 5
+SUBLEVEL = 0
+EXTRAVERSION =

 KERNELRELEASE=$(VERSION).$(PATCHLEVEL).$(SUBLEVEL)$(EXTRAVERSION)

[acme@brinquedo b]$

See?

- Arnaldo
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://www.tux.org/lkml/




