Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261613AbSJANDP>; Tue, 1 Oct 2002 09:03:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261614AbSJANDO>; Tue, 1 Oct 2002 09:03:14 -0400
Received: from inet-mail4.oracle.com ([148.87.2.204]:6562 "EHLO
	inet-mail4.oracle.com") by vger.kernel.org with ESMTP
	id <S261613AbSJANDJ>; Tue, 1 Oct 2002 09:03:09 -0400
Message-ID: <3D999E04.20805@oracle.com>
Date: Tue, 01 Oct 2002 15:07:16 +0200
From: Alessandro Suardi <alessandro.suardi@oracle.com>
Organization: Oracle Consulting Premium Services
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.0.1) Gecko/20020918
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: zlatko.calusic@iskon.hr
CC: akpm@zip.com.au, hugh@veritas.com, linux-kernel@vger.kernel.org
Subject: Re: Shared memory shmat/dt not working well in 2.5.x
References: <dny99icwp0.fsf@magla.zg.iskon.hr>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Zlatko Calusic wrote:
> Hi, Andrew, Hugh & others.
> 
> Still having problems with Oracle on 2.5.x (it can't even be started),

[snip]

Just wanted to add that I can't provide further info about which
  kernel broke it... updated map:

  2.5.34 kernel okay, Oracle works
  2.5.35 kernel doesn't compile
  2.5.36 oops on linux kernel boot, frozen
  2.5.37 oops on linux kernel boot, SysRQ works
  2.5.38 kernel okay, Oracle OOMs
  2.5.39  as 2.5.38
  2.5.40 kernel.org down, no mirrors carrying it yet

My box is a dell latitude CPx750J, PIII CPU, 256M RAM / 512MB swap
  all on ext3fs, mounted rw,noatime except of course for /dev/shm
  which is tmpfs. UP kernel, preempt is on, hugetlb is off.

As I told Andrew in private email, the Oracle shm segment is created,
  the background processes forked but the SQL*Plus child which should
  perform the database open after checking datafiles and obviously
  attaching the shm segment (about 50MB of it) gets killed by OOM.

--alessandro

  "everything dies, baby that's a fact
    but maybe everything that dies someday comes back"
        (Bruce Springsteen, "Atlantic City")

