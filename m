Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267048AbTAUNKm>; Tue, 21 Jan 2003 08:10:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267049AbTAUNKm>; Tue, 21 Jan 2003 08:10:42 -0500
Received: from bay-bridge.veritas.com ([143.127.3.10]:32696 "EHLO
	mtvmime02.veritas.com") by vger.kernel.org with ESMTP
	id <S267048AbTAUNKl>; Tue, 21 Jan 2003 08:10:41 -0500
Date: Tue, 21 Jan 2003 13:21:14 +0000 (GMT)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Paul Gortmaker <p_gortmaker@yahoo.com>
cc: Alan Cox <alan@redhat.com>, <linux-kernel@vger.kernel.org>
Subject: Re: Linux 2.4.21-pre3-ac4 [PATCH]
In-Reply-To: <3E2D2BEA.2AC873DE@yahoo.com>
Message-ID: <Pine.LNX.4.44.0301211306550.1494-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 21 Jan 2003, Paul Gortmaker wrote:
> 
> Your compiler must really like you, seeing as it would barf on any 
> significant I/O here.  Somewhere along the line, somebody removed
> the INIT_LIST_HEAD for current->local_pages from fork.c and didn't
> put it back somewhere else (like INIT_TASK or whatever was in mind.)

Yes, I posted the same patch a couple of days ago.  We've now had
several confirmations (for which thanks) that it fixes __free_pages_ok
oops many were seeing in 2.4.21-pre3-ac.  (But the problem was in
allocating memory when low, rather than in significant I/O.)

Hugh

