Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313012AbSDYJUR>; Thu, 25 Apr 2002 05:20:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313016AbSDYJUQ>; Thu, 25 Apr 2002 05:20:16 -0400
Received: from krynn.axis.se ([193.13.178.10]:51114 "EHLO krynn.axis.se")
	by vger.kernel.org with ESMTP id <S313012AbSDYJUP>;
	Thu, 25 Apr 2002 05:20:15 -0400
From: johan.adolfsson@axis.com
Message-ID: <01c201c1ec3a$a78d5400$adb270d5@homeip.net>
Reply-To: <johan.adolfsson@axis.com>
To: "john slee" <indigoid@higherplane.net>, <ebuddington@wesleyan.edu>
Cc: <linux-kernel@vger.kernel.org>
In-Reply-To: <20020424224714.B19073@ma-northadams1b-46.bur.adelphia.net> <20020425085237.GE17717@higherplane.net>
Subject: Re: Dissociating process from bin's filesystem
Date: Thu, 25 Apr 2002 11:22:00 +0200
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 5.50.4522.1200
X-MimeOLE: Produced By Microsoft MimeOLE V5.50.4522.1200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Doesn't mlockall() do this?
man mlockall
/Johan

----- Original Message -----
From: "john slee" <indigoid@higherplane.net>
To: <ebuddington@wesleyan.edu>
Cc: <linux-kernel@vger.kernel.org>
Sent: den 25 april 2002 10:52
Subject: Re: Dissociating process from bin's filesystem


> On Wed, Apr 24, 2002 at 10:47:14PM -0400, Eric Buddington wrote:
> > Is there any way to dissociate a process from its on-disk binary?  In
> > other words, I want to start 'foo_daemon', then unmount the filesystem
> > it started from. It seems to me this would be reasonably accomplished
> > by loading the binary completely into memory first ro eliminate the
> > dependence.
> >
> > Is this possible, or planned? Are there intractable problems with it
> > that I don't see?
>
> as i understand it this precludes you from using shared libs as they are
> mmap()'d on startup...
>
> other than that the running daemon will cause the fs to be
> un-umountable.
>
> j.
>
> --
> R N G G   "Well, there it goes again... And we just sit
>  I G G G   here without opposable thumbs." -- gary larson
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
>

