Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291235AbSBGT3x>; Thu, 7 Feb 2002 14:29:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291231AbSBGT3n>; Thu, 7 Feb 2002 14:29:43 -0500
Received: from mx2.elte.hu ([157.181.151.9]:25578 "HELO mx2.elte.hu")
	by vger.kernel.org with SMTP id <S291167AbSBGT30>;
	Thu, 7 Feb 2002 14:29:26 -0500
Date: Thu, 7 Feb 2002 22:27:14 +0100 (CET)
From: Ingo Molnar <mingo@elte.hu>
Reply-To: <mingo@elte.hu>
To: Andrew Morton <akpm@zip.com.au>
Cc: Robert Love <rml@tech9.net>, Martin Wirth <Martin.Wirth@dlr.de>,
        linux-kernel <linux-kernel@vger.kernel.org>, nigel <nigel@nrg.org>
Subject: Re: [RFC] New locking primitive for 2.5
In-Reply-To: <3C62D49A.4CBB6295@zip.com.au>
Message-ID: <Pine.LNX.4.33.0202072226100.447-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 7 Feb 2002, Andrew Morton wrote:

> Quite a few.  Significant ones.  pagemap_lru_lock and lru_list_lock
> come to mind.

ugh. Are you sure we want to *sleep* with something like pagemap_lru_lock
held? That pretty much brings all pagecache related operations to a
grinding halt. I think complex spinlocked sections should be simplified
rather.

	Ingo

