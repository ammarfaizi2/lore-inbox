Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316047AbSE3Jfg>; Thu, 30 May 2002 05:35:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316488AbSE3Jff>; Thu, 30 May 2002 05:35:35 -0400
Received: from tartu.cyber.ee ([193.40.6.68]:30220 "EHLO tartu.cyber.ee")
	by vger.kernel.org with ESMTP id <S316047AbSE3Jfe>;
	Thu, 30 May 2002 05:35:34 -0400
From: Meelis Roos <mroos@linux.ee>
To: linux-kernel@vger.kernel.org
Subject: Re: Linux 2.4.19-pre9
In-Reply-To: <20020529232525.GE3174@werewolf.able.es>
User-Agent: tin/1.5.12-20020227 ("Toxicity") (UNIX) (Linux/2.4.18 (i586))
Message-Id: <E17DMKl-0002tW-00@roos.tartu-labor>
Date: Thu, 30 May 2002 12:35:03 +0300
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

JAM> I still have some small fixes collected from the list, that if really
JAM> needed should be included in final...
JAM> Can anybody say if they still are valid (they apply fine on -pre9):

JAM> ********************** 01-fs-pagemap:
JAM> --- linux-2.4.19-pre7-jam1/fs/partitions/check.h.orig   2002-04-16 17:22:33.000000000 +0200
JAM> +++ linux-2.4.19-pre7-jam1/fs/partitions/check.h        2002-04-16 17:23:08.000000000 +0200
JAM> @@ -2,6 +2,9 @@
JAM>   * add_partition adds a partitions details to the devices partition
JAM>   * description.
JAM>   */
JAM> +
JAM> +#include <linux/pagemap.h>
JAM> +
JAM>  void add_gd_partition(struct gendisk *hd, int minor, int start, int size);
JAM>  
JAM>  typedef struct {struct page *v;} Sector;

This chunk is not needed anymore, Marcelo fixed it differently (including
pagemap.h from acorn.c IIRC). Fixed in pre9, I tested it.

-- 
Meelis Roos (mroos@linux.ee)
