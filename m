Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261265AbTH2SJ6 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Aug 2003 14:09:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261350AbTH2SJ6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Aug 2003 14:09:58 -0400
Received: from adsl-63-194-239-202.dsl.lsan03.pacbell.net ([63.194.239.202]:30482
	"EHLO mmp-linux.matchmail.com") by vger.kernel.org with ESMTP
	id S261265AbTH2SJ4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Aug 2003 14:09:56 -0400
Date: Fri, 29 Aug 2003 11:09:57 -0700
From: Mike Fedyk <mfedyk@matchmail.com>
To: linux-kernel@vger.kernel.org
Subject: Re: mutt segfault with ext3 & 1k blocks & htree in 2.6
Message-ID: <20030829180957.GC27023@matchmail.com>
Mail-Followup-To: linux-kernel@vger.kernel.org
References: <20030829172451.GA27023@matchmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20030829172451.GA27023@matchmail.com>
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 29, 2003 at 10:24:51AM -0700, Mike Fedyk wrote:
> Hi,
> 
> I have just converted my 25GB / partition from reiserfs to ext3 with 1k
> blocks, and now mutt is segfaulting periodocally.
> 
> I suspect it is htree, because I left four mutt processes running last
> night, and two of them segfaulted.
> 
> Interestingly enough, it happened about 1 minute apart, so they might have
> checked one of the large maildir folders and that could have caused the
> problem, except that the other two mutt processes should have checked the
> same folders, and they didn't crash.
> 
> I have full strace output of each mutt process up until the segfault in two
> cases, and up until strace was stopped in the third case.
> 
> Please let me know what more I can do to help track this down.
> 
> I have tried this with:
> vmlinuz-2.6.0-test3-mm3
> vmlinuz-2.6.0-test4-mm1
> 

How do I:

 o Find out that a directory is using htree?
 o Disable htree on my /?  (tune2fs -O ^dir_index), but then how do I get my
   directories back to non-htree without running fsck from a rescue CD?

Thanks,

Mike
