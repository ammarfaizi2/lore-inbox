Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S278699AbRJXSkZ>; Wed, 24 Oct 2001 14:40:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S278707AbRJXSkP>; Wed, 24 Oct 2001 14:40:15 -0400
Received: from [200.248.92.2] ([200.248.92.2]:44559 "EHLO
	inter.lojasrenner.com.br") by vger.kernel.org with ESMTP
	id <S278699AbRJXSkC>; Wed, 24 Oct 2001 14:40:02 -0400
Message-Id: <200110241936.RAA04632@inter.lojasrenner.com.br>
Content-Type: text/plain; charset=US-ASCII
From: Andre Margis <andre@sam.com.br>
Organization: SAM Informatica Ltda
To: Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: linux-2.4.13 high SWAP
Date: Wed, 24 Oct 2001 16:37:26 -0200
X-Mailer: KMail [version 1.3.1]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.21.0110241509250.885-100000@freak.distro.conectiva>
In-Reply-To: <Pine.LNX.4.21.0110241509250.885-100000@freak.distro.conectiva>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Em Qua 24 Out 2001 15:10, Marcelo Tosatti escreveu:
The tmpfs is configured with 2GB. I'm copying 6 file of 200M, total 1.2GB.

df -k

 Filesystem           1k-blocks      Used Available Use% Mounted on
/dev/sda3              4096440   3342964    753476  82% /
/dev/sda2                31111     12264     17241  42% /boot
/dev/root/fs01         3145628    465992   2679636  15% /u
/dev/root/fs02         9330396   1475848   7854548  16% /prod
tmpfs                  2097152    204836   1892316  10% /tmp

Without use the tmpfs, appears to be OK!!!!!!!!!!

Using 2.4.10-ac7, the same test run OK!!!!!!!!


Andre


> Ok,
>
> Have you checked if the amount of data you copied to the tmpfs device is
> not way too big to fit in memory ?
>
> Remember: Everything copied to tmpfs will be kept in memory, so if you
> simply copy way too much data to tmpfs thats your problem :)
>
> On Wed, 24 Oct 2001, Andre Margis wrote:
> > Em Qua 24 Out 2001 14:44, Marcelo Tosatti escreveu:
> > Marcelo,
> >
> > I restart the test using the same programs, but now I'm using the "cp" on
> > a normal filesystem. At this time everything is OK.
> >
> > In the last run we Nedd 30 minutes to the disaster.
> >
> >
> > Andre
> >
> > > On Wed, 24 Oct 2001, Andre Margis wrote:
> > > > Em Qua 24 Out 2001 15:05, Andre Margis escreveu:
> > > >
> > > > Mor minutes later the machine "froze".
> > >
> > > Could you please redo the tests without tmpfs?
> > >
> > > I'm not sure if its the problem, just want to make sure.
> > >
> > > Thanks.
> > >
> > > -
> > > To unsubscribe from this list: send the line "unsubscribe linux-kernel"
> > > in the body of a message to majordomo@vger.kernel.org
> > > More majordomo info at  http://vger.kernel.org/majordomo-info.html
> > > Please read the FAQ at  http://www.tux.org/lkml/
