Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262400AbUCMCeV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 12 Mar 2004 21:34:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263028AbUCMCeU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 12 Mar 2004 21:34:20 -0500
Received: from fw.osdl.org ([65.172.181.6]:20181 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S262400AbUCMCeT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 12 Mar 2004 21:34:19 -0500
Date: Fri, 12 Mar 2004 18:34:23 -0800
From: Andrew Morton <akpm@osdl.org>
To: Marc Lehmann <pcg@schmorp.de>
Cc: linux-kernel@vger.kernel.org, Joe Thornber <thornber@redhat.com>,
       Neil Brown <neilb@cse.unsw.edu.au>
Subject: Re: strange ext3 corruption problem on 2.6.x
Message-Id: <20040312183423.71d7bbb9.akpm@osdl.org>
In-Reply-To: <20040313004707.GA389@schmorp.de>
References: <20040313004707.GA389@schmorp.de>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Marc Lehmann <pcg@schmorp.de> wrote:
>
>  I use lvm-over-raid5 and get these messages once a day (requiring a reboot
>  afterwards):
> 
>     EXT3-fs error (device dm-0): ext3_readdir: bad entry in directory #4804801: directory entry across blocks - offset=0, inode=0, rec_len=50000,
>     name_len=152
>     Aborting journal on device dm-0.

(and fsck comes up clean)

There have been earlier reports of this.  Too many for it to be some random
glitch.   We've had similar reports in 2.4, usually with raid5.

I'm fairly confident in ext3 - it's hard to think of an ext3-level bug
which wouldn't have 10x as many reports from non-md users.  But perhaps
some timing unique to the MD layer is triggering some ext3 bug.

Joe, Neil: have you spotted reports like this?  Any suggestions as to how
to track it down a bit?
