Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265549AbTL3H0Z (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 30 Dec 2003 02:26:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265689AbTL3H0Z
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 30 Dec 2003 02:26:25 -0500
Received: from louise.pinerecords.com ([213.168.176.16]:35818 "EHLO
	louise.pinerecords.com") by vger.kernel.org with ESMTP
	id S265549AbTL3H0W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 30 Dec 2003 02:26:22 -0500
Date: Tue, 30 Dec 2003 08:26:20 +0100
From: Tomas Szepe <szepe@pinerecords.com>
To: BlaisorBlade <blaisorblade_spam@yahoo.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [NEW FEATURE]Partitions on loop device for 2.6
Message-ID: <20031230072620.GB1517@louise.pinerecords.com>
References: <200312241341.23523.blaisorblade_spam@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200312241341.23523.blaisorblade_spam@yahoo.it>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Dec-24 2003, Wed, 18:20 +0100
BlaisorBlade <blaisorblade_spam@yahoo.it> wrote:

Thanks for the patch.  Would you please inline it (instead
of attaching it) the next time you're sending one?

> 	if (register_blkdev(LOOP_MAJOR, "loop"))
> 		return -EIO;
> 
>+	if (register_blkdev(PLOOP_MAJOR, "ploop")) {
>+		ret = -EIO;
>+		goto out_noreg;
>+	}

Let's make these consistent.

>+	printk(KERN_INFO "loop: loaded (max %d not partitioned devices "
>+	    		 "and %d partitioned ones)\n", max_nopart_loop, max_part_loop);

... "%d regular loop devices and %d partitionable ones"

-- 
Tomas Szepe <szepe@pinerecords.com>
