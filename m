Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S318115AbSH1RNP>; Wed, 28 Aug 2002 13:13:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S318166AbSH1RNP>; Wed, 28 Aug 2002 13:13:15 -0400
Received: from dsl-213-023-022-149.arcor-ip.net ([213.23.22.149]:51145 "EHLO
	starship") by vger.kernel.org with ESMTP id <S318115AbSH1RNP>;
	Wed, 28 Aug 2002 13:13:15 -0400
Content-Type: text/plain; charset=US-ASCII
From: Daniel Phillips <phillips@arcor.de>
To: "Christian Ehrhardt" <ehrhardt@mathematik.uni-ulm.de>
Subject: Re: MM patches against 2.5.31
Date: Wed, 28 Aug 2002 19:18:52 +0200
X-Mailer: KMail [version 1.3.2]
Cc: Andrew Morton <akpm@zip.com.au>, lkml <linux-kernel@vger.kernel.org>,
       "linux-mm@kvack.org" <linux-mm@kvack.org>
References: <3D644C70.6D100EA5@zip.com.au> <E17jjWN-0002fo-00@starship> <20020828131445.25959.qmail@thales.mathematik.uni-ulm.de>
In-Reply-To: <20020828131445.25959.qmail@thales.mathematik.uni-ulm.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <E17k6Sy-0002s6-00@starship>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 28 August 2002 15:14, Christian Ehrhardt wrote:
> Side note: The BUG in __pagevec_lru_del seems strange. refill_inactive
> or shrink_cache could have removed the page from the lru before
> __pagevec_lru_del acquired the lru lock.

It's suspect all right.  If there's a chain of assumptions that proves
the page is always on the lru at the point, I haven't seen it yet.

-- 
Daniel
