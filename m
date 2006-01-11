Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751396AbWAKRR6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751396AbWAKRR6 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jan 2006 12:17:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWAKRR6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jan 2006 12:17:58 -0500
Received: from silver.veritas.com ([143.127.12.111]:8992 "EHLO
	silver.veritas.com") by vger.kernel.org with ESMTP id S1751396AbWAKRR5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jan 2006 12:17:57 -0500
Date: Wed, 11 Jan 2006 17:18:28 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@goblin.wat.veritas.com
To: Octavio Alvarez Piza <alvarezp@alvarezp.ods.org>
cc: Dave Jones <davej@redhat.com>, Arjan van de Ven <arjan@infradead.org>,
       Andrew Morton <akpm@osdl.org>, nickpiggin@yahoo.com.au,
       linux-kernel@vger.kernel.org
Subject: Re: mm/rmap.c negative page map count BUG.
In-Reply-To: <20060111085843.1d79e045@octavio.alvarezp.pri>
Message-ID: <Pine.LNX.4.61.0601111711510.5071@goblin.wat.veritas.com>
References: <20060103082609.GB11738@redhat.com> <43BA630F.1020805@yahoo.com.au>
 <20060103135312.GB18060@redhat.com> <20060104155326.351a9c01.akpm@osdl.org>
 <20060105074718.GF20809@redhat.com> <1136448712.2920.4.camel@laptopd505.fenrus.org>
 <20060105111520.GL20809@redhat.com> <op.s2w4pyqm4oyyg1@octavio.tecbc.mx>
 <20060111000111.5fa4bdce@octavio.alvarezp.pri>
 <Pine.LNX.4.61.0601111603520.4337@goblin.wat.veritas.com>
 <20060111085843.1d79e045@octavio.alvarezp.pri>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-OriginalArrivalTime: 11 Jan 2006 17:17:57.0070 (UTC) FILETIME=[F7117EE0:01C616D2]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 11 Jan 2006, Octavio Alvarez Piza wrote:
> 
> BTW, what's the first 8 in flags:0x80010008? I can't find 1<<31 in
> include/linux/page-flags.h

It's the zone that page belongs to (you won't, I think, get involved
in nodes and sections): see helpful comment on "page->flags layout"
in include/linux/mm.h, and definitions in include/linux/mmzone.h.

I'd have to make a fool of myself by doing arithmetic in public,
probably getting it wrong, to tell you precisely which zone the
8 meant in 2.6.15 in your config; but it's not interesting anyway.

Hugh
