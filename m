Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263069AbTDFUVV (for <rfc822;willy@w.ods.org>); Sun, 6 Apr 2003 16:21:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263070AbTDFUVV (for <rfc822;linux-kernel-outgoing>); Sun, 6 Apr 2003 16:21:21 -0400
Received: from chiba.3jane.net ([64.57.168.198]:54192 "EHLO chiba.3jane.net")
	by vger.kernel.org with ESMTP id S263069AbTDFUVU (for <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 6 Apr 2003 16:21:20 -0400
Message-ID: <3E908DF6.1050004@gentoo.org>
Date: Sun, 06 Apr 2003 16:28:38 -0400
From: Nicholas Wourms <dragon@gentoo.org>
User-Agent: Mozilla/5.0 (Windows; U; Win 9x 4.90; en-US; rv:1.0.2) Gecko/20030208 Netscape/7.02
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@lst.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove kdevname() before someone starts using it again
References: <20030331162634.A14319@lst.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> --- 1.14/fs/libfs.c	Wed Jan  1 02:18:35 2003
> +++ edited/fs/libfs.c	Wed Mar 26 21:32:02 2003
> @@ -332,14 +332,3 @@
>  	set_page_dirty(page);
>  	return 0;

A quick grep shows that Intermezzo FS still uses kdevname if 
you've turned on debugging (fs/intermezzo/sysctl.c).  As for 
pending stuff, both Reiser4 & pktcdvd also use it.  So I 
guess people are still using it...  What is your reason for 
removing it?

Cheers,
Nicholas

