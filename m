Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131595AbRCVEVB>; Wed, 21 Mar 2001 23:21:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131569AbRCVEUw>; Wed, 21 Mar 2001 23:20:52 -0500
Received: from obelix.hrz.tu-chemnitz.de ([134.109.132.55]:11692 "EHLO
	obelix.hrz.tu-chemnitz.de") by vger.kernel.org with ESMTP
	id <S131595AbRCVEUj>; Wed, 21 Mar 2001 23:20:39 -0500
Date: Thu, 22 Mar 2001 05:19:57 +0100
From: Ingo Oeser <ingo.oeser@informatik.tu-chemnitz.de>
To: linux-fsdevel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Subject: cramfs b0rken on HIGHMEM machines
Message-ID: <20010322051956.A11126@nightmaster.csn.tu-chemnitz.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi there,

just look at fs/cramfs/inode.c:cramfs_read_page()

It uses page_address instead of kmap().

I would have fixed it myself, but I don't know, how I should
kunmap() it, once we have memory pressure.

BTW: I bought an SMP machine with 1GB RAM yesterday to test such
   cases and found the first BUG now.

Yes I know, that nobody build embedded machines with HIGHMEM
support, but it's still a BUG right? ;-)

Regards

Ingo Oeser
-- 
10.+11.03.2001 - 3. Chemnitzer LinuxTag <http://www.tu-chemnitz.de/linux/tag>
         <<<<<<<<<<<<     been there and had much fun   >>>>>>>>>>>>
