Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263626AbTDTQZY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 12:25:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263627AbTDTQZY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 12:25:24 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:28032 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263626AbTDTQZX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 12:25:23 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304201640.h3KGeTs6000657@81-2-122-30.bradfords.org.uk>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Sun, 20 Apr 2003 17:40:29 +0100 (BST)
Cc: josh@stack.nl (Jos Hulzink), alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030420180720.099b4c34.skraw@ithnet.com> from "Stephan von Krawczynski" at Apr 20, 2003 06:07:20 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> > Fault tolerance in a filesystem layer means in practical terms
> > that you are guessing what a filesystem should look like, for the
> > disk doesn't answer that question anymore. IMHO you don't want
> > that to be done automagically, for it might go right sometimes,
> > but also might trash everything on RW filesystems.
> 
> Let me clarify again: I don't want fancy stuff inside the filesystem that
> magically knows something about right-or-wrong. The only _very small_
> enhancement I would like to see is: driver tells fs there is an error while
> writing a certain block => fs tries writing the same data onto another block.
> That's it, no magic, no RAID stuff. Very simple.

That doesn't belong in the filesystem.

Imagine you have ten blocks free, and you allocate data to all of them
in the filesystem.  The write goes to cache, and succeeds.

30 seconds later, the write cache is flushed, and an error is reported
back from the device.

John.
