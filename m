Return-Path: <linux-kernel-owner+w=401wt.eu-S965116AbXAGUPU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965116AbXAGUPU (ORCPT <rfc822;w@1wt.eu>);
	Sun, 7 Jan 2007 15:15:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965121AbXAGUPT
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Jan 2007 15:15:19 -0500
Received: from bayc1-pasmtp02.bayc1.hotmail.com ([65.54.191.162]:62322 "EHLO
	BAYC1-PASMTP02.CEZ.ICE" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S965116AbXAGUPR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Jan 2007 15:15:17 -0500
X-Originating-IP: [69.156.137.239]
X-Originating-Email: [seanlkml@sympatico.ca]
Date: Sun, 7 Jan 2007 15:15:14 -0500
From: Sean <seanlkml@sympatico.ca>
To: Dave Jones <davej@redhat.com>
Cc: Alan <alan@lxorguk.ukuu.org.uk>, David Woodhouse <dwmw2@infradead.org>,
       Tilman Schmidt <tilman@imap.cc>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       git@vger.kernel.org
Subject: Re: OT: character encodings (was: Linux 2.6.20-rc4)
Message-Id: <20070107151514.be9430b1.seanlkml@sympatico.ca>
In-Reply-To: <20070107200553.GA15101@redhat.com>
References: <Pine.LNX.4.64.0701062216210.3661@woody.osdl.org>
	<Pine.LNX.4.61.0701071152570.4365@yvahk01.tjqt.qr>
	<20070107114439.GC21613@flint.arm.linux.org.uk>
	<45A0F060.9090207@imap.cc>
	<1168182838.14763.24.camel@shinybook.infradead.org>
	<20070107153833.GA21133@flint.arm.linux.org.uk>
	<20070107182151.7cc544f3@localhost.localdomain>
	<20070107191730.GD21133@flint.arm.linux.org.uk>
	<20070107200553.GA15101@redhat.com>
X-Mailer: Sylpheed version 2.2.10 (GTK+ 2.10.4; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-OriginalArrivalTime: 07 Jan 2007 20:15:16.0307 (UTC) FILETIME=[8BABFA30:01C73298]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 7 Jan 2007 15:05:53 -0500
Dave Jones <davej@redhat.com> wrote:

Including the Git list...

> On Sun, Jan 07, 2007 at 07:17:30PM +0000, Russell King wrote:
> 
>  > commit 24ebead82bbf9785909d4cf205e2df5e9ff7da32
>  > tree 921f686860e918a01c3d3fb6cd106ba82bf4ace6
>  > parent 264166e604a7e14c278e31cadd1afb06a7d51a11
>  > author Rafa³ Bilski <rafalbilski@interia.pl> 1167691774 +0100
>  > committer Dave Jones <davej@redhat.com> 1167799119 -0500
>  > 
>  > and looking at that "author" closer with od:
>  > 
>  > 0000140 74 68 6f 72 20 52 61 66 61 b3 20 42 69 6c 73 6b
>  >           t   h   o   r       R   a   f   a   ³       B   i   l   s   k
>  > 
>  > clearly not UTF-8.  I doubt whether any of the commits I do on my
>  > en_GB ISO-8859-1 systems end up being UTF-8 encoded.
> 
> This has been bugging me for a while.
> Viewing the mail I applied in mutt shows his name correctly as Rafał
> Applying it with git-applymbox and viewing the log on master.kernel.org
> with git log shows Rafa<B3>   And then later when put into email
> it turns into Rafa³
> 
>  > But the point is there is charset damage which has happened _long_ before
>  > Linus' action.  There is no character set defined for the contents of git
>  > repositories, and as such the output of the git tools can not be
>  > interpreted as any one single character set.
> 
> If there's something I should be doing when I commit that I'm not,
> I'll be happy to change my scripts.  My $LANG is set to en_US.UTF-8
> which should DTRT to the best of my knowledge, but clearly, that isn't
> the case.

