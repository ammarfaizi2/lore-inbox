Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S280667AbRKBMbR>; Fri, 2 Nov 2001 07:31:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S280668AbRKBMbH>; Fri, 2 Nov 2001 07:31:07 -0500
Received: from thebsh.namesys.com ([212.16.0.238]:30225 "HELO
	thebsh.namesys.com") by vger.kernel.org with SMTP
	id <S280667AbRKBMbB>; Fri, 2 Nov 2001 07:31:01 -0500
Message-ID: <3BE291F9.5050802@namesys.com>
Date: Fri, 02 Nov 2001 15:30:49 +0300
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.5) Gecko/20011012
X-Accept-Language: en-us
MIME-Version: 1.0
To: zmwillow <zmwillow@xteamlinux.com.cn>
CC: linux-kernel-mail-list <linux-kernel@vger.kernel.org>,
        "Vladimir V. Saveliev" <monstr@namesys.com>
Subject: Re: where the filesystem size limitation coms from?
In-Reply-To: <3BE2B5F2.1040009@xteamlinux.com.cn>
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

zmwillow wrote:

>Hi:
>That is say: in 2.4.x, the max filesystem size of ext2 is 32T, and i
>want know
>what is the reiserfs(and others) max size ? and where the limitation
>comes from(VFS layer)?
>Maybe you can give some clue .
>And the max file size now biger than 2G(is 16T), how reiserfs implement it?
>Thanx a lot!
>zmwillow
>
>Best regard
>
>-
>To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
>the body of a message to majordomo@vger.kernel.org
>More majordomo info at  http://vger.kernel.org/majordomo-info.html
>Please read the FAQ at  http://www.tux.org/lkml/
>
>
block numbers are a 32 bit int is the problem. sectors are also kept as
a 32 bit int, but that is a layer below reiserfs. block numbers become
64 bit in reiser4, but not sure when rest of linux goes to 64 bit block
numbers

Hans


