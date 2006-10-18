Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932115AbWJRIwh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932115AbWJRIwh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 04:52:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932124AbWJRIwh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 04:52:37 -0400
Received: from mx0.karneval.cz ([81.27.192.123]:48923 "EHLO av1.karneval.cz")
	by vger.kernel.org with ESMTP id S932115AbWJRIwg (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 04:52:36 -0400
Message-ID: <4535EB4F.4070406@gmail.com>
Date: Wed, 18 Oct 2006 10:52:31 +0200
From: Jiri Slaby <jirislaby@gmail.com>
User-Agent: Thunderbird 2.0a1 (X11/20060724)
MIME-Version: 1.0
To: Sven Hoexter <shoexter@gmx.de>
CC: linux-kernel@vger.kernel.org, Jiri Slaby <jirislaby@gmail.com>,
       Trond Myklebust <trond.myklebust@fys.uio.no>
Subject: Re: [REGRESSION] nfs client: Read-only file system (2.6.19-rc1,2)
References: <4534F59D.4040505@gmail.com> <1161104051.5559.5.camel@lade.trondhjem.org> <eh4hhb$sp7$1@sea.gmane.org>
In-Reply-To: <eh4hhb$sp7$1@sea.gmane.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Do not remove CCs.
Cc: Trond Myklebust <trond.myklebust@fys.uio.no>
Cc: Jiri Slaby <jirislaby@gmail.com>

Sven Hoexter wrote:
> Trond Myklebust wrote:
>> On Tue, 2006-10-17 at 17:24 +0200, Jiri Slaby wrote:
> 
> Hi,
> 
>>> I can't write on mounted nfs filesystem since 2.6.19-rc1 (nfs client):
>>> touch: cannot touch `aaa': Read-only file system
>>>
>>> strace says:
>>> open("aaa", O_WRONLY|O_NONBLOCK|O_CREAT|O_NOCTTY|O_LARGEFILE, 0666) = -1
>>> EROFS (Read-only file system)
>>>
>>> 2.6.18 behaves correctly. Settings are the same, does anybody have any
>>> clue?
>> What does "cat /proc/mounts" say?
> Ok I'm not the OP but I can confirm the problem.
> 
>>From /proc/mounts:
> arthur:/mnt/disk2/mp3 /mnt/mp3 nfs ro,nosuid,nodev,noexec,vers=3,rsize=8192,wsize=8192,hard,proto=tcp,timeo=600,retrans=2,sec=sys,addr=arthur 0 0
> 
> Reports ro here while mount still reports rw:
> arthur:/mnt/disk2/mp3 on /mnt/mp3 type nfs (rw,noexec,nosuid,nodev,addr=192.168.88.80)

I will post my output in some hours, if still needed.

regards,
-- 
http://www.fi.muni.cz/~xslaby/            Jiri Slaby
faculty of informatics, masaryk university, brno, cz
e-mail: jirislaby gmail com, gpg pubkey fingerprint:
B674 9967 0407 CE62 ACC8  22A0 32CC 55C3 39D4 7A7E
