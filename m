Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129276AbRBLSe5>; Mon, 12 Feb 2001 13:34:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129405AbRBLSeq>; Mon, 12 Feb 2001 13:34:46 -0500
Received: from e2.ny.us.ibm.com ([32.97.182.102]:32158 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S129276AbRBLSec>;
	Mon, 12 Feb 2001 13:34:32 -0500
Date: Mon, 12 Feb 2001 13:33:50 -0500 (EST)
From: Richard A Nelson <cowboy@vnet.ibm.com>
X-X-Sender: <cowboy@badlands.lexington.ibm.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.2.19pre10:x!
In-Reply-To: <E14SNMh-0007fo-00@the-village.bc.nu>
Message-ID: <Pine.LNX.4.33.0102121329410.22778-100000@badlands.lexington.ibm.com>
X-No-Markup: yes
x-No-ProductLinks: yes
x-No-Archive: yes
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 12 Feb 2001, Alan Cox wrote:

> > First, I'm glad I wasn't hallucinating, and that the mail did indeed get
> > seen by someone.
> >
> > Second, instead of reverting, can't we simply move those two lines up a
> > bit:
>
> Possibly but its a minor item that doesnt really matter anyway so leaving it
> is fine

Ah, but it does matter !  We break compatibility with other systems (and
our manpages, and possibly standards) if we don't mark the segment
IPC_PRIVATE upon removal -

Marking the segment IPC_PRIVATE allows its continued use by those alread
connected to the segment (until the count drops to zero, and its
deleted), but *prevents* new users from attaching to the segment.

I started down this road because we weren't marking the segment, was
delighted to see it done in pre3 - but it seemed like the setting
wasn't always done ;-{
-- 
Rick Nelson
Life'll kill ya                         -- Warren Zevon
Then you'll be dead                     -- Life'll kill ya

-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
Please read the FAQ at  http://vger.kernel.org/lkml/
