Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751202AbWBVMFo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbWBVMFo (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 22 Feb 2006 07:05:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751216AbWBVMFo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 22 Feb 2006 07:05:44 -0500
Received: from mail2.designassembly.de ([217.11.62.46]:60611 "EHLO
	mail2.designassembly.de") by vger.kernel.org with ESMTP
	id S1751202AbWBVMFn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 22 Feb 2006 07:05:43 -0500
Message-ID: <43FC5393.3080702@designassembly.de>
Date: Wed, 22 Feb 2006 13:05:39 +0100
From: Michael Heyse <mhk@designassembly.de>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Herbert Xu <herbert@gondor.apana.org.au>
CC: kernel list <linux-kernel@vger.kernel.org>
Subject: Re: which one is broken: VIA padlock aes or aes_i586?
References: <43FB0746.5010200@designassembly.de> <20060222013137.GA844@gondor.apana.org.au> <20060222114531.GA4170@gondor.apana.org.au>
In-Reply-To: <20060222114531.GA4170@gondor.apana.org.au>
X-Enigmail-Version: 0.93.0.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Herbert Xu wrote:
> On Wed, Feb 22, 2006 at 12:31:37PM +1100, herbert wrote:
> 
>>I don't think this patch is your problem since it's part of the multiblock
>>code which doesn't exist in 2.6.12 at all.  Of course the multiblock code
>>itself could be buggy.  I'll take a look.
> 
> 
> OK I can't reproduce this.  Please send me your dmcrypt setup line so
> I can try it here.

I'm using the cryptsetup tool (from http://www.saout.de/misc/dm-crypt/):

echo $KEY | cryptsetup -c aes-cbc-essiv:sha256 -h plain -s 256 create data /dev/vg0/data

$KEY contains 32 bytes of binary data. Do you need any other information? Here's all I can think of:

- parition /dev/vg0/data lies on a lvm2 volume group
- this volume group lies on a 4-disk software-raid 5 array
- size of the partition is 300 GB
- padlock aes works on kernel 2.6.15.4 but not on 2.6.16-rc1
- aes_i586 works on all kernels

Thanks,
Michael
