Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262070AbTJFV1L (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 17:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262071AbTJFV1K
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 17:27:10 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:52377 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262070AbTJFV1H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 17:27:07 -0400
Message-ID: <3F81DE1D.6070304@pobox.com>
Date: Mon, 06 Oct 2003 17:26:53 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Daniel B." <dsb@smart.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: IDE DMA errors, massive disk corruption: Why? Fixed Yet? Why
 not  re-do failed op?
References: <785F348679A4D5119A0C009027DE33C105CDB20A@mcoexc04.mlm.maxtor.com>	            <3F81CE9A.851806B8@smart.net> <200310062045.h96KjxJP008005@turing-police.cc.vt.edu> <3F81D995.D9C13F33@smart.net>
In-Reply-To: <3F81D995.D9C13F33@smart.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel B. wrote:
> If the kernel starts a write command for block 993, wouldn't it wait
> for a DMA interrupt signalling that the drive has received and accepted
> the command before the kernel starts the write command for block 10934?

With command queueing, no, it would not wait.


> If it timed out waiting for that interrupt, can't it re-issue the
> write for block 993 before proceeding?

Assuming a large amount of sanity in your OS driver... certainly.

	Jeff



