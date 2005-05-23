Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261153AbVEWWVN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261153AbVEWWVN (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 May 2005 18:21:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261158AbVEWWVN
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 May 2005 18:21:13 -0400
Received: from mailgw.cvut.cz ([147.32.3.235]:4818 "EHLO mailgw.cvut.cz")
	by vger.kernel.org with ESMTP id S261153AbVEWWVF (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 May 2005 18:21:05 -0400
Message-ID: <42925760.9010603@vc.cvut.cz>
Date: Tue, 24 May 2005 00:21:20 +0200
From: Petr Vandrovec <vandrove@vc.cvut.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.8) Gecko/20050513 Debian/1.7.8-1
X-Accept-Language: en
MIME-Version: 1.0
To: DervishD <lkml@dervishd.net>
CC: Jeff Garzik <jgarzik@pobox.com>,
       Linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [RESEND] Hard disk LBA sector count is not always the same
References: <20050523121424.GB339@DervishD> <42922175.8090005@pobox.com> <20050523200221.GE57@DervishD>
In-Reply-To: <20050523200221.GE57@DervishD>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

DervishD wrote:
>>DervishD wrote:
>>
>>>   current capacity is 156299375
>>>   native capacity is 156301488
>>
>>Hard drives have a feature that can reserve a certain amount of space 
>>away from the user.
> 
> 
>     Yes, I know, but the problem is that 2.4 kernels *does* reserve
> that space but 2.6 certainly not, and if I boot into 2.6 and then
> reboot into 2.4, then 2.4 *does NOT* reserve that space.

Yes.  It is normal...

>     See the paragraph above: if I partition the disk under 2.6 the
> partition will have a bigger address than the one that will be
> available under 2.4, and that can give errors while accessing that
> extra sectors. What can I do? For technical limitations in my box, I
> have to use 2.6 for repartitioning that disk (and I will be doing
> that in less than a month) and this will lead to unaccesible sectors
> when I boot back into my usual 2.4 kernel :(

(1) You do not have to create partition over full disk.

(2) If you'll build your 2.4.x kernel with CONFIG_IDEDISK_STROKE=y
('Auto-Geometry Resizing support'), I bet that your problems with 2.4.x
kernels disappear.
							Petr



