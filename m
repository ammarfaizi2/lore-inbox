Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264875AbTLERyp (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Dec 2003 12:54:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264881AbTLERyp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Dec 2003 12:54:45 -0500
Received: from mail.gmx.de ([213.165.64.20]:8613 "HELO mail.gmx.net")
	by vger.kernel.org with SMTP id S264875AbTLERym (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Dec 2003 12:54:42 -0500
X-Authenticated: #689055
Message-ID: <3FD0C64D.5050804@gmx.de>
Date: Fri, 05 Dec 2003 18:54:21 +0100
From: Torsten Scheck <torsten.scheck@gmx.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031014 Thunderbird/0.3
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: andersen@codepoet.org
CC: linux-kernel@vger.kernel.org
Subject: Re: Large-FAT32-Filesystem Bug
References: <3FD0555F.5060608@gmx.de> <20031205160746.GA18568@codepoet.org>
In-Reply-To: <20031205160746.GA18568@codepoet.org>
X-Enigmail-Version: 0.81.7.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Erik Andersen wrote:
> On Fri Dec 05, 2003 at 10:52:31AM +0100, Torsten Scheck wrote:
[...]
>>I found a critical FAT32 bug when I tried to store data onto an
>>internal IDE 160 GB and onto an external USB2/FW-250 GB hard
>>disk.
> 
> 
> Does this help?
> 
>  -Erik

[... int=>loff_t ino,inum-patch ...]

Hi Erik:

I applied your patch to 2.4.23 and it solved the problem. No more lost 
clusters. All data stays where it belongs.

I'll test it for a few days and get back to you later.

Thank you very much.

Torsten


For those who play with vfat filesystems now:

I noticed that fsck.vfat just pretends to repair a _mounted_ vfat 
filesystem. You have to unmount it, so it is actually repaired. An error 
message would be appropriate here. I'll contact the dosfsck maintainer, 
but I thought telling you might avoid confusion.

