Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311940AbSCXLe4>; Sun, 24 Mar 2002 06:34:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311960AbSCXLer>; Sun, 24 Mar 2002 06:34:47 -0500
Received: from ns.caldera.de ([212.34.180.1]:24495 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S311940AbSCXLed>;
	Sun, 24 Mar 2002 06:34:33 -0500
Date: Sun, 24 Mar 2002 12:34:14 +0100
From: Christoph Hellwig <hch@caldera.de>
To: linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc: velco@fadata.bg
Subject: [PATCH] updated radix-tree pagecache
Message-ID: <20020324123414.A12686@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>, linux-mm@kvack.org,
	linux-kernel@vger.kernel.org, velco@fadata.bg
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've just uploaded a new version of the radix-tree pagecache patch
to kernel.org.  This version should fix the OOPSens in the last 
version by beeing more carefull with the page->flags handling.

I have tested the 2.4 version under varying loads for about 20 hours
now and it seems stabel, the 2.5 version just got a compiles & boots,
I don't really trust 2.5 in this stage..

The only real difference between the two patches is the use of Ingo
Molnar's mempool interface in the 2.5 version, this is needed to not
deadlock under extreme loads.  If you want to have this with a 2.4-based
kernel you have to get a mempool backport from somewhere and just copy
lib/radix-tree.c from the 2.5 radix pagecache patch.

The patches are located at:

	ftp://ftp.kernel.org/pub/linux/kernel/people/hch/patches/v2.4/2.4.19-pre4/linux-2.4.19-radixpagecache.patch.gz
	ftp://ftp.kernel.org/pub/linux/kernel/people/hch/patches/v2.4/2.4.19-pre4/linux-2.4.19-radixpagecache.patch.bz2

	ftp://ftp.kernel.org/pub/linux/kernel/people/hch/patches/v2.5/2.5.7/linux-2.5.7-radixpagecache.patch.gz
	ftp://ftp.kernel.org/pub/linux/kernel/people/hch/patches/v2.5/2.5.7/linux-2.5.7-radixpagecache.patch.bz2

Please give them some beating so I can declare them ready for 2.5 when
Linus is back from vacation..

	Christoph

