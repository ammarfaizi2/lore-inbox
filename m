Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263340AbTDGI1e (for <rfc822;willy@w.ods.org>); Mon, 7 Apr 2003 04:27:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263341AbTDGI1e (for <rfc822;linux-kernel-outgoing>); Mon, 7 Apr 2003 04:27:34 -0400
Received: from [12.47.58.191] ([12.47.58.191]:65254 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S263340AbTDGI1d (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 7 Apr 2003 04:27:33 -0400
Date: Mon, 7 Apr 2003 01:39:03 -0700
From: Andrew Morton <akpm@digeo.com>
To: Christoph Hellwig <hch@infradead.org>
Cc: Nikita@Namesys.COM, dragon@gentoo.org, hch@lst.de,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remove kdevname() before someone starts using it again
Message-Id: <20030407013903.711d5927.akpm@digeo.com>
In-Reply-To: <20030407091923.B28879@infradead.org>
References: <20030331162634.A14319@lst.de>
	<3E908DF6.1050004@gentoo.org>
	<16017.11269.576246.373826@laputa.namesys.com>
	<20030407091923.B28879@infradead.org>
X-Mailer: Sylpheed version 0.8.9 (GTK+ 1.2.10; i586-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 07 Apr 2003 08:39:01.0232 (UTC) FILETIME=[23722700:01C2FCE1]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig <hch@infradead.org> wrote:
>
> partition_name()

That function would appear to be

a) slow

b) leaky

c) racy and

d) plain wrong if dev_t's can get recycled.

Can we at least give it a lock? :(

