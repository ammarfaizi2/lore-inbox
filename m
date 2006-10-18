Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751451AbWJRGkL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751451AbWJRGkL (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Oct 2006 02:40:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWJRGkK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Oct 2006 02:40:10 -0400
Received: from main.gmane.org ([80.91.229.2]:42931 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1751451AbWJRGkI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Oct 2006 02:40:08 -0400
X-Injected-Via-Gmane: http://gmane.org/
To: linux-kernel@vger.kernel.org
From: Sven Hoexter <shoexter@gmx.de>
Subject: Re: [REGRESSION] nfs client: Read-only file system (2.6.19-rc1,2)
Date: Wed, 18 Oct 2006 08:27:55 +0200
Message-ID: <eh4hhb$sp7$1@sea.gmane.org>
References: <4534F59D.4040505@gmail.com> <1161104051.5559.5.camel@lade.trondhjem.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7Bit
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: xdsl-87-78-10-107.netcologne.de
User-Agent: KNode/0.10.4
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Trond Myklebust wrote:
> On Tue, 2006-10-17 at 17:24 +0200, Jiri Slaby wrote:

Hi,

>> I can't write on mounted nfs filesystem since 2.6.19-rc1 (nfs client):
>> touch: cannot touch `aaa': Read-only file system
>> 
>> strace says:
>> open("aaa", O_WRONLY|O_NONBLOCK|O_CREAT|O_NOCTTY|O_LARGEFILE, 0666) = -1
>> EROFS (Read-only file system)
>> 
>> 2.6.18 behaves correctly. Settings are the same, does anybody have any
>> clue?
>
> What does "cat /proc/mounts" say?
Ok I'm not the OP but I can confirm the problem.

>From /proc/mounts:
arthur:/mnt/disk2/mp3 /mnt/mp3 nfs ro,nosuid,nodev,noexec,vers=3,rsize=8192,wsize=8192,hard,proto=tcp,timeo=600,retrans=2,sec=sys,addr=arthur 0 0

Reports ro here while mount still reports rw:
arthur:/mnt/disk2/mp3 on /mnt/mp3 type nfs (rw,noexec,nosuid,nodev,addr=192.168.88.80)

Sven

