Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751083AbVJBMIK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751083AbVJBMIK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 2 Oct 2005 08:08:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751085AbVJBMIK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 2 Oct 2005 08:08:10 -0400
Received: from mail.fh-wedel.de ([213.39.232.198]:15043 "EHLO
	moskovskaya.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1751083AbVJBMIJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 2 Oct 2005 08:08:09 -0400
Date: Sun, 2 Oct 2005 14:07:48 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: "Artem B. Bityutskiy" <dedekind@yandex.ru>
Cc: dsaxena@plexity.net, Linus Torvalds <torvalds@osdl.org>,
       linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] [MTD] kmalloc + memzero -> kzalloc conversion
Message-ID: <20051002120748.GA10697@wohnheim.fh-wedel.de>
References: <20051001050003.GD11137@plexity.net> <1128152797.3546.15.camel@sauron.oktetlabs.ru> <20051001080027.GM25424@plexity.net> <433E432B.7010406@yandex.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <433E432B.7010406@yandex.ru>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 1 October 2005 12:04:59 +0400, Artem B. Bityutskiy wrote:
> Deepak Saxena wrote:
> >I see it more as an API usage cleanup then a "fix" of any sort. 
> >
> Well, actually it may be helpful in only future, for example, if it is 
> known that the allocated memory is zero-filled already, memzero() may be 
> avoided at all.

Even today, kzalloc() takes less code than kmalloc() + memset().
Shrinks your binary size by a tiny amount.

Jörn

-- 
Mundie uses a textbook tactic of manipulation: start with some
reasonable talk, and lead the audience to an unreasonable conclusion.
-- Bruce Perens
