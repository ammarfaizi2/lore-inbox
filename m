Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266386AbUG0P1x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266386AbUG0P1x (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jul 2004 11:27:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266389AbUG0P1x
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jul 2004 11:27:53 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:24193 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S266386AbUG0P0g
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jul 2004 11:26:36 -0400
Message-ID: <41067418.9020000@pobox.com>
Date: Tue, 27 Jul 2004 11:26:16 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dominik Karall <dominik.karall@gmx.net>
CC: Linux Kernel ML <linux-kernel@vger.kernel.org>,
       Daniele Venzano <webvenza@libero.it>
Subject: Re: SiS900: NULL pointer encountered in Rx ring, skipping
References: <200407232052.06616.dominik.karall@gmx.net>
In-Reply-To: <200407232052.06616.dominik.karall@gmx.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dominik Karall wrote:
> After a few hours my network doesn't work on my laptop. There appear a lot of 
> those messages:
> 
> eth0: NULL pointer encountered in Rx ring, skipping
> eth0: NULL pointer encountered in Rx ring, skipping
> eth0: NULL pointer encountered in Rx ring, skipping
> eth0: NULL pointer encountered in Rx ring, skipping
> eth0: NULL pointer encountered in Rx ring, skipping
> eth0: NULL pointer encountered in Rx ring, skipping
> eth0: NULL pointer encountered in Rx ring, skipping
> eth0: NULL pointer encountered in Rx ring, skipping
> eth0: NULL pointer encountered in Rx ring, skipping
> eth0: NULL pointer encountered in Rx ring, skipping
> 
> It works again after restarting network. I'm using 2.6.8-rc2 now. It was the 
> same problem in 2.6.7, but I didn't test it with earlier kernels.

A NULL appears when the machine is temporarily unable to allocate room 
for a new skb.  Your machine's atomic memory pools are getting too low...

	Jeff



