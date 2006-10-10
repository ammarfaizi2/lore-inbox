Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030480AbWJJVoJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030480AbWJJVoJ (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Oct 2006 17:44:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030482AbWJJVoJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Oct 2006 17:44:09 -0400
Received: from ug-out-1314.google.com ([66.249.92.173]:25468 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1030480AbWJJVoG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Oct 2006 17:44:06 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=uWJKb3WPaeX5W3p6U2xIrhH1y8Lx01MBLtHgINRhM/AZ5dR2lvIjseuIBQnii2pHHdTWsAYCjqnLvzAKF+Oi+BtW9TMIJDDzZRUL2pdku7QA0oKLF0tC47b7/RGZxhcD/bc3TVZ37Ga9X9NwsXQEwnCFFtbVh5+5LB+5+jgnlQk=
Message-ID: <6bffcb0e0610101444y5cf127c5y8a9e4c64640e0b8c@mail.gmail.com>
Date: Tue, 10 Oct 2006 23:44:04 +0200
From: "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com>
To: "Andrew Morton" <akpm@osdl.org>
Subject: Re: 2.6.19-rc1-mm1
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20061010120441.3cd3f8ff.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <20061010000928.9d2d519a.akpm@osdl.org>
	 <6bffcb0e0610100909t3a33d4ecwdae27a27b15d60e3@mail.gmail.com>
	 <20061010120441.3cd3f8ff.akpm@osdl.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/10/06, Andrew Morton <akpm@osdl.org> wrote:
> On Tue, 10 Oct 2006 18:09:31 +0200
> "Michal Piotrowski" <michal.k.k.piotrowski@gmail.com> wrote:
>
> > On 10/10/06, Andrew Morton <akpm@osdl.org> wrote:
> > >
> > > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.19-rc1/2.6.19-rc1-mm1/
> > >
> >
> > This looks strange
> > ps aux | grep t3
> > root      4305 81.6  0.1   5952  2596 pts/7    R+   17:54   2:44
> > python ./rt-tester.py t3-l1-pi-steal.tst
> > michal    4351  0.0  0.0   3908   760 pts/5    R+   17:58   0:00 grep t3
> > [michal@euridica ~]$ ps aux | grep creat
> > root      3934 87.3  0.0   1652   496 pts/4    R    17:25  28:37 creat05
> > michal    4353  0.0  0.0   3912   772 pts/5    S+   17:58   0:00 grep creat
> >
> > python ./rt-tester.py t3-l1-pi-steal.tst and creat05 (from LTP) are
> > always in running state (creat05 since 28 minutes). I don't have any
> > idea why this happens.
> >
>
> The fdtable patches might have some problems.
>
> http://userweb.kernel.org/~akpm/mp.bz2 is 2.6.19-rc1-mm1 without those
> patches.  Does it work better?

Yes, it does. Thanks.

BTW. Kernel hangs while running Cyclictest
(http://rt.wiki.kernel.org/index.php/Cyclictest)
cyclictest -t 10 -l 100000
(or "bin/autotest tests/cyclictest/control" in autotest). I don't see
nothing special on tty (currently my sysklogd is broken, FC6
problem..)

Regards,
Michal

-- 
Michal K. K. Piotrowski
LTG - Linux Testers Group
(http://www.stardust.webpages.pl/ltg/)
