Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S130059AbRBUWP0>; Wed, 21 Feb 2001 17:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S130141AbRBUWPI>; Wed, 21 Feb 2001 17:15:08 -0500
Received: from neon-gw.transmeta.com ([209.10.217.66]:46599 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S130059AbRBUWOz>; Wed, 21 Feb 2001 17:14:55 -0500
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: [rfc] Near-constant time directory index for Ext2
Date: 21 Feb 2001 14:14:20 -0800
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <971ejs$139$1@cesium.transmeta.com>
In-Reply-To: <20010221220835.A8781@atrey.karlin.mff.cuni.cz> <XFMail.20010221132959.davidel@xmailserver.org> <20010221223238.A17903@atrey.karlin.mff.cuni.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2001 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <20010221223238.A17903@atrey.karlin.mff.cuni.cz>
By author:    Martin Mares <mj@suse.cz>
In newsgroup: linux.dev.kernel
>
> Hello!
> 
> > To have O(1) you've to have the number of hash entries > number of files and a
> > really good hasing function.
> 
> No, if you enlarge the hash table twice (and re-hash everything) every time the
> table fills up, the load factor of the table keeps small and everything is O(1)
> amortized, of course if you have a good hashing function. If you are really
> smart and re-hash incrementally, you can get O(1) worst case complexity, but
> the multiplicative constant is large.
> 

Not true.  The rehashing is O(n) and it has to be performed O(log n)
times during insertion.  Therefore, insertion is O(log n).

	-hpa
-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
http://www.zytor.com/~hpa/puzzle.txt
