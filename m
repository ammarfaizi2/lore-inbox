Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263639AbTDTQ5y (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 12:57:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263642AbTDTQ5y
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 12:57:54 -0400
Received: from 81-2-122-30.bradfords.org.uk ([81.2.122.30]:32128 "EHLO
	81-2-122-30.bradfords.org.uk") by vger.kernel.org with ESMTP
	id S263639AbTDTQ5w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 12:57:52 -0400
From: John Bradford <john@grabjohn.com>
Message-Id: <200304201712.h3KHCsBu000709@81-2-122-30.bradfords.org.uk>
Subject: Re: Are linux-fs's drive-fault-tolerant by concept?
To: skraw@ithnet.com (Stephan von Krawczynski)
Date: Sun, 20 Apr 2003 18:12:54 +0100 (BST)
Cc: john@grabjohn.com (John Bradford), alan@lxorguk.ukuu.org.uk,
       linux-kernel@vger.kernel.org
In-Reply-To: <20030420185512.763df745.skraw@ithnet.com> from "Stephan von Krawczynski" at Apr 20, 2003 06:55:12 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> On Sun, 20 Apr 2003 14:59:00 +0100 (BST)
> John Bradford <john@grabjohn.com> wrote:
> 
> > > Ok, you mean active error-recovery on reading. My basic point is the
> > > writing case. A simple handling of write-errors from the drivers level and
> > > a retry to write on a different location could help a lot I guess.
> > 
> > A filesystem is not the place for that - it could either be done at a
> > lower level, like I suggested in a separate post, or at a much higher
> > level - E.G. a database which encounters a write error could dump it's
> > entire contents to a tape drive, shuts down, and page an
> > administrator, on the basis that the write error indicated impending
> > drive failiure.
> 
> Can you tell me what is so particularly bad about the idea to cope a
> little bit with braindead (or just-dying) hardware?

Nothing - what is wrong is to implement it in a filesystem, where it
does not belong.

> See, a car (to name a real good example) is not primarily built to have
> accidents.

Stunt cars are built to survive accidents.  All cars _could_ be built
like stunt cars, but they aren't.

> Anyway everybody might agree that having a safety belt built into it
> is a good idea, just to make the best out of a bad situation - even
> if it never happens - , or not?

Exactly, that is why most modern hard disks retry on write failiure.

John.
