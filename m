Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1945901AbWBCTO1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1945901AbWBCTO1 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Feb 2006 14:14:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1945900AbWBCTO1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Feb 2006 14:14:27 -0500
Received: from EXCHG2003.microtech-ks.com ([65.16.27.37]:44567 "EHLO
	EXCHG2003.microtech-ks.com") by vger.kernel.org with ESMTP
	id S1945904AbWBCTOZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Feb 2006 14:14:25 -0500
From: "Roger Heflin" <rheflin@atipa.com>
To: "'Brian D. McGrew'" <brian@visionpro.com>, <linux-kernel@vger.kernel.org>
Subject: RE: Stale NFS File Handle
Date: Fri, 3 Feb 2006 13:24:56 -0600
MIME-Version: 1.0
Content-Type: text/plain;
	charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook, Build 11.0.5510
In-Reply-To: <14CFC56C96D8554AA0B8969DB825FEA0970A93@chicken.machinevisionproducts.com>
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2800.1165
Thread-Index: AcYo7Gs5yqxpa+ehReWCAFGoyFjq2AAClPCg
Message-ID: <EXCHG2003OxJagXTi8M000011fa@EXCHG2003.microtech-ks.com>
X-OriginalArrivalTime: 03 Feb 2006 19:07:40.0938 (UTC) FILETIME=[1ADC46A0:01C628F5]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 

> -----Original Message-----
> From: linux-kernel-owner@vger.kernel.org 
> [mailto:linux-kernel-owner@vger.kernel.org] On Behalf Of 
> Brian D. McGrew
> Sent: Friday, February 03, 2006 12:06 PM
> To: linux-kernel@vger.kernel.org
> Subject: Stale NFS File Handle
> 
> Good morning all (kind of a long winded mail, please have patience!)
> 
> I've got an FC3 server running a 2.6.9 kernel and sharing 
> about 500GB of disk space on a RAID5 array via NFS.  This box 
> has been running fine for over a year now but in the last 
> three weeks or so I'm seeing a ton of Stale NFS File Handle 
> errors; especially in my overnight builds.
> 
> Most of my clients are FC3 and a couple of Solaris boxes 
> running a stock configuration.  All we're doing is serving up 
> NFS and compiling with GCC.  We're seeing this error more and 
> more and the harder I try to track it down, the more we're 
> seeing it (ok, maybe that's my imagination).
> 
> I'm guessing that the problem has to be somewhere in the FC3 
> server because I've still got some Solaris NFS servers that 
> have been running for years with no problems.
> 
> What should I be looking for in tracking this error down?  
> Should I upgrade my kernel?  Should I throw away FC3 and go 
> to Enterprise Linux?
> I'm at the end of my rope here because this is now causing a 
> major set back to our development team!
> 
> Please help!


Brian,

That is an ancient kernel well over a year old, I would try a
later kernel.

At a min put on a later kernel, and maybe put on FC4 as there
as are several different kernels to choose from there, some
of which may have issues, others of which may work.

You might also check when and how your are doing "exportfs -r"
and other exportfs type commands because I have seen this command
before cause interesting race conditions (ie there is a spot
where apparently the clients get a failure response).   My setup
to get those messages required a busy machine, and updating
/etc/exports in cron and rerunning exportfs often, even with
all of that the failures were pretty rare, and only affected
some nodes on a given failure.

I don't know if the bug is still around, but it is something
to check.

                              Roger



