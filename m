Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269747AbUJGIDt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269747AbUJGIDt (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Oct 2004 04:03:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267350AbUJGIDt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Oct 2004 04:03:49 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:18597 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S267338AbUJGIDb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Oct 2004 04:03:31 -0400
Message-ID: <4164F841.8020504@pobox.com>
Date: Thu, 07 Oct 2004 04:03:13 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: marian.eichholz@freenet-ag.de
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.9-rc3 does not like diablo news reader daemon
References: <20041007071930.GB27228@urmel.freenet-ag.de>
In-Reply-To: <20041007071930.GB27228@urmel.freenet-ag.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marian Eichholz wrote:
> Hi,
> 
> the kernel 2.6.9-rc3 tends to crash when executing our NNTP
> reader daemon (dreaderd from diablo).
> 
> 2.6.3-rc1 runs on the sibling machine like a charm.

> Oct  6 22:48:39 newsread5 kernel: EIP is at generic_file_aio_write_nolock+0x1d1/0x500
> Oct  6 22:48:39 newsread5 kernel: eax: 00014c38   ebx: 00000000   ecx: 00000000   edx: 00000000
> Oct  6 22:48:39 newsread5 kernel: esi: de8fe000   edi: 00014c38   ebp: 00000000   esp: de8ffe38
> Oct  6 22:48:39 newsread5 kernel: ds: 007b   es: 007b   ss: 0068
> Oct  6 22:48:39 newsread5 kernel: Process dreaderd (pid: 166, threadinfo=de8fe000 task=de86d000)
> Oct  6 22:48:39 newsread5 kernel: Stack: 00014c38 00000040 00000000 de8ffe48 00000000 ca258200 de8ffee0 c02a8f05 
> Oct  6 22:48:39 newsread5 kernel:        de8ffee0 00000001 de8ffe8c ffffffff df37f3ec 00000000 00000000 df37f3ec 
> Oct  6 22:48:39 newsread5 kernel:        00000048 df37f490 de961560 00000048 00014c38 00000000 de8ffeb4 de961560 
> Oct  6 22:48:39 newsread5 kernel: Call Trace:
> Oct  6 22:48:39 newsread5 kernel:  [<c02a8f05>] sock_aio_read+0xf5/0x110


hmmmm, interesting.  Looks like AIO is ailing.

As an ex-Usenet news admin, I really like DIABLO... maybe I'll pull the 
latest copy and try to debug this.

	Jeff


