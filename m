Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265250AbTAWORa>; Thu, 23 Jan 2003 09:17:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265270AbTAWOR3>; Thu, 23 Jan 2003 09:17:29 -0500
Received: from angband.namesys.com ([212.16.7.85]:1152 "HELO
	angband.namesys.com") by vger.kernel.org with SMTP
	id <S265250AbTAWOR3>; Thu, 23 Jan 2003 09:17:29 -0500
Date: Thu, 23 Jan 2003 17:26:38 +0300
From: Oleg Drokin <green@namesys.com>
To: Hugh Dickins <hugh@veritas.com>
Cc: linux-kernel@vger.kernel.org, akpm@digeo.com
Subject: Re: ext2 FS corruption with 2.5.59.
Message-ID: <20030123172638.A821@namesys.com>
References: <20030123153832.A860@namesys.com> <Pine.LNX.4.44.0301231402290.1589-100000@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0301231402290.1589-100000@localhost.localdomain>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On Thu, Jan 23, 2003 at 02:09:12PM +0000, Hugh Dickins wrote:
> >     My test consists of running "fsx -c 1234 testfile", "iozone -a",
> >     "dbench 60", "fsstress -p10 -n1000000 -d ." at the same time on the
> >     tested FS.
> >     fsx usually breaks just when dbench is finished.
> It was "dbench 100" which led me to investigate and post patch below
> a couple of days ago: worth trying again with this patch applied.

I thought your patch only fixes stuff with insufficient space and/or IO
errors.
Anyway I applied the patch and still can reproduce the problem.

Also I decided to run same test with ext3 and it deadlocked.
This time it was not absolutely vanilla kernel, so I am going to try it on
vanilla kernel and report back if it will be reproducable there.
(with stacktraces)

Bye,
    Oleg
