Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261645AbTJFTjq (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 6 Oct 2003 15:39:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261646AbTJFTjq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 6 Oct 2003 15:39:46 -0400
Received: from dnsb1.cdh.it ([62.94.122.7]:24068 "EHLO dae.cdh.it")
	by vger.kernel.org with ESMTP id S261645AbTJFTjj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 6 Oct 2003 15:39:39 -0400
Message-ID: <3F81C4F6.5010000@ampersand.it>
Date: Mon, 06 Oct 2003 21:39:34 +0200
From: Stefano Carlotto <stefano.carlotto@ampersand.it>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:1.4) Gecko/20030624
X-Accept-Language: it, en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: highmem problem with lc2000
References: <3F7DF868.809@ampersand.it>
In-Reply-To: <3F7DF868.809@ampersand.it>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

I've tried some things, in the hope to find a solution: 2.4.23pre, some 
patches, but no good news. Only one thing, that may help, I hope, if i 
select HIGHMEM support 64GB, instead of 4GB, I have the same super 
slowness problem asap the kernel had started, but it's less severe and i 
can see without becoming old the fsck of mounted partition.
I tried also to play with high memory buffers on or off, but no change. 
I've read about some problem hanging around with some hardware driver 
not correctly using highmem, but the scsi on these machine is a 
sym53c896, and it's safe highmode written...
I read of problems selecting mp1.1 on bios setup under linux, but i do 
not manage to find any similar setup in bios. anyway, i upgraded to the 
last bios from hp.
any hint? any tactic you can suggest?
thanks in advance

Stefano Carlotto wrote:

> I'm having this strange problem: hp lc2000 (sym53c896 scsi), 2 pentium 
> III, kernel 2.4.22, just upgraded to 1664MB, raid software used, 
> slackware 8.1.
> Obviously, if i do not activate highmem support on kernel, I can see 
> only 896MB, as I had before the memory upgrade.
> If I activate high mem support (4GB), the system starts normally, 
> until it goes multiuser: then it slows in a incredible way, almost 
> stop, no disk activity, no ping answer, if I press return on keyboard, 
> it scrolls very very slooooow... ( vesa framebuffer used)
> any idea? :(
>
> this is /proc/mtrr  ( no highmem support compiled)
> reg00: base=0x00000000 (   0MB), size=1024MB: write-back, count=1
> reg01: base=0x40000000 (1024MB), size= 512MB: write-back, count=1
> reg02: base=0x60000000 (1536MB), size= 128MB: write-back, count=1
>
>
> thanks
> Stefano
>
> -
> To unsubscribe from this list: send the line "unsubscribe 
> linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/



