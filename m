Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316609AbSFDMpk>; Tue, 4 Jun 2002 08:45:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316610AbSFDMpj>; Tue, 4 Jun 2002 08:45:39 -0400
Received: from vivi.uptime.at ([62.116.87.11]:52396 "EHLO vivi.uptime.at")
	by vger.kernel.org with ESMTP id <S316609AbSFDMph>;
	Tue, 4 Jun 2002 08:45:37 -0400
Reply-To: <o.pitzeier@uptime.at>
From: "Oliver Pitzeier" <o.pitzeier@uptime.at>
To: "'Ivan Kokshaysky'" <ink@jurassic.park.msu.ru>
Cc: <linux-kernel@vger.kernel.org>, <axp-kernel-list@redhat.com>
Subject: RE: kernel 2.5.20 on alpha (RE: [patch] Re: kernel 2.5.18 on alpha)
Date: Tue, 4 Jun 2002 14:45:16 +0200
Organization: =?us-ascii?Q?UPtime_Systemlosungen?=
Message-ID: <000a01c20bc5$b0681830$010b10ac@sbp.uptime.at>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
X-Priority: 3 (Normal)
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook, Build 10.0.3416
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Importance: Normal
In-Reply-To: <000101c20bb0$27e93620$010b10ac@sbp.uptime.at>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

I already found a few more errors while trying to compile
2.5.20. I send you the patch as soon as I have successfully
compiled the kernel _without_ problems (hopefully today).

FYI. I do not compile very much options; The main options
I compile ('coz I need 'em and nothing more...):
SCSI:           QLogic ISP
Network:        DECchip Tulip (dc2114x) and Early DECchip
                Tulip (dc2104x)
Character Dev.: Support for console on serial port
Filesystems:    EXT3 support, no ReiserFS
Network FS:     NFS (as module)

Greetz,
   Oliver

> Oliver Pitzeier wrote:
> [ ... ]
> 
> > If you want to know the error:
> 
> [ ... ]
> 
> > `copy_user_page' undeclared (first use in this function)
> > make[1]: *** [main.o] Error 1
> > make[1]: Leaving directory `/usr/src/linux-2.5.20/init'
> > make: *** [init] Error 2
> 
> I guess I found where the error comes from:
> 
> (from the 2.5.20 Changelog):
> > <davidm@napali.hpl.hp.com>
> > [PATCH] pass "page" pointer to clear_user_page()/copy_user_page()
> > 
> > Hi Linus,
> > 
> > Are you willing to change the interfaces of clear_user_page() and
> > copy_user_page() so that they can receive the relevant page 
> pointer as 
> > a separate argument?  I need this on ia64 to implement the 
> lazy-cache 
> > flushing scheme.
> >
> > I believe PPC would also benefit from this.
> >
> > --david
> 
> Now I believe, that Alpha also benefits from this. :o) The 
> only thing I have to do - I guess - is to change the defines 
> for copy_user_page() and clear_user_page. Adding the not used 
> parameter >pg< should not make any problems.
> 
> Greetz,
>   Oliver 


