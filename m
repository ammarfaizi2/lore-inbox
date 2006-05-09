Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750763AbWEIQaq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750763AbWEIQaq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 9 May 2006 12:30:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750822AbWEIQaq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 9 May 2006 12:30:46 -0400
Received: from wohnheim.fh-wedel.de ([213.39.233.138]:63402 "EHLO
	wohnheim.fh-wedel.de") by vger.kernel.org with ESMTP
	id S1750763AbWEIQag (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 9 May 2006 12:30:36 -0400
Date: Tue, 9 May 2006 18:27:15 +0200
From: =?iso-8859-1?Q?J=F6rn?= Engel <joern@wohnheim.fh-wedel.de>
To: Arjan van de Ven <arjan@linux.intel.com>
Cc: Andrew Morton <akpm@osdl.org>, bunk@stusta.de,
       linux-kernel@vger.kernel.org
Subject: Re: [patch 1/17] Infrastructure to mark exported symbols as unused-for-removal-soon
Message-ID: <20060509162715.GA10435@wohnheim.fh-wedel.de>
References: <1146581587.32045.41.camel@laptopd505.fenrus.org> <20060509090202.2f209f32.akpm@osdl.org> <4460BF8C.1050803@linux.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <4460BF8C.1050803@linux.intel.com>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2006 18:13:00 +0200, Arjan van de Ven wrote:
> Andrew Morton wrote:
> >So hum.  Don't you think it'd be better to look at each API as a whole,
> >make decisions about what parts of it _should_ be offered to modules,
> >rather then looking empirically at which parts presently _need_ to be
> >exported?
> 
> So I think personally it's worth biting the bullet. I expect 95% of those 
> 900 to
> never ever come back. Those 5% will churn, sure. But, to a large degree, 
> the fact
> that there's no user is an indication that the API may well not be right in 
> the
> first place, or not in demand.

[ Your mailer... ]

Rusty once pointed out that Linux doesn't ever implement complete
interfaces like students are usually told to do.  Instead, only
functions that are actually used are implemented.  Among other things,
this makes sure that implemented code is actually tested and works as
advertised.  Unused code, on the other hand, tends to bitrot.

Well, maybe Rusty was wrong and I shouldn't have listened.  But his
points made a lot of sense back then.  Who knows, it might still make
sense.

Jörn

-- 
This above all: to thine own self be true.
-- Shakespeare
