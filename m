Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265484AbSLINYd>; Mon, 9 Dec 2002 08:24:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265475AbSLINYd>; Mon, 9 Dec 2002 08:24:33 -0500
Received: from smtp03.uc3m.es ([163.117.136.123]:13584 "HELO smtp.uc3m.es")
	by vger.kernel.org with SMTP id <S265484AbSLINYc>;
	Mon, 9 Dec 2002 08:24:32 -0500
Date: Mon, 9 Dec 2002 14:31:58 +0100
Message-Id: <200212091331.gB9DVwn12198@oboe.it.uc3m.es>
From: "Peter T. Breuer" <ptb@it.uc3m.es>
To: Hugo Mills <hugo-lkml@carfax.org.uk>
Subject: Re: Need help recovering RAID array after admin error
X-Newsgroups: linux.kernel
In-Reply-To: <20021209120431.GB9768@mina.ecs.soton.ac.uk>
Cc: linux-kernel@vger.kernel.org
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.2.15 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <20021209120431.GB9768@mina.ecs.soton.ac.uk> you wrote:
>    Software RAID-5 does indeed protect against a disk failure.

Don't worry about it.  Remake the whole array with mkraid --force
--dangerous-no-resync.  Then mark the really failed disk or its
replacement  as faulty with raidsetfaulty.  Then take it out with
raidhotremove, then put it back wit raidhotadd. It'll be resynced
from the oter two.

>    Software RAID-5 doesn't protect against removing the wrong disk
> from the array after a disk failure. :(

Peter
