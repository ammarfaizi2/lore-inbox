Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263743AbTDUAEC (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Apr 2003 20:04:02 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263744AbTDUAEC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Apr 2003 20:04:02 -0400
Received: from terminus.zytor.com ([63.209.29.3]:43976 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S263743AbTDUAEB
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Apr 2003 20:04:01 -0400
Message-ID: <3EA33839.4050302@zytor.com>
Date: Sun, 20 Apr 2003 17:15:53 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3b) Gecko/20030211
X-Accept-Language: en-us, en, sv
MIME-Version: 1.0
To: Andries.Brouwer@cwi.nl
CC: linux-kernel@vger.kernel.org
Subject: Re: [CFT] more kdev_t-ectomy
References: <UTC200304202356.h3KNuYK14756.aeb@smtp.cwi.nl>
In-Reply-To: <UTC200304202356.h3KNuYK14756.aeb@smtp.cwi.nl>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andries.Brouwer@cwi.nl wrote:
> 
> It doesnt matter much. I would not have introduced kdev_t just
> for slightly more efficient dev_t handling. But we have it already.
> It seems meaningless to go and replace it by something more awkward
> and less efficient.
> 

It isn't, though, if it makes things cleaner and avoids double conversions.

> [But should anyone want: globally s/kdev_t/dev_t/ and a small edit
> of kdev_t.h suffices.]
> 
>     We do need a dev32_t for NFSv2 et al, though.
> 
> I don't know why.

So we can have (k)dev_t_to_dev32() for NFSv2 et al, which only allows 
for 32 bits in device numbers.  This is 12:20 <-> 32:32 conversions.

	-hpa


