Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287877AbSABRWT>; Wed, 2 Jan 2002 12:22:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287868AbSABRWK>; Wed, 2 Jan 2002 12:22:10 -0500
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:39179 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S287879AbSABRVz>; Wed, 2 Jan 2002 12:21:55 -0500
Subject: Re: [reiserfs-list] Re: reiserfs does not work with linux 2.4.17 on
To: zam@namesys.com (Alexander Zarochentcev)
Date: Wed, 2 Jan 2002 17:29:04 +0000 (GMT)
Cc: kernel@Expansa.sns.it (Luigi Genoni), reiser@namesys.com (Hans Reiser),
        Nikita@namesys.com (Nikita Danilov), linux-kernel@vger.kernel.org,
        Reiserfs-List@namesys.com (Reiserfs mail-list)
In-Reply-To: <15411.1131.936970.188735@backtop.namesys.com> from "Alexander Zarochentcev" at Jan 02, 2002 04:00:27 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E16LpCK-0004oY-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> As I guess, the problem is that sparc64's set_bit() does not like addresses
> which are not aligned on 8-byte boundary. New `s_properties' field of reiserfs
> specific part of super block is such kind of.

set_bit is defined for long. The fix is definitely right - without it you'll
scribble on other memory on any 64bit BE platform
