Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310917AbSEEMGj>; Sun, 5 May 2002 08:06:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311121AbSEEMGi>; Sun, 5 May 2002 08:06:38 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:42504 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S310917AbSEEMGh>; Sun, 5 May 2002 08:06:37 -0400
Message-Id: <200205051202.g45C2hX13639@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Martin Dalecki <dalecki@evision-ventures.com>,
        Tim Schmielau <tim@physik3.uni-rostock.de>
Subject: Re: [PATCH] 2.5.13 IDE 50
Date: Sun, 5 May 2002 15:08:31 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Andreas Dilger <adilger@turbolabs.com>,
        Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <Pine.LNX.4.33.0205031949010.5617-100000@gans.physik3.uni-rostock.de> <3CD4748D.30301@evision-ventures.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 May 2002 21:53, Martin Dalecki wrote:
> Uz.ytkownik Tim Schmielau napisa?:
> >>- Fix wrong usage of time_after in ide.c. This should cure the drive
> >>seek
> >>   timeout problems some people where expierencing. This was clarified
> >>to me by
> >>   Bartek, who apparently checked whatever the actual code is consistent
> >>with the comments in front of it. Thank you Bartlomiej Zolnierkiewicz.
> >>
> >>   I think now that we should have time_past(xxx) in <linux/timer.h>.
> >
> > What would you suppose time_past(xxx) to do?
>
> Taking only a single parameter and telling whatever jiffies is bigger
> then it. Just that. Becouse if you grep for time_after or time_before
> you would realize immediately that nearly all of them take
> the variable jiffies as parameter.

Just in case it will be done: call it
jiffies_before(x) and jiffies_after(x), this sounds unambiguous IMHO.
--
vda
