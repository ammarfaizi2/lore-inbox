Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131882AbRDMVJS>; Fri, 13 Apr 2001 17:09:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131878AbRDMVJI>; Fri, 13 Apr 2001 17:09:08 -0400
Received: from m90-mp1-cvx1a.col.ntl.com ([213.104.68.90]:22145 "EHLO
	[213.104.68.90]") by vger.kernel.org with ESMTP id <S131873AbRDMVIy>;
	Fri, 13 Apr 2001 17:08:54 -0400
To: "Adam J. Richter" <adam@yggdrasil.com>
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>
Subject: Re: PATCH(?): linux-2.4.4-pre2: fork should run child first
In-Reply-To: <20010412015516.A335@baldur.yggdrasil.com>
From: John Fremlin <chief@bandits.org>
Date: 13 Apr 2001 22:08:33 +0100
In-Reply-To: "Adam J. Richter"'s message of "Thu, 12 Apr 2001 01:55:16 -0700"
Message-ID: <m2bsq0se26.fsf@boreas.yi.org.>
User-Agent: Gnus/5.0807 (Gnus v5.8.7) XEmacs/21.1 (GTK)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 "Adam J. Richter" <adam@yggdrasil.com> writes:

[...]

> 	It turned out that the particular unix-like system on which
> these benchmarks were taken had a version of fork that did not run
> the child first.  As it was explained to me then, most of the time,
> the child process from a fork will do just a few things and then do
> an exec(), releasing its copy-on-write references to the parent's
> pages, and that is the big win of copy-on-write for fork() in practice.
> This oversight was considered a big embarassment for the operating
> system in question, so I won't name it here.
> 
> 	Guess why you're seeing this email.  That's right.  Linux-2.4.3's
> fork() does not run the child first.

Not always, if I understand correctly. Setting to always is putting
policy in kernel in a small way. If an app wants to fork and exec, it
should use *vfork* and exec, which is a performance win across many
OSs because the COW mappings don't even have to be set up, IIRC.

[...]

-- 

	http://www.penguinpowered.com/~vii
