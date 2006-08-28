Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751053AbWH1Ozq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751053AbWH1Ozq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 28 Aug 2006 10:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751057AbWH1Ozq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 28 Aug 2006 10:55:46 -0400
Received: from nz-out-0102.google.com ([64.233.162.207]:56903 "EHLO
	nz-out-0102.google.com") by vger.kernel.org with ESMTP
	id S1751052AbWH1Ozp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 28 Aug 2006 10:55:45 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:user-agent:mime-version:to:cc:subject:references:in-reply-to:content-type:content-transfer-encoding;
        b=cMBxdCmPgognXi3RUsvYzRTzYR3cQRDwd2WDz3XxS7rSPXLczI6EvXTxjwRAWbDGSRUgi9K1MYqioLhzb6spOym1m8EAIyiL1irlUpAs86HF9/bQEcN2KAf55fIEw9Y9abJV/mp48XvgBnuiGcbt7brvHoclLO62tuOL1KWPsqg=
Message-ID: <44F303ED.4040605@gmail.com>
Date: Mon, 28 Aug 2006 22:55:41 +0800
From: Yi Yang <yang.y.yi@gmail.com>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Frederik Deweerdt <deweerdt@free.fr>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2.6.18-rc* PATCH RFC]: Correct ambiguous errno of aio
References: <44F2EF90.9050603@gmail.com> <20060828160800.GA1633@slug>
In-Reply-To: <20060828160800.GA1633@slug>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Frederik Deweerdt 写道:
> On Mon, Aug 28, 2006 at 09:28:48PM +0800, Yi Yang wrote:
>   
>> In the current implementation of AIO, for the operation IOCB_CMD_FDSYNC
>> and IOCB_CMD_FSYNC, the returned errno is -EINVAL although the kernel
>> does know them, I think the correct errno should be -EOPNOTSUPP which
>> means they aren't be implemented or supported.
>>     
> Hi, 
>
> If I'm not mistaken, returning EINVAL conforms to POSIX, isn't it?
>   
But POSIX also defined ENOTSUP which is equal to EOPNOTSUPP for linux.
> http://www.opengroup.org/onlinepubs/009695399/functions/fsync.html
> Regards,
> Frederik
>  
>
>   

