Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290122AbSAKV3C>; Fri, 11 Jan 2002 16:29:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290121AbSAKV2w>; Fri, 11 Jan 2002 16:28:52 -0500
Received: from tomts6.bellnexxia.net ([209.226.175.26]:33783 "EHLO
	tomts6-srv.bellnexxia.net") by vger.kernel.org with ESMTP
	id <S290122AbSAKV2i>; Fri, 11 Jan 2002 16:28:38 -0500
Content-Type: text/plain; charset=US-ASCII
From: Ed Tomlinson <tomlins@cam.org>
Organization: me
To: <mingo@elte.hu>
Subject: Re: [patch] O(1) scheduler-H6 and nice +19
Date: Fri, 11 Jan 2002 16:28:33 -0500
X-Mailer: KMail [version 1.3.2]
In-Reply-To: <Pine.LNX.4.33.0201111723260.3212-100000@localhost.localdomain>
In-Reply-To: <Pine.LNX.4.33.0201111723260.3212-100000@localhost.localdomain>
Cc: linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <20020111212834.D36DFBA489@oscar.casa.dyndns.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On January 11, 2002 11:24 am, you wrote:
> On Wed, 9 Jan 2002, Ed Tomlinson wrote:
> > Noticed something about tasks running with nice 19.  They seem to
> > always get 25-35% of the cpu.  This happens with kernel compiles and
> > some other benchmarking processes.  If I kill the setiathome task, the
> > other processes shoot up to 90% and above.
>
> why dont you run the setiathome task at nice +19? that way it'll share CPU
> time with other niced processes.

Setiathome _is_ running at nice +19...  The H6 version cured the 2.4.17 boot
problem here.  Here are some numbers (H6) for you to consider:

make bzImage with setiathome running nice +19

make bzImage  391.11s user 30.85s system 62% cpu 11:17.37 total

make bzImage alone

make bzImage  397.33s user 32.14s system 92% cpu 7:43.58 total

Notice the large difference in run times...

System is: UP K6-III 400, 512M

Ed Tomlinson

