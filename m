Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265141AbUADWNp (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 4 Jan 2004 17:13:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265378AbUADWMQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jan 2004 17:12:16 -0500
Received: from fw.osdl.org ([65.172.181.6]:41883 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S265335AbUADWKq (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jan 2004 17:10:46 -0500
Date: Sun, 4 Jan 2004 14:10:30 -0800
From: Andrew Morton <akpm@osdl.org>
To: Mike Fedyk <mfedyk@matchmail.com>
Cc: ornati@lycos.it, gandalf@wlug.westbo.se, linuxram@us.ibm.com,
       linux-kernel@vger.kernel.org
Subject: Re: Buffer and Page cache coherent? was: Strange IDE performance
 change in 2.6.1-rc1 (again)
Message-Id: <20040104141030.02fbcce5.akpm@osdl.org>
In-Reply-To: <20040104171545.GR1882@matchmail.com>
References: <200401021658.41384.ornati@lycos.it>
	<20040102213228.GH1882@matchmail.com>
	<1073082842.824.5.camel@tux.rsn.bth.se>
	<200401031213.01353.ornati@lycos.it>
	<20040103144003.07cc10d9.akpm@osdl.org>
	<20040104171545.GR1882@matchmail.com>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mike Fedyk <mfedyk@matchmail.com> wrote:
>
> On Sat, Jan 03, 2004 at 02:40:03PM -0800, Andrew Morton wrote:
> > No effort was made to optimise buffered blockdev reads because it is not
> > very important and my main interest was in data coherency and filesystem
> > metadata consistency.
> 
> Does that mean that blockdev reads will populate the pagecache in 2.6?

They have since 2.4.10.  The pagecache is the only cacheing entity for file
(and blockdev) data.

