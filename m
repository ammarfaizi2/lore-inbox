Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261948AbVDETsL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261948AbVDETsL (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Apr 2005 15:48:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261910AbVDETo5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Apr 2005 15:44:57 -0400
Received: from webmail.topspin.com ([12.162.17.3]:18782 "EHLO
	exch-1.topspincom.com") by vger.kernel.org with ESMTP
	id S261920AbVDETki (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Apr 2005 15:40:38 -0400
To: Jesper Juhl <juhl-lkml@dif.dk>
Cc: Paulo Marques <pmarques@grupopie.com>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: RFC: turn kmalloc+memset(,0,) into kcalloc
X-Message-Flag: Warning: May contain useful information
References: <4252BC37.8030306@grupopie.com>
	<Pine.LNX.4.62.0504052052230.2444@dragon.hyggekrogen.localhost>
From: Roland Dreier <roland@topspin.com>
Date: Tue, 05 Apr 2005 12:20:41 -0700
In-Reply-To: <Pine.LNX.4.62.0504052052230.2444@dragon.hyggekrogen.localhost> (Jesper
 Juhl's message of "Tue, 5 Apr 2005 20:54:07 +0200 (CEST)")
Message-ID: <521x9pc9o6.fsf@topspin.com>
User-Agent: Gnus/5.1006 (Gnus v5.10.6) XEmacs/21.4 (Jumbo Shrimp, linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-OriginalArrivalTime: 05 Apr 2005 19:20:41.0690 (UTC) FILETIME=[8EA593A0:01C53A14]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

    > or simply
    > 	if (!(ptr = kcalloc(n, size, ...)))
    > 		goto out;
    > and save an additional line of screen realestate while you are at it...

No, please don't do that.  The general kernel style is to avoid
assignments within conditionals.

 - R.
