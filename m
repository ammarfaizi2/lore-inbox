Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266204AbUITKwG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266204AbUITKwG (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 20 Sep 2004 06:52:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266208AbUITKwG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 20 Sep 2004 06:52:06 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:15044 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S266204AbUITKwB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 20 Sep 2004 06:52:01 -0400
Date: Mon, 20 Sep 2004 12:54:09 +0200
From: DervishD <lkml@dervishd.net>
To: Andreas Schwab <schwab@suse.de>
Cc: Olaf Hering <olh@suse.de>, Andries.Brouwer@cwi.nl,
       linux-kernel@vger.kernel.org
Subject: Re: OOM & [OT] util-linux-2.12e
Message-ID: <20040920105409.GH5482@DervishD>
Mail-Followup-To: Andreas Schwab <schwab@suse.de>,
	Olaf Hering <olh@suse.de>, Andries.Brouwer@cwi.nl,
	linux-kernel@vger.kernel.org
References: <UTC200409192205.i8JM52C25370.aeb@smtp.cwi.nl> <20040920094602.GA24466@suse.de> <jeoek1xn9p.fsf@sykes.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <jeoek1xn9p.fsf@sykes.suse.de>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-PopBeforeSMTPSenders: raul@dervishd.net
X-MailScanner-Information: Please contact the ISP for more information
X-MailScanner: Found to be clean
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Andreas :)

 * Andreas Schwab <schwab@suse.de> dixit:
> > - fix all broken apps that still rely on mtab. like GNU df(1)
> df does not rely on /etc/mtab.  It relies on getmntent.

    Then my GNU df has any problem :???

    $ df --version

df (coreutils) 5.2.1
Written by Torbjorn Granlund, David MacKenzie, and Paul Eggert.

Copyright (C) 2004 Free Software Foundation, Inc.
This is free software; see the source for copying conditions.  There is NO
warranty; not even for MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.

    $ mv /etc/mtab /etc/nomtab
    $ df
df: cannot read table of mounted filesystems: No such file or directory

    $ mv /etc/nomtab /etc/mtab
    $ df
Filesystem           1K-blocks      Used Available Use% Mounted on
/dev/root             78106388  58601124  19505264  76% /
tmpfs                    32768         0     32768   0% /dev/shm
/dev/backup           19530636  15707348   3823288  81% /var/backup

    IMHO, it depeds on mtab. Maybe it is configurable thru
'./configure' at build time?

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.pleyades.net & http://raul.pleyades.net/
