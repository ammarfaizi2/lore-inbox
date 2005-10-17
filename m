Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932308AbVJQUs6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932308AbVJQUs6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Oct 2005 16:48:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932313AbVJQUs5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Oct 2005 16:48:57 -0400
Received: from cpu1185.adsl.bellglobal.com ([207.236.110.166]:13266 "EHLO
	mail.rtr.ca") by vger.kernel.org with ESMTP id S932308AbVJQUs5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Oct 2005 16:48:57 -0400
Message-ID: <43540E38.9060408@rtr.ca>
Date: Mon, 17 Oct 2005 16:48:56 -0400
From: Mark Lord <lkml@rtr.ca>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.12) Gecko/20050923 Debian/1.7.12-0ubuntu05.04
X-Accept-Language: en, en-us
MIME-Version: 1.0
To: "J.A. Magallon" <jamagallon@able.es>
Cc: "Linux-Kernel, " <linux-kernel@vger.kernel.org>
Subject: Re: hdparm almost burned my SATA disk
References: <20051016010153.768d29d5@werewolf.able.es>
In-Reply-To: <20051016010153.768d29d5@werewolf.able.es>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

J.A. Magallon wrote:
>
> I was trying hdparm -tT on a SATA disk, it did the buffered part OK,
> and hanged my box in the non-buffered measure. After waiting some minutes,
> I did a SysRQ-s-u-b, and the the disk began to give many read errors on
> sectors and could not boot because journal was not present and many other
> errors.
> 
> After some warm and cold boots, finally the box came up correctly.
> I suspect that something that hdparm did left my disk dumb. But what ?

Nope.  hdparm simply does a bunch of read() system calls to fetch
data from the drive, same as any other code might do it.

I think you should use the smartmontools to check the drive error logs
and find out what REALLY happened there.

-ml
