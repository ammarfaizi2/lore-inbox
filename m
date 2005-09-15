Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030425AbVIOOtg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030425AbVIOOtg (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 15 Sep 2005 10:49:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030428AbVIOOtg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 15 Sep 2005 10:49:36 -0400
Received: from ns.ustc.edu.cn ([202.38.64.1]:61155 "EHLO mx1.ustc.edu.cn")
	by vger.kernel.org with ESMTP id S1030425AbVIOOtf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 15 Sep 2005 10:49:35 -0400
Date: Thu, 15 Sep 2005 22:52:53 +0800
From: WU Fengguang <wfg@mail.ustc.edu.cn>
To: Paolo Ornati <ornati@fastwebnet.it>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Adaptive read-ahead: benchmarks
Message-ID: <20050915145253.GA6040@mail.ustc.edu.cn>
Mail-Followup-To: WU Fengguang <wfg@mail.ustc.edu.cn>,
	Paolo Ornati <ornati@fastwebnet.it>, linux-kernel@vger.kernel.org
References: <20050915131651.GA5336@mail.ustc.edu.cn> <20050915162856.1fd5bb38@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050915162856.1fd5bb38@localhost>
User-Agent: Mutt/1.5.9i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 15, 2005 at 04:28:56PM +0200, Paolo Ornati wrote:
> On Thu, 15 Sep 2005 21:16:51 +0800
> WU Fengguang <wfg@mail.ustc.edu.cn> wrote:
> 
> > oprofile() {
> >         opcontrol --vmlinux=/temp/kernel/linux-2.6.13ra/vmlinux
> >         opcontrol --start
> >         opcontrol --reset
> >         echo $1 > /proc/sys/vm/readahead_ratio
> >         dd if=/temp/kernel/hugefile of=/dev/null bs=$bs
> >         opreport -l -o oprofile.$1.$bs /temp/kernel/linux-2.6.13ra/vmlinux
> >         opcontrol --stop
> > }
> 
> just a side note: shouldn't you umount and remount "/temp" to remove
> the pagecache? Or is the file so big that it doesn't matter?
Thanks for the reminding. I'm currently using huge files for testing:
# ll bigfile hugefile 
-rw-r--r--  2 root root 626M 2005-09-07 20:29 bigfile
-rw-r--r--  2 root root 3.7G 2005-09-11 11:24 hugefile
The umount tip seems nice and I'll use it for future testing :)
> 
> PS: instead of unmount/remount you can use "fadvise":
> http://www.zip.com.au/~akpm/linux/patches/stuff/ext3-tools.tar.gz
OK, I'll check it.
> 
> -- 
> 	Paolo Ornati
> 	Linux 2.6.14-rc1 on x86_64

-- 
WU Fengguang
Dept. of Automation
University of Science and Technology of China
Hefei, Anhui
