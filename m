Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161176AbWJRPqd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161176AbWJRPqd (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 11:46:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161187AbWJRPqd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 11:46:33 -0400
Received: from tirith.ics.muni.cz ([147.251.4.36]:8326 "EHLO
	tirith.ics.muni.cz") by vger.kernel.org with ESMTP id S1161176AbWJRPqc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 11:46:32 -0400
Message-ID: <45364C51.2000004@gmail.com>
Date: Wed, 18 Oct 2006 17:46:25 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Jiri Slaby <jirislaby@gmail.com>
CC: Sven Hoexter <shoexter@gmx.de>, linux-kernel@vger.kernel.org,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [REGRESSION] nfs client: Read-only file system (2.6.19-rc1,2)
References: <4534F59D.4040505@gmail.com> <1161104051.5559.5.camel@lade.trondhjem.org> <eh4hhb$sp7$1@sea.gmane.org> <4535EB4F.4070406@gmail.com>
In-Reply-To: <4535EB4F.4070406@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Muni-Spam-TestIP: 147.251.46.244
X-Muni-Envelope-From: jirislaby@gmail.com
X-Muni-Virus-Test: Clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jiri Slaby wrote:
> Do not remove CCs.
> Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
> Cc: Jiri Slaby <jirislaby@gmail.com>
> 
> Sven Hoexter wrote:
>> Trond Myklebust wrote:
>>> On Tue, 2006-10-17 at 17:24 +0200, Jiri Slaby wrote:
>>
>> Hi,
>>
>>>> I can't write on mounted nfs filesystem since 2.6.19-rc1 (nfs client):
>>>> touch: cannot touch `aaa': Read-only file system
>>>>
>>>> strace says:
>>>> open("aaa", O_WRONLY|O_NONBLOCK|O_CREAT|O_NOCTTY|O_LARGEFILE, 0666) 
>>>> = -1
>>>> EROFS (Read-only file system)
>>>>
>>>> 2.6.18 behaves correctly. Settings are the same, does anybody have any
>>>> clue?
>>> What does "cat /proc/mounts" say?
>> Ok I'm not the OP but I can confirm the problem.
>>
>>> From /proc/mounts:
>> arthur:/mnt/disk2/mp3 /mnt/mp3 nfs 
>> ro,nosuid,nodev,noexec,vers=3,rsize=8192,wsize=8192,hard,proto=tcp,timeo=600,retrans=2,sec=sys,addr=arthur 
>> 0 0
>>
>> Reports ro here while mount still reports rw:
>> arthur:/mnt/disk2/mp3 on /mnt/mp3 type nfs 
>> (rw,noexec,nosuid,nodev,addr=192.168.88.80)
> 
> I will post my output in some hours, if still needed.

The very same thing. /etc/mtab still reports rw, while /proc/mounts says ro, weird.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
