Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S269395AbRHWRqL>; Thu, 23 Aug 2001 13:46:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S269417AbRHWRqB>; Thu, 23 Aug 2001 13:46:01 -0400
Received: from lightning.swansea.linux.org.uk ([194.168.151.1]:53256 "EHLO
	the-village.bc.nu") by vger.kernel.org with ESMTP
	id <S269395AbRHWRpq>; Thu, 23 Aug 2001 13:45:46 -0400
Subject: Re: Filling holes in ext2
To: adrian@humboldt.co.uk (Adrian Cox)
Date: Thu, 23 Aug 2001 18:47:54 +0100 (BST)
Cc: akpm@zip.com.au (Andrew Morton), linux-kernel@vger.kernel.org
In-Reply-To: <3B853BE6.3010703@humboldt.co.uk> from "Adrian Cox" at Aug 23, 2001 06:22:46 PM
X-Mailer: ELM [version 2.5 PL6]
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-Id: <E15ZyaA-0004Dz-00@the-village.bc.nu>
From: Alan Cox <alan@lxorguk.ukuu.org.uk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 3) lock the pages corresponding to the user buffer so that 
> __copy_from_user() cannot fail.
> 
> I like the latter option, as it removes this abort case for ext3 and 
> could drastically simplify GFS.

Neat elegant and fundamentally close to impossible to implement without
deadlocks.

There only seems to be a problem if prepare_write fills in the metadata. In
such cases the fs I think does need to implement abort operations
