Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263076AbTJaHnR (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 31 Oct 2003 02:43:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263077AbTJaHnR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 31 Oct 2003 02:43:17 -0500
Received: from [212.55.154.24] ([212.55.154.24]:5843 "HELO sapo.pt")
	by vger.kernel.org with SMTP id S263076AbTJaHnP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 31 Oct 2003 02:43:15 -0500
Message-ID: <3FA212BD.3070408@vgertech.com>
Date: Fri, 31 Oct 2003 07:43:57 +0000
From: Nuno Silva <nuno.silva@vgertech.com>
Organization: VGER, LDA
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031020 Debian/1.5-1
X-Accept-Language: en-us, pt
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: age <ahuisman@cistron.nl>, linux-kernel@vger.kernel.org
Subject: Re: READAHEAD
References: <bnrdqi$uho$1@news.cistron.nl> <20031030134407.0c97c86e.akpm@osdl.org>
In-Reply-To: <20031030134407.0c97c86e.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!!

Andrew Morton wrote:
> age <ahuisman@cistron.nl> wrote:
> 
>>I have a problem which i don`t understand and i hope that you
>> will and can  help me. The problem is that i experience strange disk
>> read performance. I have to set hdparm -m16 -u1 -c1 -d1 -a4096 /dev/hde
>> to get  timing buffered disk reads of 56 MB/SEC.
>> When i disable readahead i get 17 MB/SEC
>> When i enable readahead with -a8 i get  17 MB/SEC
>> When i enable readahead with -a16 i get 24,5 MB/SEC
>> When i enable readahead with -a32 i get 30,5 MB/SEC
>> When i enable readahead with -a64 i get 35 MB/SEC
>> When i enable readahead with -a128 i get 39 MB/SEC
>> When i enable readahead with -a256 i get 39 MB/SEC
>> When i enable readahead with -a512 i get 41 MB/SEC
>> When i enable readahead with -a1024 i get 50 MB/SEC
>> When i enable readahead with -a2048 i get 50 MB/SEC
>> When i enable readahead with -a4096 i get 56 MB/SEC
>> With -a8192,-a16384 and -a32768 i get also 56MB/SEC
>>
>> Before, i never had to set readahead so high
>> Please could you tell me, what is going on here ?
> 
> 
> Lots of people have been reporting this.  It's rather weird.
> 

I know nothing about this but, FWIW, I think that what changed where the 
units. With 2.4 you specify sectors, with 2.6 you specify bytes.

So, having -a8, in 2.4, is the same as having -a$((8*512)) [it's 4096 
:)], in 2.6.

Not sure if it's the case, but makes sense :-)

Regards,
Nuno Silva

