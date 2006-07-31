Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932152AbWGaG6u@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932152AbWGaG6u (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 31 Jul 2006 02:58:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932501AbWGaG6u
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 31 Jul 2006 02:58:50 -0400
Received: from rzcomm12.rz.tu-bs.de ([134.169.9.59]:30446 "EHLO
	rzcomm12.rz.tu-bs.de") by vger.kernel.org with ESMTP
	id S932152AbWGaG6t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 31 Jul 2006 02:58:49 -0400
Message-ID: <44CDAA0E.5080607@l4x.org>
Date: Mon, 31 Jul 2006 08:58:22 +0200
From: Jan Dittmer <jdi@l4x.org>
User-Agent: Mozilla Thunderbird 1.0.6 (Windows/20050716)
X-Accept-Language: de-DE, de, en-us, en
MIME-Version: 1.0
To: Nathan Scott <nathans@sgi.com>
CC: kernel <linux@idccenter.cn>, linux-kernel@vger.kernel.org, xfs@oss.sgi.com
Subject: Re: XFS Bug null pointer dereference in xfs_free_ag_extent
References: <44BF29CD.1000809@l4x.org> <44CB0BF7.6030204@idccenter.cn> <44CB1303.7010303@l4x.org> <20060731094424.E2280998@wobbly.melbourne.sgi.com>
In-Reply-To: <20060731094424.E2280998@wobbly.melbourne.sgi.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nathan Scott schrieb:
> Hi there,
> 
> On Sat, Jul 29, 2006 at 09:49:23AM +0200, Jan Dittmer wrote:
> 
>>kernel schrieb:
>>
>>>I have the same problem, but it seems not have a patch right now.
>>
>>No, I got zero feedback, but let's cc the correct
>>mailing list. I also filed bug 6877 at kernel.org
>>
> 
> 
> Is this easily reproducible for you?  I've not seen it before, and
> the only possibly related recent changes I can think of are these:
> 
> http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=e63a3690013a475746ad2cea998ebb534d825704
> 
> http://git.kernel.org/git/?p=linux/kernel/git/torvalds/linux-2.6.git;a=commit;h=d210a28cd851082cec9b282443f8cc0e6fc09830
> 
> Could you try reverting each of those to see if either is the cause?

No, the XFS partition in question is gone due to the infamous
endian bug in 2.6.17. I only saw the error once. Hardware is
4 sata drives on a sil-something controller with software
raid5. No lvm. But the error reads like a rename race of some
kind?

Jan
