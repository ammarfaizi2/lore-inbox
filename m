Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262124AbUC1RY0 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Mar 2004 12:24:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262080AbUC1RY0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Mar 2004 12:24:26 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:22228 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S262063AbUC1RYX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Mar 2004 12:24:23 -0500
Message-ID: <40670A36.3000005@pobox.com>
Date: Sun, 28 Mar 2004 12:24:06 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jamie Lokier <jamie@shareable.org>
CC: Nick Piggin <nickpiggin@yahoo.com.au>, linux-ide@vger.kernel.org,
       Linux Kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] speed up SATA
References: <4066021A.20308@pobox.com> <40661049.1050004@yahoo.com.au> <406611CA.3050804@pobox.com> <406616EE.80301@pobox.com> <4066191E.4040702@yahoo.com.au> <40662108.40705@pobox.com> <20040328135124.GA32597@mail.shareable.org>
In-Reply-To: <20040328135124.GA32597@mail.shareable.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jamie Lokier wrote:
> Jeff Garzik wrote:
> 
>>TCQ-on-write for ATA disks is yummy because you don't really know what 
>>the heck the ATA disk is writing at the present time.  By the time the 
>>Linux disk scheduler gets around to deciding it has a nicely merged and 
>>scheduled set of requests, it may be totally wrong for the disk's IO 
>>scheduler.  TCQ gives the disk a lot more power when the disk integrates 
>>writes into its internal IO scheduling.
> 
> 
> Does TCQ-on-write allow you to do ordered write commits, as with barriers,
> but without needing full cache flushes, and still get good performance?

Nope, TCQ is just a bunch of commands rather than one.  There are no 
special barrier indicators you can pass down with a command.

	Jeff




