Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287334AbSACPr0>; Thu, 3 Jan 2002 10:47:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287325AbSACPrI>; Thu, 3 Jan 2002 10:47:08 -0500
Received: from ns.caldera.de ([212.34.180.1]:52695 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S287328AbSACPq3>;
	Thu, 3 Jan 2002 10:46:29 -0500
Date: Thu, 3 Jan 2002 16:45:55 +0100
Message-Id: <200201031545.g03Fjtj11546@ns.caldera.de>
From: Christoph Hellwig <hch@ns.caldera.de>
To: phillips@bonn-fries.net (Daniel Phillips)
Cc: acme@conectiva.com.br, linux-kernel@vger.kernel.org
Subject: Re: [CFT] [JANITORIAL] Unbork fs.h
X-Newsgroups: caldera.lists.linux.kernel
In-Reply-To: <E16M7Gz-00015E-00@starship.berlin>
User-Agent: tin/1.4.4-20000803 ("Vet for the Insane") (UNIX) (Linux/2.4.13 (i686))
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <E16M7Gz-00015E-00@starship.berlin> you wrote:
> -	inode = get_empty_inode();
> +	inode = get_empty_inode(sb);

How about killing get_empty_inode completly and using new_inode() instead?
There should be no regularly allocated inode without a superblock.

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
