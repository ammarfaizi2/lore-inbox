Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266966AbTGGMIh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Jul 2003 08:08:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266972AbTGGMIf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Jul 2003 08:08:35 -0400
Received: from mail-in-01.arcor-online.net ([151.189.21.41]:15244 "EHLO
	mail-in-01.arcor-online.net") by vger.kernel.org with ESMTP
	id S266966AbTGGMI1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Jul 2003 08:08:27 -0400
From: Daniel Phillips <phillips@arcor.de>
To: Mel Gorman <mel@csn.ul.ie>
Subject: Re: 2.5.74-mm1
Date: Mon, 7 Jul 2003 14:24:06 +0200
User-Agent: KMail/1.5.2
Cc: Jamie Lokier <jamie@shareable.org>, Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Linux Memory Management List <linux-mm@kvack.org>
References: <20030703023714.55d13934.akpm@osdl.org> <200307060414.34827.phillips@arcor.de> <Pine.LNX.4.53.0307071042470.743@skynet>
In-Reply-To: <Pine.LNX.4.53.0307071042470.743@skynet>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200307071424.06393.phillips@arcor.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 07 July 2003 12:00, Mel Gorman wrote:
> On Sun, 6 Jul 2003, Daniel Phillips wrote:
> > > > What are you going to do if you have one
> > > > application you want to take priority, re-nice the other 50?
> > >
> > > Is that effective?  It might be just the trick.
> >
> > Point.
>
> Alternatively, how about using PAM to grant the CAP_SYS_NICE capability to
> known interactive users that require it. Presumably the number of users
> that require it is very small (in the case of the music player, only one)
> so it wouldn't be a major security issue.

And set up distros to grant it by default.  Yes.

The problem I see is that it lets user space priorities invade the range of 
priorities used by root processes.  What's really needed is a range of 
negative priorities available to normal users that are not normally used by 
root.

In retrospect, the idea of renicing all the applications but the realtime one  
doesn't work, because it doesn't take care of applications started 
afterwards. 

> There is something along these lines at http://www.pamcap.org but it
> requires some patching to the kernel (only available against 2.4.18
> currently) to inherit capabilities across exec and, from what I gather at
> a quick glance, to allow capabilities to be set for a process group.

Regards,

Daniel

