Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311749AbSFJL74>; Mon, 10 Jun 2002 07:59:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311752AbSFJL7z>; Mon, 10 Jun 2002 07:59:55 -0400
Received: from [195.63.194.11] ([195.63.194.11]:19974 "EHLO
	mail.stock-world.de") by vger.kernel.org with ESMTP
	id <S311749AbSFJL7y>; Mon, 10 Jun 2002 07:59:54 -0400
Message-ID: <3D0486C0.2050303@evision-ventures.com>
Date: Mon, 10 Jun 2002 13:00:16 +0200
From: Martin Dalecki <dalecki@evision-ventures.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; pl-PL; rv:1.0rc3) Gecko/20020523
X-Accept-Language: en-us, pl
MIME-Version: 1.0
To: Zwane Mwaikambo <zwane@linux.realnet.co.sz>
CC: Miles Lane <miles@megapathdsl.net>, linux-kernel@vger.kernel.org,
        Gert Vervoort <Gert.Vervoort@wxs.nl>
Subject: Re: 2.5.21: "ata_task_file: unknown command 50"
In-Reply-To: <Pine.LNX.4.44.0206101326200.18155-100000@netfinity.realnet.co.sz>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zwane Mwaikambo wrote:
> On Mon, 10 Jun 2002, Martin Dalecki wrote:
> 
> 
>>Miles Lane wrote:
>>
>>>Gert wrote:
>>> > kernel 2.5.21 hangs with repeating the message "ata_task_file: 
>>>unknown command 50" forever.
>>
>>
>>IDE 86 should fix it.
> 
> 
> What is command 50?
> 
> Thanks,
> 	Zwane

hdregs.h will tell you.
But it really doesn't matter. The problem is that ide-scsi
was using REQ_SEPCIAL where it should be using REQ_PC in first
palce.

