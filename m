Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265996AbUAKWNU (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 17:13:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265998AbUAKWNU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 17:13:20 -0500
Received: from rs9.luxsci.com ([66.216.98.59]:7585 "EHLO rs9.luxsci.com")
	by vger.kernel.org with ESMTP id S265996AbUAKWNS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 17:13:18 -0500
Message-ID: <4001CA63.9000300@acm.org>
Date: Sun, 11 Jan 2004 14:12:51 -0800
From: Javier Fernandez-Ivern <ivern@acm.org>
Reply-To: ivern@acm.org
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6b) Gecko/20031208 Thunderbird/0.4
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Krzysztof Halasa <khc@pm.waw.pl>
Cc: Valdis.Kletnieks@vt.edu, Job 317 <job317@mailvault.com>,
       linux kernel mailing list <linux-kernel@vger.kernel.org>
Subject: Re: HELP!! 2.6.x build problem with make xconfig
References: <20040110235440.7962B8400A3@gateway.mailvault.com>	<200401110019.i0B0J2Ld014059@turing-police.cc.vt.edu> <m33camdxsq.fsf@defiant.pm.waw.pl>
In-Reply-To: <m33camdxsq.fsf@defiant.pm.waw.pl>
X-Enigmail-Version: 0.82.4.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Krzysztof Halasa wrote:
> Valdis.Kletnieks@vt.edu writes:
> 
> 
>>>cd /usr/include
>>>rm asm linux scsi
>>>ln -fs /usr/src/linux/include/asm-i386 asm
>>>ln -fs /usr/src/linux/include/linux linux
>>>ln -fs /usr/src/linux/include/scsi scsi
>>
>>Don't do that.
>>
>>Use what's in the glibc-kernheaders RPM for userspace, and let the kernel
>>provide its own headers for its use.
> 
> 
> GNU libc doesn't have (nor need) its own "kernel" headers and uses the
> kernel ones.
> You may live with "glibc-kernheaders" package only if it matches your
> system. If you're using a different (newer, modified etc) kernel then
> you need the symlinks or a copy (example: new ioctls + programs using
> them).
> 
> You may need to recompile the libc as well, if the libc-kernel (binary)
> interface has changed.

Sometimes there's a reason to use the old kernel headers...I still run 
several apps that can't grok the 2.6 headers, and will only compile with 
2.4 ones (and they work fine).  I have a couple of small scripts that 
switch the directories around when I need them, for convenience.  :)

Of course, the real solution would be to hack them to work with new 
headers, but I don't have the time for that at the moment.  *Sigh*

-- 
Javier Fernandez-Ivern
