Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264856AbTFCBHB (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 21:07:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264859AbTFCBHB
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 21:07:01 -0400
Received: from pao-ex01.pao.digeo.com ([12.47.58.20]:8501 "EHLO
	pao-ex01.pao.digeo.com") by vger.kernel.org with ESMTP
	id S264856AbTFCBHA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 21:07:00 -0400
Date: Mon, 2 Jun 2003 18:20:39 -0700
From: Andrew Morton <akpm@digeo.com>
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, axboe@suse.de
Subject: Re: CFQ - 2.5.70-mm3 BUGs
Message-Id: <20030602182039.0673da0a.akpm@digeo.com>
In-Reply-To: <200306031113.49405.kernel@kolivas.org>
References: <200306031113.49405.kernel@kolivas.org>
X-Mailer: Sylpheed version 0.9.0pre1 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 03 Jun 2003 01:20:26.0769 (UTC) FILETIME=[50598010:01C3296E]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Con Kolivas <kernel@kolivas.org> wrote:
>
> I thought I'd give the cfq another run since some change has made it into this 
> patch and got these BUGs together (note, preempt enabled and UP +IDE):
> 
> ------------[ cut here ]------------
> kernel BUG at drivers/block/ll_rw_blk.c:1580!
> invalid operand: 0000 [#1]
> PREEMPT
> CPU:    0
> EIP:    0060:[<40257ff5>]    Not tainted VLI
> EFLAGS: 00010097
> EIP is at __blk_put_request+0x5d/0x108

That's

	BUG_ON(!list_empty(&req->queuelist));

I'm not aware of anyone testing CFQ much at present.
