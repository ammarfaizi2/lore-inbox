Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265680AbUFYMQN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265680AbUFYMQN (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 25 Jun 2004 08:16:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265548AbUFYMQM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 25 Jun 2004 08:16:12 -0400
Received: from sccrmhc12.comcast.net ([204.127.202.56]:5596 "EHLO
	sccrmhc12.comcast.net") by vger.kernel.org with ESMTP
	id S264821AbUFYMPa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 25 Jun 2004 08:15:30 -0400
Message-ID: <40DC1757.80405@comcast.net>
Date: Fri, 25 Jun 2004 08:15:19 -0400
From: David van Hoose <david.vanhoose@comcast.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040510
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Helge Hafting <helge.hafting@hist.no>,
       John Richard Moser <nigelenki@comcast.net>,
       linux-kernel@vger.kernel.org
Subject: Re: Collapse ext2 and 3 please
References: <40DB605D.6000409@comcast.net> <40DBED77.6090704@hist.no> <40DC0CE0.6040509@comcast.net> <20040625114105.GA28892@infradead.org> <40DC1192.7030006@comcast.net> <20040625121023.GA29274@infradead.org>
In-Reply-To: <20040625121023.GA29274@infradead.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Fri, Jun 25, 2004 at 07:50:42AM -0400, David van Hoose wrote:
> 
>>yeah.. Really. Here's what I do.
>>
>>I have ext3 partitions, so I decided if they are different partitions, 
>>then I can compile my kernel with ext2 as a module and ext3 builtin.
>>So I do it and reboot. Panic! Reason? Cannot find filesystem for the 
>>root partition.
>>The error is in the kernel itself either way. Pick your reason.
>>1) ext3 is identified as ext2 on bootup.
>>2) There is no fallback to ext3 if ext2 is not found.
> 
> 
> Doesn't make sense.  The kernel just tries all registered filesystems
> for the rootfs until one clames it.  It means you either:
> 
>  - don't actually have ext3 in the kernel or
>  - the filesystems actually is ext2 and not ext3
> 
> Try calling debugfs /dev/$ROOTDEVICE and then typing features, what does it
> say?

[root@bahamut root]# /sbin/debugfs /dev/sda2
debugfs 1.35 (28-Feb-2004)
debugfs:  features
Filesystem features: has_journal filetype needs_recovery sparse_super
debugfs:  quit
[root@bahamut root]#

Is that sufficient for you?

Regards,
David
