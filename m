Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267111AbSKXF2f>; Sun, 24 Nov 2002 00:28:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267166AbSKXF2f>; Sun, 24 Nov 2002 00:28:35 -0500
Received: from adsl-67-114-19-186.dsl.pltn13.pacbell.net ([67.114.19.186]:22482
	"HELO adsl-63-202-77-221.dsl.snfc21.pacbell.net") by vger.kernel.org
	with SMTP id <S267111AbSKXF2e>; Sun, 24 Nov 2002 00:28:34 -0500
Message-ID: <3DE0653F.7000000@tupshin.com>
Date: Sat, 23 Nov 2002 21:35:59 -0800
From: Tupshin Harper <tupshin@tupshin.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020913 Debian/1.1-1
X-Accept-Language: en
MIME-Version: 1.0
To: Oleg Drokin <green@namesys.com>
CC: linux-kernel@vger.kernel.org
Subject: Re: paging oops with 2.4.20-rc2
References: <3DDD8339.2040409@tupshin.com> <20021122095450.A8056@namesys.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Well, after further examination and manipulations, I determined that 
both the paging oops and the report of BUG page_alloc.c that I was 
getting are eliminated after moving my swap partition off of the 
raid0+lvm volume that it was on and onto a separate disk.

Still a bug, but a fairly obscure one. It's obviously not necessary for 
performance reasons since the kernel stripes swaps itself, but it 
certainly caused me a lot of headache until I figured out what was going on.

-Tupshin

Oleg Drokin wrote:

>Is the oops always the same and looks like the one you've posted here?
>Or is it different from time to time?
>If it always the same, can you please try to compile your kernel with
>CONFIG_REISERFS_CHECK (reiserfs debug) option enabled and see what happens?
>
>Thank you.
>
>Bye,
>    Oleg
>
>  
>


