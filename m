Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265980AbUAKVBO (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 11 Jan 2004 16:01:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265983AbUAKVBO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 11 Jan 2004 16:01:14 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:37536 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S265980AbUAKVBN
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 11 Jan 2004 16:01:13 -0500
Message-ID: <4001B979.1080600@pobox.com>
Date: Sun, 11 Jan 2004 16:00:41 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4) Gecko/20030703
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [I810_AUDIO] 1/x: Fix wait queue race in drain_dac
References: <20031122070931.GA27231@gondor.apana.org.au>
In-Reply-To: <20031122070931.GA27231@gondor.apana.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> Hi:
> 
> This is the first of a number of patches to fix DMA bugs in the
> OSS i810_audio driver.
> 
> This particular one fixes a textbook race condition in drain_dac
> that causes it to timeout when it shouldn't.

Herbert,

Thanks much for these i810_audio patches.  I've been meaning to review 
them in-depth for some time.

Could you be kind and "spell out" the patch-1 race for me?

Also, it seems to me that you would want to check for signal_pending()
(a) just after the schedule_timeout(), and
(b) -after- testing the 'signals_allowed' variable  ;-)

Comments?

	Jeff



