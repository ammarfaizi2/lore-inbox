Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261373AbTDDXp7 (for <rfc822;willy@w.ods.org>); Fri, 4 Apr 2003 18:45:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261469AbTDDXp7 (for <rfc822;linux-kernel-outgoing>); Fri, 4 Apr 2003 18:45:59 -0500
Received: from [12.47.58.55] ([12.47.58.55]:5443 "EHLO pao-ex01.pao.digeo.com")
	by vger.kernel.org with ESMTP id S261373AbTDDXp6 (for <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 4 Apr 2003 18:45:58 -0500
Date: Fri, 4 Apr 2003 15:56:33 -0800
From: Andrew Morton <akpm@digeo.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Error whilst running "tune2fs -j"
Message-Id: <20030404155633.29ed6f8a.akpm@digeo.com>
In-Reply-To: <5880000.1049498738@flay>
References: <5880000.1049498738@flay>
X-Mailer: Sylpheed version 0.8.10 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 04 Apr 2003 23:57:22.0468 (UTC) FILETIME=[EF1A4640:01C2FB05]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Martin J. Bligh" <mbligh@aracnet.com> wrote:
>
> Anyone see this before? This was 2.5.65-mjb2 running on my laptop,
> at the start of a "tune2fs -j" ....
> 
> buffer layer error at fs/buffer.c:395

grrr.  This means that the block_dev layer somehow managed to get the
filesystem softblocksize confused.  There is something lurking in there.  As
usual, if I could reproduce it I could fix it.

Was the fs mounted at the time?

What version of e2fsprogs?

Can you reproduce it?

Thanks.
