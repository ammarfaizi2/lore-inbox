Return-Path: <linux-kernel-owner+willy=40w.ods.org-S2992521AbWJTGpc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S2992521AbWJTGpc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 20 Oct 2006 02:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946310AbWJTGpc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 20 Oct 2006 02:45:32 -0400
Received: from 85.8.24.16.se.wasadata.net ([85.8.24.16]:32913 "EHLO
	smtp.drzeus.cx") by vger.kernel.org with ESMTP id S1946307AbWJTGpb
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 20 Oct 2006 02:45:31 -0400
Message-ID: <45387090.7020509@drzeus.cx>
Date: Fri, 20 Oct 2006 08:45:36 +0200
From: Pierre Ossman <drzeus-list@drzeus.cx>
User-Agent: Thunderbird 1.5.0.7 (X11/20061004)
MIME-Version: 1.0
To: Mark Fasheh <mark.fasheh@oracle.com>, Andrew Morton <akpm@osdl.org>
CC: Linus Torvalds <torvalds@osdl.org>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: Git training wheels for the pimple faced maintainer
References: <4537EB67.8030208@drzeus.cx> <Pine.LNX.4.64.0610191629250.3962@g5.osdl.org> <20061020010715.GF10128@ca-server1.us.oracle.com>
In-Reply-To: <20061020010715.GF10128@ca-server1.us.oracle.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Fasheh wrote:
> On Thu, Oct 19, 2006 at 04:44:41PM -0700, Linus Torvalds wrote:
>   
>> I think people have seen the messages that other people send out (eg at 
>> least Greg KH tends to Cc: those messages to linux-kernel, so others can 
>> see what's going on too - although not all other maintainers do that).
>>     
> I noticed also that people started sending out "What's in XX.git" type
> messages at the beginning of a merge window to describe what might shortly
> get sent upstream.
>
>   

Yes, I've found those to be quite nice. I'll try to remember to send my own.

>   
>> Other git maintainers may have other hints about how they work. Anybody?
>>     
> I think I have a slightly different workflow than what Pierre describes. I
> find that it works well for me and it keeps things very organized in
> ocfs2.git. It's also probably a little more work than other methods for
> managing a git tree that people employ. Hopefully a description of my
> process will be useful to someone.
>
> Basically I have two trees, ocfs2.git which is the main ocfs2 repository and
> my own personal linux-2.6.git which I actually hack in.
>   

Hmm.. What is the gain of having two tree instead of just more branches?

> Once I'm ready to send an upstream pull request, I'll update the master
> branch of ocfs2.git. I then make a for-linus branch based off of it, and
> git-cherry-pick each individual patch into that branch and send my request.
>   

This should be equivalent of just keeping the "for-linus" branch around
as it will just fast-forward along with Linus' tree when it doesn't
contain any local changes. Or am I missing something?

> Once Linus pulls, I'll re-make the ALL branch for Andrew by re-pulling all
> the patchsets which weren't a part of that pull request.
>   

In other words, you destroy all the old history of your ALL branch and
create a new one? So you couldn't continuously pull from that branch?

> Btw, I cannot over state how important and useful it is to have patches go
> to -mm first.
>   

My intention was always to send him everything but the most trivial patches.

On questions related to that though. Previously, I've always sent plain
patches to Andrew. After they have simmered a bit in -mm, he usually
pushes them on to Linus, even though they do not qualify as being just
bug fixes. As I will now be the one moving stuff from "from-andrew" to
"for-linus", will the decision of what to move now fall on me? I would
probably be more inclined to wait for the next merge window than Andrew is.

Thanks

-- 
     -- Pierre Ossman

  Linux kernel, MMC maintainer        http://www.kernel.org
  PulseAudio, core developer          http://pulseaudio.org
  rdesktop, core developer          http://www.rdesktop.org

