Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751222AbWEEXkS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751222AbWEEXkS (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 May 2006 19:40:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751231AbWEEXkS
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 May 2006 19:40:18 -0400
Received: from mailhub.sw.ru ([195.214.233.200]:33194 "EHLO relay.sw.ru")
	by vger.kernel.org with ESMTP id S1751222AbWEEXkQ convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 May 2006 19:40:16 -0400
Message-ID: <445BE327.4030104@sw.ru>
Date: Sat, 06 May 2006 03:43:35 +0400
From: Vasily Averin <vvs@sw.ru>
Organization: SW-soft
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.7.12) Gecko/20050921
X-Accept-Language: en-us, en, ru
MIME-Version: 1.0
To: James Bottomley <James.Bottomley@SteelEye.com>
CC: linux-scsi@vger.kernel.org, Neela.Kolli@engenio.com,
       Atul Mukker <Atul.Mukker@lsil.com>, Seokmann.Ju@lsil.com,
       sreenib@lsil.com, devel@openvz.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: megaraid_mbox: garbage in file
References: <445A4C8F.5030204@sw.ru>	 <1146783568.22932.105.camel@mulgrave.il.steeleye.com>	 <445AE4A5.8070202@sw.ru>	 <1146844763.9848.17.camel@mulgrave.il.steeleye.com>  <445B96B9.20100@sw.ru> <1146859509.9848.110.camel@mulgrave.il.steeleye.com>
In-Reply-To: <1146859509.9848.110.camel@mulgrave.il.steeleye.com>
X-Enigmail-Version: 0.90.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=KOI8-R
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

James Bottomley wrote:
> On Fri, 2006-05-05 at 22:17 +0400, Vasily Averin wrote:
>> megaraid mailbox: status:0x0 cmd:0xa7 id:0x25 sec:0x1a
>>                 lba:0x33f624ac addr:0xffffffff ld:128 sg:4
>> scsi cmnd: 0x28 0x00 0x33 0xf6 0x24 0xac 0x00 0x00 0x1a 0x00
>> mbox request_buffer eafde340 use_sg 4
>> mbox sg0: page 077a0474 off 0 addr 1fd575000 len 4096 virt ff15a000
>>                 first 03020100 page->flags 40020101
>> mbox sg1: page 077b5738 off 0 addr 1fdede000 len 4096 virt ff141000
>>                 first 03020100 page->flags 40020101
>> mbox sg2: page 077ad500 off 0 addr 1fdb40000 len 4096 virt ff056000
>>                 first 03020100 page->flags 40020101
>> mbox sg3: page 030d46e8 off 1024 addr 5e6a400 len 1024 virt 07e6a400
>>                 first 03020100 page->flags 20001004
> 
> The odd thing about this is that the highmem addresses shouldn't have a
> virtual mapping (since nothing should have called kmap on them).

You are right, in the other my experiments highmem pages usually have virt=0 and
I cannot find who is kmapped these pages.

I'll investigate this issue later: first ща all I'll try to reproduce this issue
on 2.6.16 kernel.

Thank you,
	Vasily Averin

SWsoft Virtuozzo/OpenVZ Linux kernel team

