Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261389AbVCYTAL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261389AbVCYTAL (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Mar 2005 14:00:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261229AbVCYTAL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Mar 2005 14:00:11 -0500
Received: from webmail.topspin.com ([12.162.17.3]:30437 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261227AbVCYTAH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Mar 2005 14:00:07 -0500
To: Adrian Bunk <bunk@stusta.de>
Cc: jgarzik@pobox.com, linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/net/at1700.c: at1700_probe1: array overflow
X-Message-Flag: Warning: May contain useful information
References: <20050325181836.GB3153@stusta.de>
From: Roland Dreier <roland@topspin.com>
Date: Fri, 25 Mar 2005 10:42:11 -0800
In-Reply-To: <20050325181836.GB3153@stusta.de> (Adrian Bunk's message of
 "Fri, 25 Mar 2005 19:18:36 +0100")
Message-ID: <528y4b7ekc.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 25 Mar 2005 18:42:11.0554 (UTC) FILETIME=[5B278C20:01C5316A]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    Adrian> This can result in indexing in an array with 8 entries the
    Adrian> 10th entry.

Well, not really, since the first 8 entries of the array have every
3-bit pattern.  So pos3 & 0x07 will always match one of them.

I agree it would be cleaner to make the loop only go up to 7 though.

 - R.
