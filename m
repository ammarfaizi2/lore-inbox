Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130481AbRCDLP0>; Sun, 4 Mar 2001 06:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130484AbRCDLPQ>; Sun, 4 Mar 2001 06:15:16 -0500
Received: from www.wen-online.de ([212.223.88.39]:59146 "EHLO wen-online.de")
	by vger.kernel.org with ESMTP id <S130481AbRCDLPE>;
	Sun, 4 Mar 2001 06:15:04 -0500
Date: Sun, 4 Mar 2001 12:14:31 +0100 (CET)
From: Mike Galbraith <mikeg@wen-online.de>
X-X-Sender: <mikeg@mikeg.weiden.de>
To: David <david@blue-labs.org>
cc: Rik van Riel <riel@conectiva.com.br>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
        Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [CFT] Re: 2.4 VM question
In-Reply-To: <3AA0CA2E.70208@blue-labs.org>
Message-ID: <Pine.LNX.4.33.0103041142410.1680-100000@mikeg.weiden.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 3 Mar 2001, David wrote:

> Is there a particular reason why 2.4 insists on stuffing as much as
> possible into swap?

Yes.. the VM is being tuned.  The latest changes result in overly
agressive caching with some work loads.

For people who are running into this, please edit mm/vmscan.c and
change DEF_PRIORITY from 6 to 2.  This change helps the performance
woes I see on my box quite a bit.  Report results to me (interested),
and the cc list (those who can ACT on it;) unless they say otherwise.

	-Mike

