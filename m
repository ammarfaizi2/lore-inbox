Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S314666AbSDTRig>; Sat, 20 Apr 2002 13:38:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S314667AbSDTRif>; Sat, 20 Apr 2002 13:38:35 -0400
Received: from mailout02.sul.t-online.com ([194.25.134.17]:16536 "EHLO
	mailout02.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S314666AbSDTRie>; Sat, 20 Apr 2002 13:38:34 -0400
Content-Type: text/plain; charset=US-ASCII
From: Oliver Neukum <oliver@neukum.name>
To: Greg KH <greg@kroah.com>
Subject: Re: 2.4.18 usb(?) oops
Date: Sat, 20 Apr 2002 19:14:51 +0200
X-Mailer: KMail [version 1.3.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <200204201533.50375.kiza@gmx.net> <20020420152041.GA17327@kroah.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-ID: <16yyR4-0BqCa8C@fmrl04.sul.t-online.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 20 April 2002 17:20, Greg KH wrote:
> On Sat, Apr 20, 2002 at 03:33:50PM +0200, Oliver Feiler wrote:
> > Hi,
> >
> > This oops occurs everytime I use kpilot to hotsync my Handpsring Visor.
>
> As per the archives, use this patch to fix this problem:
> 	http://marc.theaimsgroup.com/?l=linux-kernel&m=101735261202744

By the way, module usage count handling in the visor driver has
a race. You increment it after down() which can sleep.

	Regards
		Oliver
