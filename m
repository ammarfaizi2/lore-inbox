Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132010AbRCVMMW>; Thu, 22 Mar 2001 07:12:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132011AbRCVMMN>; Thu, 22 Mar 2001 07:12:13 -0500
Received: from router-100M.swansea.linux.org.uk ([194.168.151.17]:14598 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S132009AbRCVMMA>; Thu, 22 Mar 2001 07:12:00 -0500
Subject: Re: cramfs b0rken on HIGHMEM machines
To: ingo.oeser@informatik.tu-chemnitz.de (Ingo Oeser)
Date: Thu, 22 Mar 2001 12:13:42 +0000 (GMT)
Cc: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
In-Reply-To: <20010322051956.A11126@nightmaster.csn.tu-chemnitz.de> from "Ingo Oeser" at Mar 22, 2001 05:19:57 AM
X-Mailer: ELM [version 2.5 PL1]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E14g3yL-0002Pa-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> just look at fs/cramfs/inode.c:cramfs_read_page()
> It uses page_address instead of kmap().
> 
> I would have fixed it myself, but I don't know, how I should
> kunmap() it, once we have memory pressure.

Take a look at ramfs. kmap isnt really a 'pressure' thing. You want to kunmap
the page as soon as you can. The kmap/unmap operations are fairly fast but
there is a limited pool of maps.

Alan

