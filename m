Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S284759AbRLHU3k>; Sat, 8 Dec 2001 15:29:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S284774AbRLHU33>; Sat, 8 Dec 2001 15:29:29 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:35081 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S284759AbRLHU3R>; Sat, 8 Dec 2001 15:29:17 -0500
Message-ID: <3C1277D0.8000706@namesys.com>
Date: Sat, 08 Dec 2001 23:28:00 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.6) Gecko/20011120
X-Accept-Language: en-us
MIME-Version: 1.0
To: Daniel Phillips <phillips@bonn-fries.net>
CC: Linus Torvalds <torvalds@transmeta.com>, linux-kernel@vger.kernel.org
Subject: Re: [reiserfs-dev] Re: Ext2 directory index: ALS paper and benchmarks
In-Reply-To: <E16BjYc-0000hS-00@starship.berlin> <3C110B3F.D94DDE62@zip.com.au> <9useu4$f4o$1@penguin.transmeta.com> <E16ClLY-000124-00@starship.berlin>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Daniel Phillips wrote:

>
>By the way, we can trivially shrink every inode by 6 bytes, right now, with:
>
>-	__u32	i_faddr;
>-	__u8	i_frag_no;
>-	__u8	i_frag_size;
>
>--
>Daniel
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
Using a union of filesystems, that might not even be compiled into the 
kernel or as modules, in struct inode is just.....  bad.

It is really annoying when the filesystems with larger inodes bloat up 
the size for those who are careful with their bytes, can we do something 
about that generally?
(There are quite a variety of ways to do something about it, if there is 
a will.)  I have programmers who come to me asking for permission for 
adding bloat to our part of struct inode , and when they point out that 
it does no good to save on bytes unless ext2 does, well..... what can I say?

Hans

