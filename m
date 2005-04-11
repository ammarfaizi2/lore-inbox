Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261967AbVDKWvy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261967AbVDKWvy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Apr 2005 18:51:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261975AbVDKWvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Apr 2005 18:51:54 -0400
Received: from w241.dkm.cz ([62.24.88.241]:31370 "HELO machine.sinus.cz")
	by vger.kernel.org with SMTP id S261967AbVDKWvo (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Apr 2005 18:51:44 -0400
Date: Tue, 12 Apr 2005 00:51:39 +0200
From: Petr Baudis <pasky@ucw.cz>
To: linux-kernel@vger.kernel.org
Subject: Re: Call to atention about using hash functions as content indexers (SCM saga)
Message-ID: <20050411225139.GA9145@pasky.ji.cz>
References: <20050411224021.GA25106@larroy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050411224021.GA25106@larroy.com>
User-Agent: Mutt/1.4i
X-message-flag: Outlook : A program to spread viri, but it can do mail too.
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dear diary, on Tue, Apr 12, 2005 at 12:40:21AM CEST, I got a letter
where Pedro Larroy <piotr@larroy.com> told me that...
> Hi

Hello,

> I had a quick look at the source of GIT tonight, I'd like to warn you
> about the use of hash functions as content indexers.
> 
> As probably you are aware, hash functions such as SHA-1 are surjective not
> bijective (1-to-1 map), so they have collisions. Here one can argue
> about the low probability of such a collision, I won't get into
> subjetive valorations of what probability of collision is tolerable for
> me and what is not. 
> 
> I my humble opinion, choosing deliberately, as a design decision, a
> method such as this one, that in some cases could corrupt data in a
> silent and very hard to detect way, is not very good. One can also argue
> that the probability of data getting corrupted in the disk, or whatever
> could be higher than that of the collision, again this is not valid
> comparison, since the fact that indexing by hash functions without
> additional checking could make data corruption legal between the
> reasonable working parameters of the program is very dangerous.

(i) 1461501637330902918203684832716283019655932542976 possible SHA1 hashes.

(ii) In git-pasky, there's (turnable off) detection of collisions.

(iii) Your argument against comparing with the probability of a hardware
error does not make sense to me.

(iv) You fail to propose a better solution.

-- 
				Petr "Pasky" Baudis
Stuff: http://pasky.or.cz/
98% of the time I am right. Why worry about the other 3%.
