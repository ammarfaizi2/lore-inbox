Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261728AbULDQGV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261728AbULDQGV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 11:06:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261730AbULDQGV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 11:06:21 -0500
Received: from vsmtp1.tin.it ([212.216.176.141]:60038 "EHLO vsmtp1.tin.it")
	by vger.kernel.org with ESMTP id S261728AbULDQGS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 11:06:18 -0500
Date: Sat, 4 Dec 2004 14:05:01 +0100
From: Giuliano Pochini <pochini@shiny.it>
To: Jens Axboe <axboe@suse.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Time sliced CFQ io scheduler
Message-Id: <20041204140501.52fddd94.pochini@shiny.it>
In-Reply-To: <20041202144129.GI10458@suse.de>
References: <20041202130457.GC10458@suse.de>
	<Pine.LNX.4.58.0412021517070.3471@denise.shiny.it>
	<20041202144129.GI10458@suse.de>
X-Mailer: Sylpheed version 0.9.6 (GTK+ 1.2.10; powerpc-unknown-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2 Dec 2004 15:41:34 +0100
Jens Axboe <axboe@suse.de> wrote:

> > > Case 4: write_files, random, bs=4k
> >
> > Just a thought... in this test the results don't look right. Why
> > aggregate bandwidth with 8 clients is higher than with 4 and 2 clients ?
> > In the cfq test with 8 clients aggregate bw is also higher than with
> > a single client.
>
> I don't know what happens with the 4 client case, but it's not that
> unlikely that aggregate bandwidth will be higher for more threads doing
> random writes, as request coalesching will help minimize seeks.

In order to keep the probabilty that requests get coalesced constant, the
size of the test file should be multiple of the number of clients.


--
Giuliano.
