Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268878AbUHUHgC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268878AbUHUHgC (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 21 Aug 2004 03:36:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268885AbUHUHgC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 21 Aug 2004 03:36:02 -0400
Received: from pop.gmx.de ([213.165.64.20]:42951 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S268878AbUHUHf7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 21 Aug 2004 03:35:59 -0400
X-Authenticated: #1725425
Date: Sat, 21 Aug 2004 09:49:55 +0200
From: Marc Ballarin <Ballarin.Marc@gmx.de>
To: David Greaves <david@dgreaves.com>
Cc: mrmacman_g4@mac.com, linux-kernel@vger.kernel.org,
       alan@lxorguk.ukuu.org.uk, fsteiner-mail@bio.ifi.lmu.de,
       kernel@wildsau.enemy.org, diablod3@gmail.com,
       B.Zolnierkiewicz@elka.pw.edu.pl
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
Message-Id: <20040821094955.3ab81037.Ballarin.Marc@gmx.de>
In-Reply-To: <4126F27B.9010107@dgreaves.com>
References: <200408041233.i74CX93f009939@wildsau.enemy.org>
	<4124BA10.6060602@bio.ifi.lmu.de>
	<1092925942.28353.5.camel@localhost.localdomain>
	<200408191800.56581.bzolnier@elka.pw.edu.pl>
	<4124D042.nail85A1E3BQ6@burner>
	<1092938348.28370.19.camel@localhost.localdomain>
	<4125FFA2.nail8LD61HFT4@burner>
	<101FDDA2-F2F5-11D8-8DEC-000393ACC76E@mac.com>
	<4126F27B.9010107@dgreaves.com>
X-Mailer: Sylpheed version 0.9.12 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 21 Aug 2004 07:58:03 +0100
David Greaves <david@dgreaves.com> wrote:

> Can someone explain why it isn't anyone with _write_ access to the
> device? Surely it's better to drop a user into a group or setgid a
> program?
> 
> If I have write access to a device then I can wipe it's media anyway.
> Is there something I'm missing?
> 

With RAW_IO access you cannot only wipe the media, but the entire
firmware (not only wipe it, but also upload a malicious version that will
screw up the entire SCSI or IDE bus).

Andreas Messer and I are working on an improved filter that works per
device and is configurable from userspace. It's not easy though.

Regards
