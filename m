Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261763AbUCGGGW (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Mar 2004 01:06:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261760AbUCGGGW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Mar 2004 01:06:22 -0500
Received: from agminet01.oracle.com ([141.146.126.228]:64473 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S261763AbUCGGGT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Mar 2004 01:06:19 -0500
Date: Sat, 6 Mar 2004 22:06:04 -0800
From: Wim Coekaerts <wim.coekaerts@oracle.com>
To: Peter Zaitsev <peter@mysql.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Any way to access huge pages ?
Message-ID: <20040307060604.GB27076@ca-server1.us.oracle.com>
References: <1078636886.2313.718.camel@abyss.local>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1078636886.2313.718.camel@abyss.local>
User-Agent: Mutt/1.5.5.1+cvs20040105i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

well thats where you have hugetlbfs
and you mmap a file in /dev/hugetlbfs or whever it goes
works fine

or shmfs but the its not large pages I guess, unless you have the
bigpages feature in the vendor versions. like bigpages in rhas21 can be
for shmfs. 

On Sat, Mar 06, 2004 at 09:21:28PM -0800, Peter Zaitsev wrote:
> Hello,
> 
> I'm wondering is there any way to access "large pages" (4MB) memory
> other than using shared memory ?  For example can you do anonymous mmap
> to get access to large pages. 
> 
> I would like to utilize large pages for MySQL buffer pool and other
> large caches, but would not like to use Shared memory for this purpose 
> as it will complicate things for users. 
> 
> 
> -- 
> Peter Zaitsev, Senior Support Engineer
> MySQL AB, www.mysql.com
> 
> Meet the MySQL Team at User Conference 2004! (April 14-16, Orlando,FL)
>   http://www.mysql.com/uc2004/
> 
> -
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
