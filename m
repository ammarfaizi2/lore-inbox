Return-Path: <linux-kernel-owner+willy=40w.ods.org-S968636AbWLETE1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S968636AbWLETE1 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Dec 2006 14:04:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S968633AbWLETE1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Dec 2006 14:04:27 -0500
Received: from mailer.gwdg.de ([134.76.10.26]:35112 "EHLO mailer.gwdg.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S967880AbWLETE0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Dec 2006 14:04:26 -0500
Date: Tue, 5 Dec 2006 20:02:32 +0100 (MET)
From: Jan Engelhardt <jengelh@linux01.gwdg.de>
To: Linus Torvalds <torvalds@osdl.org>
cc: Matthew Wilcox <matthew@wil.cx>, linux-arch@vger.kernel.org,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Centralise definitions of sector_t and blkcnt_t
In-Reply-To: <Pine.LNX.4.64.0612041941220.3476@woody.osdl.org>
Message-ID: <Pine.LNX.4.61.0612051958550.18570@yvahk01.tjqt.qr>
References: <20061204103830.GA3013@parisc-linux.org>
 <Pine.LNX.4.64.0612041941220.3476@woody.osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Spam-Report: Content analysis: 0.0 points, 6.0 required
	_SUMMARY_
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On Dec 4 2006 19:44, Linus Torvalds wrote:
>
>[...]allow even 64-bit architectures to say that they only want 32-bit 
>sector_t's and page indexes [...]
>
>I don't know how big a deal it is, but I could imagine that we could 
>actually save memory in a smaller "struct page", for example, on 64bit 
>architectures by just using a 4-byte index.
>
>For now, the !64BIT makes sense simply because a 64-bit architecture 
>probably doesn't care, and might as well just use 64 bits anyway (ie you 
>tend to have tons of memory there anyway). And I suspect it doesn't 
>actually even help on 64-bits due to structure alignment etc issues, but 
>am too lazy to go check.

sparc could benefit from this (someone go correct me if I am wrong).
Not only in struct sizes, but maybe also a little in execution time.


	-`J'
-- 
