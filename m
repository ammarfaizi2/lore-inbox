Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262355AbRG0VZG>; Fri, 27 Jul 2001 17:25:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262288AbRG0VY4>; Fri, 27 Jul 2001 17:24:56 -0400
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:32013 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S263748AbRG0VYk>; Fri, 27 Jul 2001 17:24:40 -0400
Subject: Re: Strange remount behaviour with ext3-2.4-0.9.4
To: cw@f00f.org (Chris Wedgwood)
Date: Fri, 27 Jul 2001 22:23:44 +0100 (BST)
Cc: alan@lxorguk.ukuu.org.uk (Alan Cox),
        michal@harddata.com (Michal Jaegermann), linux-kernel@vger.kernel.org
In-Reply-To: <20010728090836.B1625@weta.f00f.org> from "Chris Wedgwood" at Jul 28, 2001 09:08:36 AM
X-Mailer: ELM [version 2.5 PL5]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15QF5E-0006ZL-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org
Original-Recipient: rfc822;linux-kernel-outgoing

> more-or-less need need a tree-based fs and reference counting for all
> the magic bits).  In fact, doing it as the fs layer means you could
> have r/w snapshots with COW semantics.

You dont want r/w snapshots for archiving. An archive of a previous date is
worthless if it can't be absolutely utterly and definitively read only.

It is hard to do well, but its an important item. One possiiblity is to do
it by replaying the log to a r/w snapshot (in ram) over a r/o snapshot (on
stable media)
