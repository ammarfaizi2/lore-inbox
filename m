Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266666AbUHVLrN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266666AbUHVLrN (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 07:47:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266669AbUHVLrN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 07:47:13 -0400
Received: from the-village.bc.nu ([81.2.110.252]:33166 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S266666AbUHVLrM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 07:47:12 -0400
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
To: David Greaves <david@dgreaves.com>
Cc: Marc Ballarin <Ballarin.Marc@gmx.de>, mrmacman_g4@mac.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fsteiner-mail@bio.ifi.lmu.de, kernel@wildsau.enemy.org,
       diablod3@gmail.com,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
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
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Message-Id: <1093171467.24341.22.camel@localhost.localdomain>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Sun, 22 Aug 2004 11:44:37 +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sad, 2004-08-21 at 10:04, David Greaves wrote:
> So, the real point: principle of least privilege.
> Why root? why not set[gu]id cdwriters?

It requires CAP_SYS_RAWIO, because that is the level of access it gives.
How you do the capability management is a user space issue.

