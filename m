Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262961AbVCQCAn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262961AbVCQCAn (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Mar 2005 21:00:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262963AbVCQCAn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Mar 2005 21:00:43 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:39815 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262961AbVCQCAh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Mar 2005 21:00:37 -0500
Message-ID: <4238E4AC.8090104@pobox.com>
Date: Wed, 16 Mar 2005 21:00:12 -0500
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Ian Pilcher <i.pilcher@comcast.net>
CC: linux-kernel@vger.kernel.org
Subject: Re: [2/9] Possible AMD8111e free irq issue
References: <20050316235336.GY5389@shell0.pdx.osdl.net> <20050316235427.GA5389@shell0.pdx.osdl.net> <d1aicj$iq1$2@sea.gmane.org>
In-Reply-To: <d1aicj$iq1$2@sea.gmane.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian Pilcher wrote:
> Chris Wright wrote:
> 
>>
>> From: Andres Salomon <dilinger@debian.org>
>>
>> It seems to me that if in the amd8111e_open() fuction dev->irq isn't
>> zero and the irq request succeeds it might not get released anymore.
>>
> 
> Based on the wording above, I can't help wondering if this fixes a
> problem that anyone is actually seeing.


Maybe the wording is wrong, but the patch fixes an obvious 
leak-on-error.  Allocations in amd8111e_init_ring() could certainly fail.

	Jeff


