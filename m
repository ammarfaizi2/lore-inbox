Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268030AbUHVRJZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268030AbUHVRJZ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 22 Aug 2004 13:09:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268032AbUHVRJZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 22 Aug 2004 13:09:25 -0400
Received: from pils.us-lot.org ([212.67.207.13]:53257 "EHLO pils.us-lot.org")
	by vger.kernel.org with ESMTP id S268030AbUHVRJX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 22 Aug 2004 13:09:23 -0400
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: David Greaves <david@dgreaves.com>, Marc Ballarin <Ballarin.Marc@gmx.de>,
       mrmacman_g4@mac.com,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       fsteiner-mail@bio.ifi.lmu.de, kernel@wildsau.enemy.org,
       diablod3@gmail.com,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
Subject: Re: PATCH: cdrecord: avoiding scsi device numbering for ide devices
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
	<1093171467.24341.22.camel@localhost.localdomain>
From: Adam Sampson <azz@us-lot.org>
Organization: Things I did not know at first I learned by doing twice.
Date: Sun, 22 Aug 2004 18:09:17 +0100
In-Reply-To: <1093171467.24341.22.camel@localhost.localdomain> (Alan Cox's
 message of "Sun, 22 Aug 2004 11:44:37 +0100")
Message-ID: <y2a657bhzgi.fsf@cartman.at.fivegeeks.net>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Security Through
 Obscurity, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox <alan@lxorguk.ukuu.org.uk> writes:

> It requires CAP_SYS_RAWIO, because that is the level of access it gives.

That seems like a reasonable requirement, but would it be possible to
do the capability check at open() time, rather than when the operation
is performed? That would be more consistent with how conventional
permissions checks on files/devices work, and would avoid breaking
privilege-dropping applications.

I don't really want to run my CD-writing tool with CAP_SYS_RAWIO all
the time -- if it's got a security hole that a malicious CD image can
exploit, then I'd rather it were just able to damage the CD drive than
the rest of the system...

Thanks,

-- 
Adam Sampson <azz@us-lot.org>                        <http://offog.org/>
