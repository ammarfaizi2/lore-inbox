Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S271043AbTHCHns (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Aug 2003 03:43:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S271069AbTHCHnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Aug 2003 03:43:17 -0400
Received: from us01smtp1.synopsys.com ([198.182.44.79]:62874 "EHLO
	boden.synopsys.com") by vger.kernel.org with ESMTP id S271043AbTHCHnQ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Aug 2003 03:43:16 -0400
Message-ID: <3F2CBD0C.4040603@Synopsys.COM>
Date: Sun, 03 Aug 2003 09:43:08 +0200
From: Harald Dunkel <harri@synopsys.COM>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Oleg Drokin <green@linuxhacker.ru>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.0-test2: crash in reiserfs at shutdown
References: <3F2B9823.7010503@Synopsys.COM> <200308030649.h736nbcj013727@car.linuxhacker.ru>
In-Reply-To: <200308030649.h736nbcj013727@car.linuxhacker.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Oleg Drokin wrote:
> Hello!
> 
> Harald Dunkel <harri@synopsys.com> wrote:
> 
> HD> Final words are
> HD>         kernel BUG at fs/reiserfs/prints.c: 339
> 
> There should be one line prior to that.
> This line explains what went wrong in reiserfs opinion.
> Can you please say us what was the line?
> 
It said

	unmounting local filesystems... bio too big device sdc1 (8 > 0)
	bio too big device sdc1 (8 > 0)
	journal - 601, buffer write failed
	--- cut here ---
	kernel BUG at fs/reiserfs/prints.c: 339
	:

To me the problem seems that the USB stuff is shutdown
without unmounting the external USB disk first. Later, at
the "unmounting all disks" step in the shutdown procedure
the USB storage device can't be accessed anymore.


Regards

Harri

