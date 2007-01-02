Return-Path: <linux-kernel-owner+w=401wt.eu-S932756AbXABK0N@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932756AbXABK0N (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 05:26:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932763AbXABK0N
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 05:26:13 -0500
Received: from smtpq1.tilbu1.nb.home.nl ([213.51.146.200]:57979 "EHLO
	smtpq1.tilbu1.nb.home.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932756AbXABK0M (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 05:26:12 -0500
Message-ID: <459A32E5.70506@gmail.com>
Date: Tue, 02 Jan 2007 11:24:37 +0100
From: Rene Herman <rene.herman@gmail.com>
User-Agent: Thunderbird 1.5.0.9 (X11/20061206)
MIME-Version: 1.0
To: Jens Axboe <jens.axboe@oracle.com>
CC: Andrew Morton <akpm@osdl.org>, Tejun Heo <htejun@gmail.com>,
       Jens Axboe <axboe@suse.de>, Alan Cox <alan@lxorguk.ukuu.org.uk>,
       linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
Subject: Re: 2.6.20-rc2+: CFQ halving disk throughput.
References: <45893CAD.9050909@gmail.com> <45921E73.1080601@gmail.com> <4592B25A.4040906@gmail.com> <45932AF1.9040900@gmail.com> <45998F62.6010904@gmail.com> <20070101213601.c526f779.akpm@osdl.org> <20070102084447.GS2483@kernel.dk>
In-Reply-To: <20070102084447.GS2483@kernel.dk>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Please contact support@home.nl for more information
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jens Axboe wrote:

> On Mon, Jan 01 2007, Andrew Morton wrote:

>> The patch would appear to need this fix:
>>
>> --- a/block/cfq-iosched.c~a
>> +++ a/block/cfq-iosched.c
>> @@ -592,7 +592,7 @@ static int cfq_allow_merge(request_queue
>>  	if (cfqq == RQ_CFQQ(rq))
>>  		return 1;
>>  
>> -	return 1;
>> +	return 0;
>>  }
>>  
>>  static inline void
>> _
>>
>> But that might not fix things...
> 
> Yeah it is, but I don't think it'll fix it (if anything, it'll be more
> conservative).

(to possibly save others from trying -- no, doesn't fix any)

Rene.
