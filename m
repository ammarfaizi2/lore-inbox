Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261714AbVDWTLQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261714AbVDWTLQ (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 23 Apr 2005 15:11:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261720AbVDWTLP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 23 Apr 2005 15:11:15 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:32223 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261714AbVDWTLH
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 23 Apr 2005 15:11:07 -0400
Date: Sat, 23 Apr 2005 21:12:13 +0200
From: DervishD <lkml@dervishd.net>
To: Kyle Moffett <mrmacman_g4@mac.com>
Cc: dean gaudet <dean-list-linux-kernel@arctic.org>,
       Xin Zhao <uszhaoxin@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: Why Ext2/3 needs immutable attribute?
Message-ID: <20050423191213.GA505@DervishD>
Mail-Followup-To: Kyle Moffett <mrmacman_g4@mac.com>,
	dean gaudet <dean-list-linux-kernel@arctic.org>,
	Xin Zhao <uszhaoxin@gmail.com>, linux-kernel@vger.kernel.org
References: <4ae3c14050417085473bd365f@mail.gmail.com> <Pine.LNX.4.62.0504230947070.23658@twinlark.arctic.org> <4a5cc1ac18788e708f9a5f3a5bd31be0@mac.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4a5cc1ac18788e708f9a5f3a5bd31be0@mac.com>
User-Agent: Mutt/1.4.2.1i
Organization: DervishD
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - ns9.hostinglmi.net
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [0 0] / [47 12]
X-AntiAbuse: Sender Address Domain - dervishd.net
X-Source: 
X-Source-Args: 
X-Source-Dir: 
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Hi Kyle :)

 * Kyle Moffett <mrmacman_g4@mac.com> dixit:
> >another usage:  if you "chattr +i /var" while /var is unmounted,
> >then root is unlikely to accidentally create files/dirs in /var --
> >and when you mount the real /var on top it works fine.  i tend to
> >protect all my mount points this way (especially those in /mnt) to
> >avoid my own dumb mistakes.
> If you chmod 000 /var beforehand (While it's still unmounted, of
> course), then it's also blindingly obvious that it's not mounted in
> an ls -l :-D. I too have used this trick on many/most of my
> systems.

    I was doing exactly that, but it has its drawbacks: root still
can create files by accident. I've been hit by this a couple of
times :( For example, as root, I issue the mount command with a typo,
and before I can read the result of the command I've already typed a
'cp' or 'mv' command, 'sync' and 'umount'. Yes, I know, I should read
carefully what I type as root and the result of the commands, and I
do except when issuing harmless commands as 'cp' O:))) My fault, yes,
but it can be solved easily with the trick provided by Dean ;)

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736
http://www.dervishd.net & http://www.pleyades.net/
It's my PC and I'll cry if I want to...
