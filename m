Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261738AbULGJrC@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261738AbULGJrC (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 7 Dec 2004 04:47:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261721AbULGJrC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 7 Dec 2004 04:47:02 -0500
Received: from ns1.enidan.ch ([217.8.216.11]:33005 "EHLO mail.local.net")
	by vger.kernel.org with ESMTP id S261738AbULGJqr convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 7 Dec 2004 04:46:47 -0500
From: Per Jessen <per@computer.org>
To: linux-kernel@vger.kernel.org
Subject: Re: 2.4.28 - kswapd excessive cpu usage under heavy IO
Date: Tue, 7 Dec 2004 10:14:27 +0100
User-Agent: KMail/1.5.4
Organization: n/a
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 8BIT
Content-Disposition: inline
Message-Id: <200412071014.27925.per@computer.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marcelo Tosatti wrote:

> What is your workload? Except the massive amount of inode's/dentries in your
> system do you have anonymous memory hungry applications running?

Nope, workload is typically 6-7, with probably named being the most memory-hungry. 

> If you do have a significant amount of anonymous pages on your system you
> might want to try 2.4.29-pre1 which contains a VM change which should decrease
> their impact on the VM page freeing efforts (including kswapd CPU usage).
> 
> Since you have massive amount of inodes/dentries you might want to tweak
> /proc/sys/vm/vm_vfs_scan_ratio (increase from 6 to 10 and so on...)

OK, will try that.

>>A find in a directory containing perhaps 6-700,000 files makes the box almost
>> grind to a halt.  In 12days uptime, kswap has used 590:43.82, and during the
>> find-exercise usually runs with 90-100% util.
> 
> Can you boot with profile=2 and use readprofile tool to read the functions
> which are using most CPU time with
> 
> readprofile | sort -nr +2 | head -20
> Do that on a 2.4.28 and 2.4.29-pre1 kernels.

Will be difficult - I'll keep this in mind, but a reboot is not possible at the moment.

Many thanks for getting back to me - much appreciated!  


-- 
Per Jessen, Zurich
http://www.spamcek.com - let your spam stop here.

