Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265812AbUAEAXK (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 19:23:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265815AbUAEAXK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 19:23:10 -0500
Received: from fw.osdl.org ([65.172.181.6]:19688 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265812AbUAEAXI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 19:23:08 -0500
Date: Sun, 4 Jan 2004 16:23:01 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: ornati@lycos.it, gandalf@wlug.westbo.se, linuxram@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: Buffer and Page cache coherent? was: Strange IDE performance
 change in 2.6.1-rc1 (again)
Message-Id: <20040104162301.5c113246.akpm@osdl.org>
In-Reply-To: <20040104234523.GX1882@matchmail.com>
References: <200401021658.41384.ornati@lycos.it>
	<20040102213228.GH1882@matchmail.com>
	<1073082842.824.5.camel@tux.rsn.bth.se>
	<200401031213.01353.ornati@lycos.it>
	<20040103144003.07cc10d9.akpm@osdl.org>
	<20040104171545.GR1882@matchmail.com>
	<20040104141030.02fbcce5.akpm@osdl.org>
	<20040104232231.GV1882@matchmail.com>
	<20040104153258.0408a197.akpm@osdl.org>
	<20040104234523.GX1882@matchmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> wrote:
>
> So in what way is the buffer cache coherent with the pagecache?
> 

There is no "buffer cache" in Linux.  There is a pagecache for /etc/passwd
and there is a pagecache for /dev/hda1.  They are treated pretty much
identically.  The kernel attaches buffer_heads to those pagecache pages
when needed - generally when it wants to deal with individual disk blocks.

>  Any progress on that pagecache coherent block relocation patch you had for
>  ext3? :)

No.
