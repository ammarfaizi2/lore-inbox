Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263402AbTLXBvo (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 23 Dec 2003 20:51:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263435AbTLXBvn
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 23 Dec 2003 20:51:43 -0500
Received: from fgwmail6.fujitsu.co.jp ([192.51.44.36]:63123 "EHLO
	fgwmail6.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S263357AbTLXBss (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 23 Dec 2003 20:48:48 -0500
Message-ID: <3FE8F079.7010906@labs.fujitsu.com>
Date: Wed, 24 Dec 2003 10:48:41 +0900
From: Tsuchiya Yoshihiro <tsuchiya@labs.fujitsu.com>
Reply-To: tsuchiya@labs.fujitsu.com
Organization: Fujitsu Labs
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.5) Gecko/20031007
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: filesystem bug?
References: <3FDD7DFD.7020306@labs.fujitsu.com>	 <1071582242.5462.1.camel@sisko.scot.redhat.com> <3FDF7BE0.205@jpl.nasa.gov>		 <3FDF95EB.2080903@labs.fujitsu.com> <3FE0E5C6.5040008@labs.fujitsu.com>	 <1071782986.3666.323.camel@sisko.scot.redhat.com>	 <3FE62999.90309@labs.fujitsu.com>  <3FE67362.2070704@labs.fujitsu.com> <1072094621.1967.6.camel@sisko.scot.redhat.com>
In-Reply-To: <1072094621.1967.6.camel@sisko.scot.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen C. Tweedie wrote:

>OK, I'll try your script with a 2.4.21 or 2.4.23 kernel to see if we can
>reproduce this here.  In the mean time, could you possibly try a 2.4.24
>kernel, just in case the clear_inode race has something to do with this?
>
>  
>
Stephen, I started running the test on ext2 and ext3 on 2.4.24-pre2.

BTW, what exactly is the clear_inode and read_inode race that you mentioned?

I am not familar with the locking model in Linux kernel. I found
kernel_lock is
held before ext3_rename/unlink/rmdir, so I think it's ok. But I do not
understand
how it is done in the path walk.

Thanks,
Yoshi

--
Yoshihiro Tsuchiya



