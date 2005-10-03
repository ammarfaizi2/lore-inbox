Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932226AbVJCLEg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932226AbVJCLEg (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 3 Oct 2005 07:04:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932227AbVJCLEg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 3 Oct 2005 07:04:36 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:12819 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S932226AbVJCLEf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 3 Oct 2005 07:04:35 -0400
Date: Mon, 3 Oct 2005 12:04:23 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: vikas gupta <vikas_gupta51013@yahoo.co.in>
Cc: Denis Vlasenko <vda@ilport.com.ua>, bcrl@kvack.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc6-xx-all.diff is not working for 2.6.13 arm kernel
Message-ID: <20051003110423.GC16717@flint.arm.linux.org.uk>
Mail-Followup-To: vikas gupta <vikas_gupta51013@yahoo.co.in>,
	Denis Vlasenko <vda@ilport.com.ua>, bcrl@kvack.org,
	linux-aio@kvack.org, linux-kernel@vger.kernel.org
References: <20051003100731.GB16717@flint.arm.linux.org.uk> <20051003105511.90508.qmail@web8408.mail.in.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20051003105511.90508.qmail@web8408.mail.in.yahoo.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2005 at 11:55:11AM +0100, vikas gupta wrote:
> Sorry for my mistake..
> Arm kernel build Error LOG:
> .....
> CC      mm/filemap.o
> mm/filemap.c: In function `generic_file_aio_writev':
> mm/filemap.c:2212: warning: implicit declaration of
> function `aio_down'
> mm/filemap.c:2216: warning: implicit declaration of
> function `aio_up'
> ....
> fs/pipe.c: In function `pipe_aio_wait':
> fs/pipe.c:105: warning: implicit declaration of
> function `aio_up'
> fs/pipe.c: In function `pipe_aio_read':
> fs/pipe.c:206: warning: implicit declaration of
> function `aio_down'

$ grep aio_down fs/*.c
$ grep aio_down mm/*.c
$ grep aio_down . -r
$

The problem you're referring to does not appear to be present in
the mainline kernel sources.  Maybe the AIO folk can provide some
pointers?

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
