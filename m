Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264965AbUGZKzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264965AbUGZKzM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Jul 2004 06:55:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265027AbUGZKzM
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Jul 2004 06:55:12 -0400
Received: from smtp106.mail.sc5.yahoo.com ([66.163.169.226]:18839 "HELO
	smtp106.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S264965AbUGZKzH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Jul 2004 06:55:07 -0400
Message-ID: <4104E307.1070004@yahoo.com.au>
Date: Mon, 26 Jul 2004 20:55:03 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7) Gecko/20040707 Debian/1.7-5
X-Accept-Language: en
MIME-Version: 1.0
To: Jan-Frode Myklebust <janfrode@parallab.uib.no>
CC: linux-kernel@vger.kernel.org
Subject: Re: OOM-killer going crazy. (was: Re: memory not released after using
 cdrecord/cdrdao)
References: <20040725094605.GA18324@zombie.inka.de> <41045EBE.8080708@comcast.net> <20040726091004.GA32403@ii.uib.no>
In-Reply-To: <20040726091004.GA32403@ii.uib.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Frode Myklebust wrote:
> On Sun, Jul 25, 2004 at 09:30:38PM -0400, Ed Sweetman wrote:
> 
>>Indeed, i burned a smaller cd and got very similar results.  
> 
> 
> Same here.. After upgrading to 2.6.8-rc2 the OOM-killer is going crazy.
> It's particularly angry at the backup client 'dsmc' (from Tivoli Storage
> Manager).  I'm monitoring its usage with 'top', and 'dsmc' is not using
> more than ~150MB in either size or RSS when the OOM-killer takes it down.
> 
> The 'dsmc'-process is reporting that it's processed 2,719,000 files, and
> transfered 164.34 MB when it gets killed. i.e. it's traversed a lot of
> files, but only read about 164 MB data, so it shouldn't have filled up any
> buffer cache... 
> 
> The system still has lots of free memory (~900 MB), and also 2 GB of
> unused swap. Actually there's 0K used swap..??  
> 
> I've tried turning on vm.overcommit_memory, but it had no effect. Also
> tried changing the swappiness both up to 90% and down to 10%, but it
> never uses any swap.. ???
> 
> BTW: I had no OOM-killer problems on 2.6.7.
> 

Can you just check you CONFIG_SWAP is on and /proc/sys/vm/laptop_mode is 0,
and that you have some swap enabled.

If the problem persists, can you send a copy each of /proc/sys/fs/dentry-state,
/proc/slabinfo and /proc/vmstat before and after you run dsmc until it goes
OOM please?

Thanks.
