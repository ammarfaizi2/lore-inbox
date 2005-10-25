Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932378AbVJYU74@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932378AbVJYU74 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 25 Oct 2005 16:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932379AbVJYU74
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 25 Oct 2005 16:59:56 -0400
Received: from prgy-npn2.prodigy.com ([207.115.54.38]:21988 "EHLO
	oddball.prodigy.com") by vger.kernel.org with ESMTP id S932378AbVJYU7z
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 25 Oct 2005 16:59:55 -0400
Message-ID: <435E9D17.3050706@tmr.com>
Date: Tue, 25 Oct 2005 17:01:11 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.11) Gecko/20050729
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Alexey Dobriyan <adobriyan@gmail.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: When did UFS read-write work?
References: <20051025080319.GA10234@mipter.zuzino.mipt.ru>
In-Reply-To: <20051025080319.GA10234@mipter.zuzino.mipt.ru>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alexey Dobriyan wrote:
> I've tried to copy a small file to a partition mounted as ufstype=44bsd.
> It hanged while doing
> 
> 	open("file", O_WRONLY|O_CREAT|O_LARGEFILE, 0100644)
> 
> Second time, there was no hang, but there was no file on UFS partition
> too.
> 
> Rebooting to OpenBSD:
> 
> 	~ $ cd linux/		<=== created by Linux
> 	~/linux $ ls -la
> 	ls: .: No such file or directory
> 
> Does anyone remeber when UFS rw was OK?

I don't know if it ever WAS okay for 64 bit, never tried it. You might 
try dropping LARGEFILE just to see if that's the issue.


-- 
    -bill davidsen (davidsen@tmr.com)
"The secret to procrastination is to put things off until the
  last possible moment - but no longer"  -me
