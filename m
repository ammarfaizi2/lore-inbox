Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268165AbUHKSCZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268165AbUHKSCZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 14:02:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268145AbUHKSAG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 14:00:06 -0400
Received: from mailer.nec-labs.com ([138.15.108.3]:49359 "EHLO
	mailer.nec-labs.com") by vger.kernel.org with ESMTP id S268156AbUHKR6r
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 13:58:47 -0400
Message-ID: <411A5E55.3050508@nec-labs.com>
Date: Wed, 11 Aug 2004 10:58:45 -0700
From: Lei Yang <leiyang@nec-labs.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040114
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Phillip Lougher <phillip@lougher.demon.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Compression algorithm in cloop
References: <411A4D34.6000104@lougher.demon.co.uk>
In-Reply-To: <411A4D34.6000104@lougher.demon.co.uk>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 11 Aug 2004 17:58:42.0258 (UTC) FILETIME=[D6891320:01C47FCC]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


If I don't want to build a new compression library and port it to 
kernel, all I want to do is to try out the idea -- whether it could work 
on cloop, whether the compression ratio is acceptable, can I just change 
the cloop code? In other words, I just need a loopback block device with 
other compression scheme.

I know that adding the new algorithm support to kernel would be standard 
way to do this and would be helpful to more people, it's just that I 
don't have that time :(

Phillip Lougher wrote:
>  > Hello,
>  >
>  > I am trying to do some experiment on compression ratios with cloop. I
>  > know that currently cloop uses zlib. How can I change it to other
>  > algorithms?
> 
> Changing the algorithm from gzip is going to be probably unpopular.
> Cloop uses the gzip deflate library inside the kernel shared by a
> large number of other programs.  To change the algorithm you'll have
> to add more (private) decompression code to the kernel.  This is a 
> retrograde
> step because the shared library was only introduced in 2.4.17 to avoid lots
> of private copies of gzip.
> 
>  > Where should I start from? Really a newbie to this,
>  > appreciate any comments and suggestions!!
> 
> There has been discussion on this list before about adding
> bzip2 support to the kernel.  Do a search on the list for this.
> 
> Regards
> 
> Phillip
> 
