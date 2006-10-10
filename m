Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751103AbWJJTFG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751103AbWJJTFG (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 15:05:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751094AbWJJTFG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 15:05:06 -0400
Received: from smtp.osdl.org ([65.172.181.4]:50898 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751103AbWJJTFB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 15:05:01 -0400
Date: Tue, 10 Oct 2006 12:04:41 -0700
From: Andrew Morton <akpm@osdl.org>
To: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.19-rc1-mm1
Message-Id: <20061010120441.3cd3f8ff.akpm@osdl.org>
In-Reply-To: <6bffcb0e0610100909t3a33d4ecwdae27a27b15d60e3@mail.gmail.com>
References: <20061010000928.9d2d519a.akpm@osdl.org>
	<6bffcb0e0610100909t3a33d4ecwdae27a27b15d60e3@mail.gmail.com>
X-Mailer: Sylpheed version 2.2.7 (GTK+ 2.8.6; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 10 Oct 2006 18:09:31 +0200
"Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:

> On 10/10/06, Andrew Morton <akpm@osdl.org> wrote:
> >
> > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/
> >
> 
> This looks strange
> ps aux | grep t3
> root      4305 81.6  0.1   5952  2596 pts/7    R+   17:54   2:44
> python ./rt-tester.py t3-l1-pi-steal.tst
> michal    4351  0.0  0.0   3908   760 pts/5    R+   17:58   0:00 grep t3
> [michal@euridica ~]$ ps aux | grep creat
> root      3934 87.3  0.0   1652   496 pts/4    R    17:25  28:37 creat05
> michal    4353  0.0  0.0   3912   772 pts/5    S+   17:58   0:00 grep creat
> 
> python ./rt-tester.py t3-l1-pi-steal.tst and creat05 (from LTP) are
> always in running state (creat05 since 28 minutes). I don't have any
> idea why this happens.
> 

The fdtable patches might have some problems.

http://userweb.kernel.org/~akpm/mp.bz2 is 2.6.19-rc1-mm1 without those
patches.  Does it work better?  

Thanks.
