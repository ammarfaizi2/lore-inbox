Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261459AbULIGhC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261459AbULIGhC (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Dec 2004 01:37:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261460AbULIGhC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Dec 2004 01:37:02 -0500
Received: from THUNK.ORG ([69.25.196.29]:52101 "EHLO thunker.thunk.org")
	by vger.kernel.org with ESMTP id S261459AbULIGg7 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Dec 2004 01:36:59 -0500
Date: Thu, 9 Dec 2004 01:36:54 -0500
From: "Theodore Ts'o" <tytso@mit.edu>
To: David Lang <dlang@digitalinsight.com>
Cc: Bernard Normier <bernard@zeroc.com>, linux-kernel@vger.kernel.org
Subject: Re: Concurrent access to /dev/urandom
Message-ID: <20041209063654.GA9324@thunk.org>
Mail-Followup-To: Theodore Ts'o <tytso@mit.edu>,
	David Lang <dlang@digitalinsight.com>,
	Bernard Normier <bernard@zeroc.com>, linux-kernel@vger.kernel.org
References: <006001c4d4c2$14470880$6400a8c0@centrino> <Pine.LNX.4.53.0411272154560.6045@yvahk01.tjqt.qr> <009501c4d4c6$40b4f270$6400a8c0@centrino> <Pine.LNX.4.53.0411272220530.26852@yvahk01.tjqt.qr> <02c001c4d58c$f6476bb0$6400a8c0@centrino> <06a501c4dcb6$3cb80cf0$6401a8c0@centrino> <20041208012802.GA6293@thunk.org> <079001c4dcc9$1bec3a60$6401a8c0@centrino> <Pine.LNX.4.60.0412081905140.17193@dlang.diginsite.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.60.0412081905140.17193@dlang.diginsite.com>
User-Agent: Mutt/1.5.6+20040907i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2004 at 07:10:16PM -0800, David Lang wrote:
> 
> pulling data from /dev/random or /dev/urandom will not ensure that you 
> don't have duplicates.
> 
> remember the birthday paradox. it says that if you get a group of 26 
> people in a room you have about a 50% chance that two of these people have 
> the same birthday.
> 
> now that's only with numbers in the range of 1-365 if you pull 16 bit 
> numbers (1-65536) you will need a much larger group to see the problem, 
> but if you pull enough you WILL see the problem eventually.

Yes, but a UUID is 128 bits.  So the chance of a collision is 1 in
2**62.  (There are 4 version/type bits, so there are 122 bits of
randomness in a type-4, randomly generated UUID).  Assuming a
correctly working random number generator, yes, it's possible that you
could get a duplicate.  It's also possible that all of the oxygen
molecules could suddenly randomly end up in the other part of the
room, and you would suffocate.  But it's not very likely.  2**62 is a
rather large number....

						- Ted
