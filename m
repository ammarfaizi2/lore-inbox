Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312930AbSCZDde>; Mon, 25 Mar 2002 22:33:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312933AbSCZDdY>; Mon, 25 Mar 2002 22:33:24 -0500
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:33548 "EHLO
	rtr.ca") by vger.kernel.org with ESMTP id <S312930AbSCZDdK>;
	Mon, 25 Mar 2002 22:33:10 -0500
Message-ID: <3C9FEBB6.1C8B471F@pobox.com>
Date: Mon, 25 Mar 2002 22:32:06 -0500
From: Mark Lord <mlord@pobox.com>
Organization: Real-Time Remedies Inc.
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.18-pre9 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John Summerfield <summer@os2.ami.com.au>
CC: Alan Cox <alan@lxorguk.ukuu.org.uk>, andre@linux-ide.org,
        linux-kernel@vger.kernel.org, summer@numbat.Os2.Ami.Com.Au
Subject: Re: IDE and hot-swap disk caddies
In-Reply-To: <200203252316.g2PNGD011116@numbat.Os2.Ami.Com.Au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, what you tried at first is very close,
and could be made to work for you with some debugging.

But ideally, I think the driver should just rescan the interface
anytime a raw drive (minor number == 0) access is performed..
More or less.  With a bit of debounce logic.

Cheers
-- 
Mark Lord
Real-Time Remedies Inc.
mlord@pobox.com


John Summerfield wrote:
> 
> > > The device is hot-swap capable and has a switch (others have a key)
> > > that locks the drive in and powers it up; in the other position the
> > > drive is powered down and can be removed.
> >
> > Linux doesn't support IDE hot swap at the drive level. Its basically
> > waiting people to want it enough to either fund it or go write the code
> >
> 
> What needs to be done? How extensive is the surgery needed?
> 
> --
> Cheers
> John Summerfield
> 
> Microsoft's most solid OS: http://www.geocities.com/rcwoolley/
> 
> Note: mail delivered to me is deemed to be intended for me, for my
> disposition.
> 
> ==============================
> If you don't like being told you're wrong,
>         be right!
