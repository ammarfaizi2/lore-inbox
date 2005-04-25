Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262645AbVDYPik@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262645AbVDYPik (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 11:38:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262644AbVDYPhm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 11:37:42 -0400
Received: from dgate1.fujitsu-siemens.com ([217.115.66.35]:62556 "EHLO
	dgate1.fujitsu-siemens.com") by vger.kernel.org with ESMTP
	id S262663AbVDYPQH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 11:16:07 -0400
X-SBRSScore: None
X-IronPort-AV: i="3.92,128,1112565600"; 
   d="scan'208"; a="8120509:sNHT21714024"
Message-ID: <426D09AF.6030209@fujitsu-siemens.com>
Date: Mon, 25 Apr 2005 17:15:59 +0200
From: Bodo Stroesser <bstroesser@fujitsu-siemens.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Blaisorblade <blaisorblade@yahoo.it>
CC: akpm@osdl.org, jdike@addtoit.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: [patch 0/7] uml: some invasive changes for -mm
References: <200504242039.57025.blaisorblade@yahoo.it>
In-Reply-To: <200504242039.57025.blaisorblade@yahoo.it>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Blaisorblade wrote:
> This is the first of a series of 7 invasive patches for the -mm tree, which 
> are to be reviewed (not only by UML folks), and possibly merged for the 
> 2.6.13 cycle.
> 
> The first one splits the i386 syscall table out of entry.S, without any real 
> change for them (the file is included in the old place); if there are any 
> syscall table changes, please be careful; this maybe means place *this* one 
> before the others (or even merge now the i386 code movement part); I don't 
> want that this patch is modified and that subtle bugs are introduced. The 
> code movement is a really trivial code movement, however (no hidden changes).
> 
> This is needed to enable us to include the i386 syscall table, so that we are 
> sure that they match. I already handled the real differences between i386 and 
> UML (see the patch).
I love this idea and it fits well to UML/s390, where syscall table already
lives in a separate source.
As change and grow of syscall tables is not really coordinated between different
arches, this change will simplify maintenance of UML-subarches a lot.

		Bodo
