Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261671AbVBSIo7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261671AbVBSIo7 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 19 Feb 2005 03:44:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261669AbVBSIoZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 19 Feb 2005 03:44:25 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:41160 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S261659AbVBSImC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 19 Feb 2005 03:42:02 -0500
Message-ID: <4216FBCB.8040807@pobox.com>
Date: Sat, 19 Feb 2005 03:41:47 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: linux-net@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] drivers/net/smc-mca.c: cleanups
References: <20050219083431.GN4337@stusta.de>
In-Reply-To: <20050219083431.GN4337@stusta.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> This patch contains the following cleanups:
> - make a needlessly global function static
> - make three needlessly global structs static
> 
> Since after moving the now-static stucts to smc-mca.c the file smc-mca.h 
> was empty except for two #define's, I've also killed the rest of 
> smc-mca.h .

It looks like the structs should be 'static const', not just 'static'.

This comment is applicable to similar changes, also.  Use 'const' 
whenever possible.

	Jeff



