Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316360AbSETU1b>; Mon, 20 May 2002 16:27:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316361AbSETU1a>; Mon, 20 May 2002 16:27:30 -0400
Received: from astound-64-85-224-253.ca.astound.net ([64.85.224.253]:43271
	"EHLO master.linux-ide.org") by vger.kernel.org with ESMTP
	id <S316360AbSETU13>; Mon, 20 May 2002 16:27:29 -0400
Date: Mon, 20 May 2002 13:26:34 -0700 (PDT)
From: Andre Hedrick <andre@linux-ide.org>
To: Gunther Mayer <gunther.mayer@gmx.net>
cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] IDE PIO write Fix #2
In-Reply-To: <3CE89C2F.20ED671B@gmx.net>
Message-ID: <Pine.LNX.4.10.10205201257070.8582-100000@master.linux-ide.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 20 May 2002, Gunther Mayer wrote:

> Hi Andre,
> 
> 1)
> I follow your arguments regarding BUSY_STAT handled earlier.
> 
> 2)
> Can you explain, why the code looks at  "rq->current_nr_sectors==1" ?
> In ATA-4 there is no special handling for "single-sector-transfer" or
> "last-sector-transfer".

There is a test just not clearly stated, "data block transferred".
It is hidden in the state diagram in the transition states.
Since there is no accounting process in the driver, as it has been
exported to block because of partial completions and page walking.

But obviously most people question my proven judgement on how things work,
so I expect this to be ignored by the masses on lkml.  However you I
expect to see the point and issues.

Cheers,

Andre Hedrick
LAD Storage Consulting Group

