Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291924AbSBNVYd>; Thu, 14 Feb 2002 16:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291918AbSBNVYX>; Thu, 14 Feb 2002 16:24:23 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:46087 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S291913AbSBNVYK>; Thu, 14 Feb 2002 16:24:10 -0500
Subject: Re: fsync delays for a long time.
To: moibenko@fnal.gov (Alexander Moibenko)
Date: Thu, 14 Feb 2002 21:37:34 +0000 (GMT)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox), akpm@zip.com.au (Andrew Morton),
        linux-kernel@vger.kernel.org
In-Reply-To: <Pine.SGI.4.31.0202141510530.3270649-100000@fsgi03.fnal.gov> from "Alexander Moibenko" at Feb 14, 2002 03:12:29 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16bTZO-0001DH-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > > This could very well be due to request allocation starvation.
> > > fsync is sleeping in __get_request_wait() while bonnie keeps
> > > on stealing all the requests.
> >
> > That may amplify it but in the 2.2 case fsync on any sensible sized file
> > is already horribly performing. It hits databases like solid quite badly
> >
> please elaborate on "sensible sized". In my case it is less then 20MB.

That ought to be ok. Andrew may well be right in that case.
