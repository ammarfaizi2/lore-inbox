Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S311043AbSCPWNo>; Sat, 16 Mar 2002 17:13:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S311023AbSCPWNe>; Sat, 16 Mar 2002 17:13:34 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:57861 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S311040AbSCPWNY>; Sat, 16 Mar 2002 17:13:24 -0500
Message-ID: <3C93C31E.A3025F63@zip.com.au>
Date: Sat, 16 Mar 2002 14:11:42 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.19-pre2 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: John McCutchan <ttb@tentacle.dhs.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: ext3_error()
In-Reply-To: <20020316194233.GA26338@tentacle.dhs.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

John McCutchan wrote:
> 
> Hello,
> 
> I got this in my kern.log file:
> 
> Feb 20 00:41:00 golbez kernel: ext3_free_blocks: Freeing blocks not in datazone
> - block = 538082710, count = 1
> 
> What could be the cause of this?
> 

Bad things.   Something somewhere has corrupted in-core or
on-disk allocation tables.

Any time anything like this comes out of a filesystem,  it's
time to shut everything off and run fsck.

-
