Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269296AbUH0JY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269296AbUH0JY1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Aug 2004 05:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269385AbUH0JVA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Aug 2004 05:21:00 -0400
Received: from denise.shiny.it ([194.20.232.1]:8652 "EHLO denise.shiny.it")
	by vger.kernel.org with ESMTP id S269315AbUH0JTO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Aug 2004 05:19:14 -0400
Message-ID: <XFMail.20040827111855.pochini@shiny.it>
X-Mailer: XFMail 1.4.7 on Linux
X-Priority: 3 (Normal)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
MIME-Version: 1.0
In-Reply-To: <Pine.LNX.4.58.0408260919380.2304@ppc970.osdl.org>
Date: Fri, 27 Aug 2004 11:18:55 +0200 (CEST)
From: Giuliano Pochini <pochini@shiny.it>
To: Linus Torvalds <torvalds@osdl.org>
Subject: Re: silent semantic changes with reiser4
Cc: ReiserFS List <reiserfs-list@namesys.com>, linux-kernel@vger.kernel.org,
       linux-fsdevel@vger.kernel.org, Hans Reiser <reiser@namesys.com>,
       Jamie Lokier <jamie@shareable.org>, Christoph Hellwig <hch@lst.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 26-Aug-2004 Linus Torvalds wrote:

> I advocated (long ago) something like this for /dev handling, just because
> I think it would make sense to have
>
>       /dev/hda        <- special file
>       /dev/hda/part1  <- partition 1 (aka /dev/hda1)

This breaks the r4 semantics if I understood it correctly. Because
/partN are not simply associated to the file, they are part of the
file. ie. when I modify /dev/hda I also change /dev/hda/partN and
vice-versa. I don't see any pratical problem, though.


> Still, I really do like the idea of merging the notion of file and
> directory into one notion of "container". I absolutely _detest_ files with
> internal structure that tools have to know about (ie I hate seeing all
> those embedded formats that I can't use "grep" on - MIME being one case).
> I'd much rather see a "group of files"  and a "file with a grouping of
> information".

You're actually looking for a database with a legacy fs-like interface :)


--
Giuliano.
