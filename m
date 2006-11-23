Return-Path: <linux-kernel-owner+willy=40w.ods.org-S933351AbWKWJMq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933351AbWKWJMq (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Nov 2006 04:12:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933356AbWKWJMq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Nov 2006 04:12:46 -0500
Received: from ns9.hostinglmi.net ([213.194.149.146]:26520 "EHLO
	ns9.hostinglmi.net") by vger.kernel.org with ESMTP id S933351AbWKWJMo
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Nov 2006 04:12:44 -0500
Date: Thu, 23 Nov 2006 10:13:01 +0100
From: DervishD <lkml@dervishd.net>
To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>
Cc: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
       The Peach <smartart@tiscali.it>, linux-kernel@vger.kernel.org
Subject: Re: [OT] Re: bug? VFAT copy problem
Message-ID: <20061123091301.GC21908@DervishD>
Mail-Followup-To: Sergio Monteiro Basto <sergio@sergiomb.no-ip.org>,
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>,
	The Peach <smartart@tiscali.it>, linux-kernel@vger.kernel.org
References: <20061120164209.04417252@localhost> <877ixqhvlw.fsf@duaron.myhome.or.jp> <20061120184912.5e1b1cac@localhost> <87mz6kajks.fsf@duaron.myhome.or.jp> <1164204175.10427.1.camel@localhost.localdomain> <20061122145344.GB18141@DervishD> <1164243385.3525.19.camel@monteirov>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <1164243385.3525.19.camel@monteirov>
User-Agent: Mutt/1.4.2.2i
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

    Hi Sérgio :)

 * Sergio Monteiro Basto <sergio@sergiomb.no-ip.org> dixit:
> On Wed, 2006-11-22 at 15:53 +0100, DervishD wrote:
> >  * Sergio Monteiro Basto <sergio@sergiomb.no-ip.org> dixit:
> > > Have vfat a limit of a file size when copy ? 
> > 
> >     2GB, if I recall correctly. FAT32 itself has a limit of 4GB-1 for
> > file size, but Linux restricts it even more (don't ask me why).
> 
> May I say that FAT32 have a bigger limit (at least on last Windows).

    I really don't know, but from microsoft technical information
(the first or second hit when googling for "FAT32 size limit"), the
limit they specify in FAT32 is 2^32-1.

    I may be wrong, but with 32 bits you cannot address more than
2^32 bytes, I don't know how can you create a bigger-than-4Gb file in
a FAT32 filesystem without resorting to tricks like this:

    forum.doom9.org/archive/index.php/t-20689.html

    Looks like FAT-32 (don't ask me how because I don't know the
internals) can store a file bigger than 4GB, but you cannot *save*
it. So you won't be able to put the file you have back to any FAT32
filesystem, I'm afraid.

> Have you a solution for the case ? Now I have the file in ext3 and
> I couldn't copy to any vfat :)

    No, I don't have any idea about how to do it, sorry :(

> I have a solution with cifs or smbmount, but in same computer ?

    I doubt. That limit is a hard limit as far as I know. Google for
"FAT32 limit" and you'll get a lot of answers telling it. I don't
really know how did you get a bigger than 4GB file saved in a FAT32
filesystem in the first place ;))

    Raúl Núñez de Arenas Coronado

-- 
Linux Registered User 88736 | http://www.dervishd.net
It's my PC and I'll cry if I want to... RAmen!
