Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267409AbTACFxv>; Fri, 3 Jan 2003 00:53:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267408AbTACFxv>; Fri, 3 Jan 2003 00:53:51 -0500
Received: from mta5.snfc21.pbi.net ([206.13.28.241]:53640 "EHLO
	mta5.snfc21.pbi.net") by vger.kernel.org with ESMTP
	id <S267405AbTACFxu>; Fri, 3 Jan 2003 00:53:50 -0500
Date: Thu, 02 Jan 2003 22:07:29 -0800
From: David Brownell <david-b@pacbell.net>
Subject: Re: [linux-usb-devel] Re: 2.5.54 -- ohci-dbg.c: 358: In function
 `show_list': `data1' undeclared (first use in this function)
To: Greg KH <greg@kroah.com>
Cc: Miles Lane <miles.lane@attbi.com>, LKML <linux-kernel@vger.kernel.org>,
       Linus Torvalds <torvalds@transmeta.com>,
       usb devel <linux-usb-devel@lists.sourceforge.net>
Message-id: <3E1528A1.5030302@pacbell.net>
MIME-version: 1.0
Content-type: text/plain; charset=us-ascii; format=flowed
Content-transfer-encoding: 7BIT
X-Accept-Language: en-us, en, fr
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.9) Gecko/20020513
References: <1041487926.11532.83.camel@bellybutton.attbi.com>
 <3E145998.6020607@pacbell.net> <3E14DBDD.4080907@pacbell.net>
 <20030102204444.A2549@kroah.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Greg KH wrote:
> On Thu, Jan 02, 2003 at 04:39:57PM -0800, David Brownell wrote:
> 
>>+#if LINUX_VERSION_CODE > KERNEL_VERSION(2,5,32)
>>+#	define DRIVERFS_DEBUG_FILES
>>+#endif
> 
> 
> No, this is wrong, don't put this dependant on a specific kernel 
> version that is long gone, that's why I took this portion out.

Actually it originally there to support a backport of that version
to the 2.4 kernel, which has periodically worked.  That was the
downside of that particular patch of yours ... it didn't wrap the
dev_* calls as ohci_* calls, so the backport effort went up.

But OK, I'll remove that for now and resend.

- Dave


