Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030587AbWJaIhS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030587AbWJaIhS (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 03:37:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030581AbWJaIhR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 03:37:17 -0500
Received: from einhorn.in-berlin.de ([192.109.42.8]:33223 "EHLO
	einhorn.in-berlin.de") by vger.kernel.org with ESMTP
	id S1030587AbWJaIhQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 03:37:16 -0500
X-Envelope-From: stefanr@s5r6.in-berlin.de
Message-ID: <45470B23.6070901@s5r6.in-berlin.de>
Date: Tue, 31 Oct 2006 09:36:51 +0100
From: Stefan Richter <stefanr@s5r6.in-berlin.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.6) Gecko/20060730 SeaMonkey/1.0.4
MIME-Version: 1.0
To: maneesh@in.ibm.com
CC: linux-kernel@vger.kernel.org, Greg KH <gregkh@suse.de>
Subject: Re: NULL pointer dereference in sysfs_readdir
References: <4539DDC5.80207@s5r6.in-berlin.de> <20061030123605.GA19814@in.ibm.com>
In-Reply-To: <20061030123605.GA19814@in.ibm.com>
X-Enigmail-Version: 0.94.1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Maneesh Soni wrote on 2006-10-30:
> On Sat, Oct 21, 2006 at 10:43:49AM +0200, Stefan Richter wrote:
...
>> A quick look at linux-2.6.19-rc2/fs/sysfs/dir.c::sysfs_readdir shows a
>> list_move, a traversal through a list, and some accesses to data with no
>> apparent protection by mutexes.
>>
> Most of the sysfs locking is done by parent inode's i_mutex. And for
> sysfs_readdir(), i_mutex is held at VFS layer in vfs_readdir().

OK, thanks.

> If this is not happening during boot, could you please recreate the
> oops with at kdump? I guess kdump should work well on FC.

The report came from someone else; I notified him. I cannot reproduce
it, I don't have FC nor hald. BTW the reporter mentioned that the
machine freezes completely much more often than merely throwing an oops.
(Both caused by hald.)

> (http://fedoraproject.org/wiki/FC6KdumpKexecHowTo?highlight=%28FC6KdumpKexecHowTo%29)
> 
>> Is there reason to be worried...?
> 
> Though locking looks fine to me.. but oops is a reason enough to
> be worried about.

I referred to the locking. :-) Thanks for the hints,
-- 
Stefan Richter
-=====-=-==- =-=- =====
http://arcgraph.de/sr/
