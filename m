Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313606AbSDURDy>; Sun, 21 Apr 2002 13:03:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313610AbSDURDx>; Sun, 21 Apr 2002 13:03:53 -0400
Received: from 167.imtp.Ilyichevsk.Odessa.UA ([195.66.192.167]:12051 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S313606AbSDURDx>; Sun, 21 Apr 2002 13:03:53 -0400
Message-Id: <200204211701.g3LH1DX09067@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain;
  charset="us-ascii"
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Mark Hahn <hahn@physics.mcmaster.ca>
Subject: Re: /proc/stat weirdness
Date: Sun, 21 Apr 2002 20:04:23 -0200
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0204211103060.21092-100000@coffee.psychology.mcmaster.ca>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 21 April 2002 13:04, Mark Hahn wrote:
> > I was curious about top showing unwieldy numbers for idle%
> > (start top, hold down [space] and you'll see).
>
> you need to be more explicit.  unweildy?  do you mean
> very large?

Yes, stuff like 1231687123,23%

> > top reads /proc/stat in order to get these percents.
> > A little script which cats /proc/stat continually
> > and greps for 'cpu  ' yield:
> > cpu  39778 0 46829 337191
> > cpu  39778 0 46831 337192
> > cpu  39778 0 46833 337193
> > cpu  39778 0 46834 337194
> > cpu  39778 0 46835 337195
> > cpu  39778 0 46836 337196
> > cpu  39778 0 46838 337197 <<<
> > cpu  39778 0 46840 337196 <<<
>
> your clock jumped back; do you have a via-based computer?

Nope. It's a HP Vectra, a loyal Intel based box.
Right now I ssh'ed to my NFS server, ran top and held [space] down.
I saw it there too. What do you see on your box?

I modified top to show 'raw' counter difference too:
0000001b 00000014 00000000 000001cb   5.3% user,  3.9% system,  0.0% nice, 90.7% idle
^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^
and it's easy to notice that last number turns into ffffffff sometimes.
--
vda
