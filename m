Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317689AbSGUPcQ>; Sun, 21 Jul 2002 11:32:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317693AbSGUPcP>; Sun, 21 Jul 2002 11:32:15 -0400
Received: from mailout11.sul.t-online.com ([194.25.134.85]:36327 "EHLO
	mailout11.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S317689AbSGUPcM> convert rfc822-to-8bit; Sun, 21 Jul 2002 11:32:12 -0400
Content-Type: text/plain; charset=US-ASCII
From: Marc-Christian Petersen <mcp@linux-systeme.de>
Organization: Linux-Systeme GmbH
To: Adrian Bunk <bunk@fs.tum.de>
Subject: Re: heavy Disk I/O and system stops reacting for seconds
Date: Sun, 21 Jul 2002 17:34:56 +0200
X-Mailer: KMail [version 1.4]
Cc: linux-kernel@vger.kernel.org
References: <Pine.NEB.4.44.0207211613350.11656-100000@mimas.fachschaften.tu-muenchen.de>
In-Reply-To: <Pine.NEB.4.44.0207211613350.11656-100000@mimas.fachschaften.tu-muenchen.de>
X-PRIORITY: 2 (High)
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200207211734.56224.mcp@linux-systeme.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sunday 21 July 2002 16:17, Adrian Bunk wrote:

Hi Adrian,

> On Sun, 21 Jul 2002, Marc-Christian Petersen wrote:
> > Hi there,
> >
> > I think someone else notices this too, but anyway, i write down my
> > experiences.
> >
> > I've tested 2.4.19rc[1|2|3], AC tree, AA tree, jam tree and mjc tree
> > All of them shows up the same behaviour. If i do some disk i/o, f.e.:
> >
> > tar xzpf linux-2.4.18.tar.gz; rm -rf linux-2.4.18
> >
> > the system stopps reacting while untar/ungzipping the file for more than
> > 5 seconds. Nothing but the mouse reacts. This does NOT occur with 2.4.18
> > and early 2.4.19-pre's ...
> >...
>
> <--  snip  -->
>
> I tried to start Gimp from the fvwm menu after I typed a letter - and
> Gimp has completed its startup before the letter arrived in the xterm.
for my tests this does not appear. System does nothing for some seconds, no 
keyboard input, no startup of programs, just nothing. Seems like flushing 
somewhat to disk.

I think i have the causer. I've downgraded ext3fs code to 2.4.18 code and 
those behaviour is gone! I think ext3fs needs a big deep review before 2.4.19 
gets final.

-- 
Kind regards
        Marc-Christian Petersen

http://sourceforge.net/projects/wolk

PGP/GnuPG Key: 1024D/408B2D54947750EC
Fingerprint: 8602 69E0 A9C2 A509 8661 2B0B 408B 2D54 9477 50EC
Key available at www.keyserver.net. Encrypted e-mail preferred.
