Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264668AbUJETag@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264668AbUJETag (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 5 Oct 2004 15:30:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265395AbUJETag
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 5 Oct 2004 15:30:36 -0400
Received: from batleth.sapienti-sat.org ([83.137.98.96]:211 "EHLO
	batleth.sapienti-sat.org") by vger.kernel.org with ESMTP
	id S264668AbUJETaV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 5 Oct 2004 15:30:21 -0400
Message-ID: <4162F643.4000800@koschikode.com>
Date: Tue, 05 Oct 2004 21:30:11 +0200
From: Juri Haberland <juri@koschikode.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: de-de, en-us, en, de
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>,
       Bartlomiej Zolnierkiewicz <B.Zolnierkiewicz@elka.pw.edu.pl>,
       axboe@suse.de
Subject: Re: [PATCH] ide-dma blacklist behaviour broken
References: <20041005142001.GR2433@suse.de> <20041005163730.A19554@infradead.org>
In-Reply-To: <20041005163730.A19554@infradead.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Tue, Oct 05, 2004 at 04:20:01PM +0200, Jens Axboe wrote:
>> Hi,
>> 
>> The blacklist stuff is broken. When set_using_dma() calls into
>> ide_dma_check(), it returns ide_dma_off() for a blacklisted drive. This
>> of course succeeds, returning success to the caller of ide_dma_check().
>> Not so good... It then uncondtionally calls ide_dma_on(), which turns on
>> dma for the drive.
>> 
>> This moves the check to ide_dma_on() so we also catch the buggy
>> ->ide_dma_check() defined by various chipset drivers.
> 
> Is this a bug introduced in the 2.6.9ish IDE changes or has it been there
> for a longer time? 

Looks like it is also in 2.4.27.

Juri
