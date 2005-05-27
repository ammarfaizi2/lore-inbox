Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262527AbVE0Rfv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262527AbVE0Rfv (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 May 2005 13:35:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262540AbVE0Rfv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 May 2005 13:35:51 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:18910 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S262527AbVE0RfP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 May 2005 13:35:15 -0400
Date: Fri, 27 May 2005 10:34:55 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: Lee Revell <rlrevell@joe-job.com>
cc: Ingo Molnar <mingo@elte.hu>, linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: weird X problem - priority inversion?
In-Reply-To: <1117202510.13829.17.camel@mindpipe>
Message-ID: <Pine.LNX.4.62.0505271034010.14917@qynat.qvtvafvgr.pbz>
References: <1113428938.16635.13.camel@mindpipe><20050523075508.GC9287@elte.hu><Pine.LNX.4.62.0505230110240.7165@qynat.qvtvafvgr.pbz>
 <1117202510.13829.17.camel@mindpipe>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 27 May 2005, Lee Revell wrote:

> On Mon, 2005-05-23 at 01:11 -0700, David Lang wrote:
>> remember that the low pri screensaver is just generating the image to be
>> displayed, it's the high pri X server that's actually doing the work to
>> display it.
>
> Then there needs to be some mechanism to handle it, either in X or the
> kernel.  Other OSes do not require you to turn off the screensaver to
> avoid a DoS - they do the obvious thing and run the screensaver at the
> lowest priority.
>
> The problem may be software 3D rendering (I did not have the VIA driver
> enabled as I did not realize it was in the kernel yet).   Maybe the X
> server should do the work in a low priority thread.  But it sure
> shouldn't DoS the system.  Other OSes do not have this problem.

Actually they don't (or at least didn't the last time I took windows 
training), if you have a CPU intensive screen saver on a windows server it 
will seriously load down the box when it kicks in.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
