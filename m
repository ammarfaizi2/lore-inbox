Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317476AbSFDKxS>; Tue, 4 Jun 2002 06:53:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317478AbSFDKxR>; Tue, 4 Jun 2002 06:53:17 -0400
Received: from daimi.au.dk ([130.225.16.1]:39014 "EHLO daimi.au.dk")
	by vger.kernel.org with ESMTP id <S317476AbSFDKxQ>;
	Tue, 4 Jun 2002 06:53:16 -0400
Message-ID: <3CFC9C08.9D73FF62@daimi.au.dk>
Date: Tue, 04 Jun 2002 12:52:56 +0200
From: Kasper Dupont <kasperd@daimi.au.dk>
Organization: daimi.au.dk
X-Mailer: Mozilla 4.76 [en] (X11; U; Linux 2.4.9-31smp i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andre Hedrick <andre@linux-ide.org>, Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: ALi IDE problem
In-Reply-To: <Pine.LNX.4.10.10206021436530.5846-100000@master.linux-ide.org> <3CFC58DC.269E0C88@daimi.au.dk>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kasper Dupont wrote:
> 
> Andre Hedrick wrote:
> >
> > Kasper,
> >
> > http://www.linuxdiskcert.org/ide-2.4.19-p8-ac1.all.convert.10.patch.bz2
> > http://www.linuxdiskcert.org/ide-2.4.19-p7.all.convert.10.patch.bz2
> >
> > Please try this on top of a stock 2.4.19-pre8-ac1 plus patch.
> > Also try a stock 2.4.19-pre7 plus patch.
> >
> > First, at line 553.
> >
> > #define ALI_INIT_CODE_TEST
> >
> > Change to
> >
> > #undef ALI_INIT_CODE_TEST
> 
> Many hourse of kernel compilations later:
> 
> The following works:
> -pre7
> -pre8-ac1
> -pre8-ac2
> 
> The following fails:
> -pre7 with ide patch
> -pre8-ac1 with ide patch
> -pre8-ac3
> -pre8-ac4
> -pre8-ac5
> 
> Changing ALI_INIT_CODE_TEST doesn't help.
> It fails both with #define and #undef.
> 
> Perhaps I should try reverting the patch
> against -pre9-ac3?

Reverting the patch against 2.4.19-pre9-ac3 seems to solve my
problem. Now DMA works. (A single hunk got rejected and had
to be applied by hand.)

-- 
Kasper Dupont -- der bruger for meget tid på usenet.
For sending spam use mailto:razor-report@daimi.au.dk
