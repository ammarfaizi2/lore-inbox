Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261894AbTAIIS7>; Thu, 9 Jan 2003 03:18:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261900AbTAIIS7>; Thu, 9 Jan 2003 03:18:59 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:46357 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S261894AbTAIIS7>; Thu, 9 Jan 2003 03:18:59 -0500
Date: Thu, 9 Jan 2003 08:29:00 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Andi Kleen <ak@suse.de>
cc: torvalds@transmeta.com, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] kallsyms off-by-one and sorting
In-Reply-To: <20030109064011.GA27152@wotan.suse.de>
Message-ID: <Pine.LNX.4.44.0301090824180.1610-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 9 Jan 2003, Andi Kleen wrote:
> On Thu, Jan 09, 2003 at 06:22:50AM +0000, Hugh Dickins wrote:
> > Beware of kksymoops reports on 2.5.55:
> > kallsyms was off-by-one, showing the preceding symbol name.  For
> > example, if best index 0, no string was copied into the namebuf.
> 
> Thanks. Wasn't it there before?

Not before 2.5.54: it was a consequence of the change from leaving
a pointer to the next name, to filling the buffer with the name -
it didn't fill with the next name, but left the previous name there.

Hugh

