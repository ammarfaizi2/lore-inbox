Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S281037AbRKLWMN>; Mon, 12 Nov 2001 17:12:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S281039AbRKLWMD>; Mon, 12 Nov 2001 17:12:03 -0500
Received: from tourian.nerim.net ([62.4.16.79]:1800 "HELO tourian.nerim.net")
	by vger.kernel.org with SMTP id <S281037AbRKLWLv>;
	Mon, 12 Nov 2001 17:11:51 -0500
Message-ID: <3BF04926.2080009@free.fr>
Date: Mon, 12 Nov 2001 23:11:50 +0100
From: Lionel Bouton <Lionel.Bouton@free.fr>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5+) Gecko/20011110
X-Accept-Language: en-us
MIME-Version: 1.0
To: Linus Torvalds <torvalds@transmeta.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: File System Performance
In-Reply-To: <3BF03402.87D44589@zip.com.au> <3BF03402.87D44589@zip.com.au> <1005600431.13303.10.camel@jen.americas.sgi.com> <3BF04289.8FC8B7B7@zip.com.au> <9spg3c$7bb$1@penguin.transmeta.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

>In article <3BF04289.8FC8B7B7@zip.com.au>,
>Andrew Morton  <akpm@zip.com.au> wrote:
>
>>It's tar.  It cheats.  It somehow detects that the
>>output is /dev/null, and so it doesn't read the input files.
>>
>
>Probably the kernel.
>
Seems not the case with gnu tar : write isn't even called once on the fd 
returned by open("/dev/null",...). In fact a "grep write" on the strace 
output is empty in the "tar cf /dev/null" case. Every file in the tar-ed 
tree is stat-ed but no-one is read-ed.

-- 
 Lionel Bouton

-
"I wanted to be free, so I opensourced my whole DNA code" Gyver, 1999.



