Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262310AbVCOIY2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262310AbVCOIY2 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 15 Mar 2005 03:24:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262340AbVCOIY2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 15 Mar 2005 03:24:28 -0500
Received: from [194.29.160.5] ([194.29.160.5]:55705 "EHLO higgs.elka.pw.edu.pl")
	by vger.kernel.org with ESMTP id S262310AbVCOIYX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 15 Mar 2005 03:24:23 -0500
Date: Tue, 15 Mar 2005 09:19:08 +0100 (CET)
From: Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: Paul <set@pobox.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Repeatable IDE Oops for 2.6.11 (ide-scsi vs ide-cdrom)
In-Reply-To: <1110822016.15927.136.camel@localhost.localdomain>
Message-ID: <Pine.GSO.4.62.0503150911540.17649@mion.elka.pw.edu.pl>
References: <20050314065508.GA7974@squish.home.loc>
 <1110822016.15927.136.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Mon, 14 Mar 2005, Alan Cox wrote:

> On Llu, 2005-03-14 at 06:55, Paul wrote:
>> # cat driver
>>> ide-cdrom version 4.61
>> # echo ide-scsi > driver
>> # cat driver
>
> This has always been unsafe. Its something I suggested was removed a
> long time ago because the locking for it is unfixable.

Locking is fixed in ide-dev-2.6 tree
(at the moment seem to be dropped from -mm?).

[ the FIXME comment left in ide-proc.c is also applicable to
   modprobe/rmmod case as the issue is not /proc/.../driver specific ]
