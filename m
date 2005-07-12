Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261560AbVGLReb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261560AbVGLReb (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 13:34:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261781AbVGLRea
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 13:34:30 -0400
Received: from ns9.hostinglmi.net ([213.194.149.146]:29349 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S261560AbVGLRe3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 13:34:29 -0400
Date: Tue, 12 Jul 2005 19:37:21 +0200
From: DervishD <lkml@dervishd.net>
To: Konstantin Kudin <konstantin_kudin@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: fdisk: What do plus signs after "Blocks" mean?
Message-ID: <20050712173721.GA325@DervishD>
Mail-Followup-To: Konstantin Kudin <konstantin_kudin@yahoo.com>,
	linux-kernel@vger.kernel.org
References: <20050712163514.42322.qmail@web52013.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20050712163514.42322.qmail@web52013.mail.yahoo.com>
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

    Hi Konstantin :)

 * Konstantin Kudin <konstantin_kudin@yahoo.com> dixit:
>  Can anyone enlighten me what the pluses mean?

    It is commented in the README.fdisk file in util-linux
distribution: the '+' flag means that the partition has an odd number
of sectors. That means that you can waste a sector at the end of the
partition, and it's very common for the first partition in the disk
if it ends on a cylinder boundary and cylinders have an even number
of sectors, due to the MBR.

    Harmless.

> Also, if a partition loses pluses after "Blocks", would that
> destroy a RAID array?

    I don't have any idea :? To reproduce a '+' in a partition, you
probably have to specify partition size in sectors (or kilobytes,
whatever fits you better) and make it odd, honoring exactly the
number of sectors that partition had (before the parttable was
destroyed by our dear friend XP).

    It's a good idea to have a copy of the partition table around, if
it is not simple (the one you had is NOT simple).

    Hope that helps.

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
http://www.pleyades.net & http://www.gotesdelluna.net
It's my PC and I'll cry if I want to...
