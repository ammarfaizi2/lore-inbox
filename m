Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261388AbVDZIyx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261388AbVDZIyx (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 26 Apr 2005 04:54:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261401AbVDZIyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 26 Apr 2005 04:54:52 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:29646 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261388AbVDZIyu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 26 Apr 2005 04:54:50 -0400
Date: Tue, 26 Apr 2005 14:24:48 +0530
From: Vivek Goyal <vgoyal@in.ibm.com>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: Nagesh Sharyathi <sharyathi@in.ibm.com>, vgoyal@in.ibm.com, akpm@osdl.org,
       ebiederm@xmission.com, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org, maneesh@in.ibm.com
Subject: Re: [Fastboot] Re: Kdump Testing
Message-ID: <20050426085448.GB4234@in.ibm.com>
Reply-To: vgoyal@in.ibm.com
References: <1114227003.4269c13be5f8b@imap.linux.ibm.com> <OFB57B3D45.D8C338C5-ON65256FEE.0042F961-65256FEE.0043D4CB@in.ibm.com> <20050425160925.3a48adc5.rddunlap@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050425160925.3a48adc5.rddunlap@osdl.org>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> 
> 2.6.12-rc2-mm3 reboots vmlinux-recover-UP on panic.
> (vmlinux-recover-SMP hangs during [early] reboot, but -UP
> goes further....)
> 
> (BTW, how does I do serial console from the second
> kernel...?  It has the drivers, but not the command
> line info?  TBD.)
> 


While pre-loading the capture kernel using kexec, you can specify the command
line options to second kernel using --append="". You must already be passing
the root device. Add you serial console parameters as well something like
--append="console=ttyS0, 38400"


> vmlinux-recover-UP gets to this point, hand-written,
> several lines missing:
> 
> kfree_debugcheck: bad ptr c3dbffb0h.  ( == %esi)
> kernel BUG at <bad filename>:23128!
> invalid operand: 0000 [#1]
> DEBUG_PAGEALLOC
> EIP is at kfree_debugcheck+0x45/0x50
> 
> Stack dump shows lots of ext3 cache and inode functions...
> 

Can you post a full serial console output of second kernel? That would help.

Thanks
Vivek

