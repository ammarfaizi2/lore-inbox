Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266573AbUHSQBi@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266573AbUHSQBi (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 19 Aug 2004 12:01:38 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266585AbUHSQBi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 19 Aug 2004 12:01:38 -0400
Received: from mion.elka.pw.edu.pl ([194.29.160.35]:9971 "EHLO
	mion.elka.pw.edu.pl") by vger.kernel.org with ESMTP id S266573AbUHSQBg
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 19 Aug 2004 12:01:36 -0400
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Date: Thu, 19 Aug 2004 18:00:56 +0200
User-Agent: KMail/1.6.2
Cc: Frank Steiner <fsteiner-mail@bio.ifi.lmu.de>,
       Joerg Schilling <schilling@fokus.fraunhofer.de>,
       kernel@wildsau.enemy.org, diablod3@gmail.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <200408041233.i74CX93f009939@wildsau.enemy.org> <4124BA10.6060602@bio.ifi.lmu.de> <1092925942.28353.5.camel@localhost.localdomain>
In-Reply-To: <1092925942.28353.5.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Disposition: inline
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <200408191800.56581.bzolnier@elka.pw.edu.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 19 August 2004 16:32, Alan Cox wrote:
> On Iau, 2004-08-19 at 15:32, Frank Steiner wrote:
> > What a stupid claim. When I call cdrecord on SuSE 9.1, I can burn CDs and
> > DVDs as normal user, without root permissions, without suid, without
> > ide-scsi, using /dev/hdc as device.
> >
> > And this just works fine. So where's the problem?
>
> You can also erase the drive firmware as a user etc. That's the problem.
> When you fix that cdrecord gets broken by the security fix if you are
> using the SG_IO interface. Patches are kicking around to try and sort
> things out so cd burning is safe as non-root. cdrecord works as root.
>
> As a security fix it was sufficiently important that it had to be done.

IMO work-rounding this in kernel is a bad idea and could break a lot of 
existing apps (some you even don't know about).  Much better way to deal with 
this is to create library for handling I/O commands submission and gradually 
teach user-space apps to use it.

Bartlomiej
