Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267523AbUHULSk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267523AbUHULSk (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 07:18:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267534AbUHULSk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 07:18:40 -0400
Received: from imap.gmx.net ([213.165.64.20]:6377 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S267523AbUHULSe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 07:18:34 -0400
X-Authenticated: #1725425
Date: Sat, 21 Aug 2004 13:19:27 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: David Greaves <david@dgreaves.com>
Cc: mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, fsteiner-mail@bio.ifi.lmu.de,
       kernel@wildsau.enemy.org, diablod3@gmail.com,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-Id: <20040821131927.37875e31.Ballarin.Marc@gmx.de>
In-Reply-To: <41271026.8030905@dgreaves.com>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
	<4124BA10.6060602@bio.ifi.lmu.de>
	<1092925942.28353.5.camel@localhost.localdomain>
	<200408191800.56581.bzolnier@elka.pw.edu.pl>
	<4124D042.nail85A1E3BQ6@burner>
	<1092938348.28370.19.camel@localhost.localdomain>
	<4125FFA2.nail8LD61HFT4@burner>
	<101FDDA2-F2F5-11D8-8DEC-000393ACC76E@mac.com>
	<4126F27B.9010107@dgreaves.com>
	<20040821094955.3ab81037.Ballarin.Marc@gmx.de>
	<41271026.8030905@dgreaves.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2004 10:04:38 +0100
David Greaves <david@dgreaves.com> wrote:

> Thanks - I get that :)
> 
> The 'write' point is that from a data perspective you've already lost 
> your data (which is the most valuable thing from a security
> perspective). I agree it's nice to give people write access to hardware
> and not let them melt it permanently. However, if the semantics don't
> allow 'safe' writing then prevent all user writing and use setgid for
> safe programs (which is essentially what you are doing anyway) to allow
> users to write.
> 

That's basically my idea. By default CAP_SYS_RAWIO is needed to issue any
comand. This will work fine if the software has been adjusted accordingly
*and* there is a software for the desired purpose.

However, there are cases where users have to be granted read or write
access to devices (databases, strange hardware, co-admins). In this cases,
the admin should be able to allow certain SCSI commands even for non-root
users.

Regards
