Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964828AbWA0Hn6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964828AbWA0Hn6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 02:43:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964829AbWA0Hn6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 02:43:58 -0500
Received: from rwcrmhc11.comcast.net ([204.127.192.81]:152 "EHLO
	rwcrmhc11.comcast.net") by vger.kernel.org with ESMTP
	id S964828AbWA0Hn5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 02:43:57 -0500
Message-ID: <43D9CF3C.9070706@namesys.com>
Date: Thu, 26 Jan 2006 23:43:56 -0800
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.5) Gecko/20041217
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Edward Shishkin <edward@namesys.com>
CC: Jens Axboe <axboe@suse.de>, LKML <linux-kernel@vger.kernel.org>,
       Reiserfs mail-list <Reiserfs-List@namesys.com>
Subject: Re: random minor benchmark: Re: Copy 20 tarfiles: ext2 vs (reiser4,
 unixfile) vs (reiser4,cryptcompress)
References: <43D7C6BE.1010804@namesys.com> <43D7CA7F.4010502@namesys.com> <20060126153343.GH4311@suse.de> <43D91225.3030605@namesys.com> <20060126185612.GM4311@suse.de> <43D933EB.6080009@namesys.com>
In-Reply-To: <43D933EB.6080009@namesys.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Edward Shishkin wrote:

>
> I guess this is because real compression is going in background
> flush, not in sys_write->write_cryptcompress (which just copies
> user's data to page cache). So in this case we have something
> very similar to ext2. Reiser4 plain write (write_unix_file) is
> more complex, and currently we try to reduce its sys time.
>
> Edward.
>
>
>
>
Which means that only real time is a meaningful measurement.....
