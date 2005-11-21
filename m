Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932146AbVKUBMa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932146AbVKUBMa (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 20:12:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932156AbVKUBMa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 20:12:30 -0500
Received: from stat9.steeleye.com ([209.192.50.41]:55508 "EHLO
	hancock.sc.steeleye.com") by vger.kernel.org with ESMTP
	id S932146AbVKUBMa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 20:12:30 -0500
Message-ID: <43811EEE.30100@steeleye.com>
Date: Sun, 20 Nov 2005 20:12:14 -0500
From: Paul Clements <paul.clements@steeleye.com>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: akpm@osdl.org, djani22@dynamicweb.hu,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [NBD] Use per-device semaphore instead of BKL
References: <200511190345.jAJ3jFC3016406@shell0.pdx.osdl.net> <437F4C85.3070108@steeleye.com> <20051119223419.GA1751@gondor.apana.org.au> <20051120015807.GA3593@gondor.apana.org.au> <4380B015.9060005@steeleye.com> <20051120204325.GB11043@gondor.apana.org.au> <4380EDBF.7090107@steeleye.com> <20051120220820.GA11920@gondor.apana.org.au>
In-Reply-To: <20051120220820.GA11920@gondor.apana.org.au>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> On Sun, Nov 20, 2005 at 04:42:23PM -0500, Paul Clements wrote:
> 
>>nbd-client -d (disconnect) is the main reason -- this functionality 
>>would be broken if we didn't allow ioctls anymore
> 
> 
> Good point.  In fact my initial patch missed a pair of locks around
> this case as well.  Here is a patch to move NBD_DISCONNECT outside
> the ioctl_lock and add a tx_lock around it.

Yep, I think that will do it. I'll test these two patches some and let 
you know if I see any problems.

Thanks again.

--
Paul

