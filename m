Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262906AbUCRTpv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Mar 2004 14:45:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262905AbUCRTpv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Mar 2004 14:45:51 -0500
Received: from mailgate2.mysql.com ([213.136.52.47]:45957 "EHLO
	mailgate.mysql.com") by vger.kernel.org with ESMTP id S262903AbUCRTpJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Mar 2004 14:45:09 -0500
Subject: Re: True  fsync() in Linux (on IDE)
From: Peter Zaitsev <peter@mysql.com>
To: Jens Axboe <axboe@suse.de>
Cc: Linux Kernel <linux-kernel@vger.kernel.org>
In-Reply-To: <20040318064757.GA1072@suse.de>
References: <1079572101.2748.711.camel@abyss.local>
	 <20040318064757.GA1072@suse.de>
Content-Type: text/plain
Organization: MySQL
Message-Id: <1079639060.3102.282.camel@abyss.local>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 
Date: Thu, 18 Mar 2004 11:44:21 -0800
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-03-17 at 22:47, Jens Axboe wrote:

> > There is solution just to disable drive write cache, but it seems to
> > slowdown performance way to much.
> 
> Chris and I have working real fsync() with the barrier patches. I'll
> clean it up and post a patch for vanilla 2.6.5-rc today.

Good to hear. How is it going to work from user point of view ? 
Just fsync working back again or there would be some special handling.

Also. What is about  fsync() in 2.6 nowadays ?

I've done some tests on 3WARE RAID array and it looks like  it is
different compared to 2.4 I've been testing previously. 

I have the simple test which has single page writes to the file followed
by fsync().   First run give you the case when file grows with each
write, second when you're writing to existing file space.

The results I have on 2.4 is something like  40 sec per 1000 fsyncs for 
new file, and 0.6 sec for existing file.

With 2.6.3 I have  both existing file and new file to complete in less
than 1 second. 







-- 
Peter Zaitsev, Senior Support Engineer
MySQL AB, www.mysql.com

Meet the MySQL Team at User Conference 2004! (April 14-16, Orlando,FL)
  http://www.mysql.com/uc2004/

