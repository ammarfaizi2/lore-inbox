Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129881AbRBPOm3>; Fri, 16 Feb 2001 09:42:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129783AbRBPOmS>; Fri, 16 Feb 2001 09:42:18 -0500
Received: from horus.its.uow.edu.au ([130.130.68.25]:29434 "EHLO
	horus.its.uow.edu.au") by vger.kernel.org with ESMTP
	id <S129317AbRBPOmK>; Fri, 16 Feb 2001 09:42:10 -0500
Message-ID: <3A8D3E62.98F5AD6A@uow.edu.au>
Date: Sat, 17 Feb 2001 01:51:14 +1100
From: Andrew Morton <andrewm@uow.edu.au>
X-Mailer: Mozilla 4.7 [en] (X11; I; Linux 2.4.2-pre2 i586)
X-Accept-Language: en
MIME-Version: 1.0
To: Tom Sightler <ttsig@tuxyturvy.com>
CC: "Gord R. Lamb" <glamb@lcis.dyndns.org>, linux-kernel@vger.kernel.org
Subject: Re: Samba performance / zero-copy network I/O
In-Reply-To: <Pine.LNX.4.32.0102141548440.27843-100000@localhost.localdomain>,
		<Pine.LNX.4.32.0102141548440.27843-100000@localhost.localdomain> <982190431.3a8b095f4b3c4@eargle.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tom Sightler wrote:
> 
> My testing showed that the lowlatency patches abosolutely destroy a system
> thoughput under heavy disk IO.

I'm surprised - I've been keeping an eye on that.

Here's the result of a bunch of back-to-back `dbench 12' runs
on UP, alternating with and without LL:

With:
	58.725 total
	52.217 total
	51.935 total
	53.624 total
	39.815 total

Without:
	1:16.85 total
	52.525 total
	57.602 total
	41.623 total
	58.848 total

Results on reiserfs are similar.

-
