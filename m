Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262075AbVCXUNW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262075AbVCXUNW (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Mar 2005 15:13:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262834AbVCXUNV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Mar 2005 15:13:21 -0500
Received: from smtpout.mac.com ([17.250.248.89]:2000 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S262075AbVCXUNQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Mar 2005 15:13:16 -0500
In-Reply-To: <d1v67l$4dv$1@terminus.zytor.com>
References: <Pine.LNX.4.61.0503221645560.25571@yvahk01.tjqt.qr> <20050323174925.GA3272@zero> <Pine.LNX.4.62.0503241855350.18295@numbat.sonytel.be> <20050324133628.196a4c41.Tommy.Reynolds@MegaCoder.com> <d1v67l$4dv$1@terminus.zytor.com>
Mime-Version: 1.0 (Apple Message framework v619.2)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <3e74c9409b6e383b7b398fe919418d54@mac.com>
Content-Transfer-Encoding: 7bit
Cc: linux-kernel@vger.kernel.org
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Squashfs without ./..
Date: Thu, 24 Mar 2005 15:13:08 -0500
To: hpa@zytor.com (H. Peter Anvin)
X-Mailer: Apple Mail (2.619.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Tommy Reynolds wrote:
> Then it is broken in several ways.
>
> First, file systems are not required to implement ".." (only "." is
> magical, ".." is a courtesy).

On Mar 24, 2005, at 14:59, H. Peter Anvin wrote:
> Doesn't have anything to do with sorting order or US-ASCII, it has to
> do with readdir order.  If nothing else, it would be highly surprising
> if "." and ".." weren't first; it's certainly a de facto standard, if
> not de jure.

IMHO, this is one of those cases where "Be liberal in what you accept
and strict in what you emit" applies strongly.  New filesystems should
probably always emit "." and ".." in that order with sane behavior,
and new programs should probably be able to handle it if they don't. I
would add ".." and "." to squashfs, just so that it acts like the rest
of the filesystems on the planet, even if it has to emulate them
internally.  OTOH, I think that the default behavior of find is broken
and should probably be fixed, maybe by making the default use the full
readdir and optionally allowing a -fast option that optimizes the
search using such tricks.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/U d- s++: a18 C++++>$ UB/L/X/*++++(+)>$ P+++(++++)>$
L++++(+++) E W++(+) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+
PGP+++ t+(+++) 5 X R? tv-(--) b++++(++) DI+ D+ G e->++++$ h!*()>++$ r  
!y?(-)
------END GEEK CODE BLOCK------


