Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932120AbVJLJDU@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932120AbVJLJDU (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 12 Oct 2005 05:03:20 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932415AbVJLJDU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 12 Oct 2005 05:03:20 -0400
Received: from anchor-post-30.mail.demon.net ([194.217.242.88]:53508 "EHLO
	anchor-post-30.mail.demon.net") by vger.kernel.org with ESMTP
	id S932120AbVJLJDT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 12 Oct 2005 05:03:19 -0400
From: Felix Oxley <lkml@oxley.org>
To: OBATA Noboru <noboru.obata.ar@hitachi.com>
Subject: Re: Linux Kernel Dump Summit 2005
Date: Wed, 12 Oct 2005 10:02:56 +0100
User-Agent: KMail/1.8.2
Cc: pavel@ucw.cz, hyoshiok@miraclelinux.com, linux-kernel@vger.kernel.org
References: <20051010084535.GA2298@elf.ucw.cz> <20051012.172844.59463643.noboru.obata.ar@hitachi.com>
In-Reply-To: <20051012.172844.59463643.noboru.obata.ar@hitachi.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200510121002.59098.lkml@oxley.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 12 October 2005 09:28, OBATA Noboru wrote:

>    CMD     | NET TIME (in seconds)          | OUTPUT SIZE (in bytes)
>   ---------+--------------------------------+------------------------
>    cp      |  35.94 (usr 0.23, sys 14.16)   | 2,121,438,352 (100.0%)
>    lzf     |  54.30 (usr 35.04, sys 13.10)  | 1,959,473,330 ( 92.3%)
>    gzip -1 | 200.36 (usr 186.84, sys 11.73) | 1,938,686,487 ( 91.3%)
>   ---------+--------------------------------+------------------------
>
> Although it is too early to say lzf's compress ratio is good
> enough, its compression speed is impressive indeed.  

As you say, the speed of lzf relative to gzip is impressive.

However if the properties of the kernel dump mean that it is not suitable for 
compression then surely it is not efficient to spend any time on it.

>And the
> result also suggests that it is too early to give up the idea of
> full dump with compression.

Are you sure? :-)
If we are talking about systems with 32GB of memory then we must be taking 
about organisations who can afford an extra 100GB of disk space just for 
keeping their kernel dump files. 

I would expect that speed of recovery would always be the primary concern.
Would you agree?

regards,
Felix



