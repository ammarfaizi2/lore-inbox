Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129589AbRBUVdC>; Wed, 21 Feb 2001 16:33:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129685AbRBUVcu>; Wed, 21 Feb 2001 16:32:50 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:60426 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id <S129589AbRBUVcj>; Wed, 21 Feb 2001 16:32:39 -0500
Date: Wed, 21 Feb 2001 22:32:38 +0100
From: Martin Mares <mj@suse.cz>
To: Davide Libenzi <davidel@xmailserver.org>
Cc: Linux-kernel@vger.kernel.org, tytso@valinux.com,
        Andreas Dilger <adilger@turbolinux.com>, hch@ns.caldera.de,
        ext2-devel@lists.sourceforge.net,
        Daniel Phillips <phillips@innominate.de>
Subject: Re: [rfc] Near-constant time directory index for Ext2
Message-ID: <20010221223238.A17903@atrey.karlin.mff.cuni.cz>
In-Reply-To: <20010221220835.A8781@atrey.karlin.mff.cuni.cz> <XFMail.20010221132959.davidel@xmailserver.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.12i
In-Reply-To: <XFMail.20010221132959.davidel@xmailserver.org>; from davidel@xmailserver.org on Wed, Feb 21, 2001 at 01:29:59PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

> To have O(1) you've to have the number of hash entries > number of files and a
> really good hasing function.

No, if you enlarge the hash table twice (and re-hash everything) every time the
table fills up, the load factor of the table keeps small and everything is O(1)
amortized, of course if you have a good hashing function. If you are really
smart and re-hash incrementally, you can get O(1) worst case complexity, but
the multiplicative constant is large.

> To be sincere, here is pretty daylight :)

:)
								Martin
