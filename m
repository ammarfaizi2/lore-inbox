Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264444AbUASHxC (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Jan 2004 02:53:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264445AbUASHxC
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Jan 2004 02:53:02 -0500
Received: from fgwmail7.fujitsu.co.jp ([192.51.44.37]:35041 "EHLO
	fgwmail7.fujitsu.co.jp") by vger.kernel.org with ESMTP
	id S264444AbUASHw4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Jan 2004 02:52:56 -0500
Message-ID: <400B8CD4.8000503@labs.fujitsu.com>
Date: Mon, 19 Jan 2004 16:52:52 +0900
From: Tsuchiya Yoshihiro <tsuchiya@labs.fujitsu.com>
Reply-To: tsuchiya@labs.fujitsu.com
Organization: Fujitsu Labs
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Stephen C. Tweedie" <sct@redhat.com>
CC: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: filesystem bug?
References: <4007537F.4070609@labs.fujitsu.com> <1074256175.4006.24.camel@sisko.scot.redhat.com>
In-Reply-To: <1074256175.4006.24.camel@sisko.scot.redhat.com>
Content-Type: text/plain; charset=ISO-2022-JP
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

Stephen C. Tweedie wrote:

>OK.  Under exactly what circumstances have you seen this in the past, as
>opposed to the other problem?  I have not been able to reproduce this
>one so far.
>  
>

The combinations of kernel versions and filesystem types are:
2.4.20-8 ext2
2.4.20-19.9 ext2, ext3
2.4.20-24.9 ext2
2.4.20-28.9 ext2

I do the test with mozilla-1.3.tar.gz and 6 processes in the script,
it happens with ext2 within a few hours.

I haven't seen the problem on 2.4.20,23 and 24.

So now I am testing followings:
2.4.24-pre2 ext2 (mozilla-1.3.tar.gz)
2.4.24 ext2 (nvi-1.79.tar.gz)
2.4.20 ext3 (mozilla-1.3.tar.gz)
2.4.23 ext3 (mozilla-1.3.tar.gz)
2.4.24 ext3 (mozilla-1.3.tar.gz)
2.4.20-28.9 ext3 (mozilla-1.3.tar.gz)

Other than 2.4.20-28.9, since they have been running for three days,
they seems nice at this point.

What exactly is the race condition between read_inode() and
clear_inode() you have
mentioned?

Thanks,
Yoshi
-- 
--
Yoshihiro Tsuchiya


