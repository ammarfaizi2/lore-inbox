Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751125AbWGQSQ3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751125AbWGQSQ3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 14:16:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751126AbWGQSQ3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 14:16:29 -0400
Received: from zotz.mtu.ru ([195.34.34.227]:2321 "EHLO zotz.mtu.ru")
	by vger.kernel.org with ESMTP id S1751125AbWGQSQ2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 14:16:28 -0400
From: Andrey Borzenkov <arvidjaar@mail.ru>
Subject: Re: kernel panic at load average of 24 is it acceptable ?
To: Vikas Kedia <kedia.vikas@gmail.com>, linux-kernel@vger.kernel.org
Date: Mon, 17 Jul 2006 22:16:21 +0400
References: <fbe022af0607170008w5efb489fjd3df63f1795805c2@mail.gmail.com> <20060717072457.GA12215@rhlx01.fht-esslingen.de> <fbe022af0607170055x7fefdf9bg63ea77768480935a@mail.gmail.com>
User-Agent: KNode/0.10.2
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
Message-Id: <20060717181624.5BF9355D9CB@zotz.mtu.ru>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vikas Kedia wrote:

>> Read up on MCE debugging methods on Linux or so, that should hopefully
>> help.
> 
> Here is the output of mcelog:
> root@srv1:~# less /var/log/mcelog
> MCE 0
> CPU 0 0 data cache TSC 6988ae18046
> ADDR f87f5ec0
>   Data cache ECC error (syndrome ce)
>        bit46 = corrected ecc error
>   bus error 'local node origin, request didn't time out
>       data read mem transaction
>       memory access, level generic'
> STATUS 9467400000000833 MCGSTATUS 0
> MCE 0
> CPU 0 0 data cache TSC 723b38a3633
> ADDR 3d9fc0
>   Data cache ECC error (syndrome ce)
>        bit46 = corrected ecc error
>        bit62 = error overflow (multiple errors)
>   bus error 'local node origin, request didn't time out
>       data read mem transaction
>       memory access, level generic'
> STATUS d467400000000833 MCGSTATUS 0
> 
> Since it shows ECC error is the hypothesis correct that its the RAM
> problem and replacing it should solve the problem.
> 

I am not sure if this is a question, but it shows _data cache_ multibit
error which makes it rather CPU not memory.

-andrey

