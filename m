Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268994AbUHZODr@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268994AbUHZODr (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 26 Aug 2004 10:03:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268970AbUHZODp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 26 Aug 2004 10:03:45 -0400
Received: from facesaver.epoch.ncsc.mil ([144.51.25.10]:51405 "EHLO
	epoch.ncsc.mil") by vger.kernel.org with ESMTP id S268963AbUHZOB1
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 26 Aug 2004 10:01:27 -0400
Subject: Re: Using fs views to isolate untrusted processes: I need an
	assistant architect in the USA for Phase I of a DARPA funded linux kernel
	project
From: Stephen Smalley <sds@epoch.ncsc.mil>
To: Hans Reiser <reiser@namesys.com>
Cc: Mike Waychison <Michael.Waychison@sun.com>,
       Tim Hockin <thockin@hockin.org>, Rik van Riel <riel@redhat.com>,
       lkml <linux-kernel@vger.kernel.org>,
       ReiserFS List <reiserfs-list@namesys.com>
In-Reply-To: <412D83D9.2050503@namesys.com>
References: <410D96DC.1060405@namesys.com>
	 <Pine.LNX.4.44.0408251624540.5145-100000@chimarrao.boston.redhat.com>
	 <20040825205618.GA7992@hockin.org> <412D0339.3080601@sun.com>
	 <412D83D9.2050503@namesys.com>
Content-Type: text/plain
Organization: National Security Agency
Message-Id: <1093528762.9280.121.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6 (1.4.6-2) 
Date: Thu, 26 Aug 2004 09:59:23 -0400
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-08-26 at 02:31, Hans Reiser wrote:
> Everybody who takes a 3 minute read of SELinux keeps saying it has, but 
> it hasn't quite, not when you look at the details.  SELinux is not 
> written by filesystem folks, and there are scalability details that matter.

I don't quite see the point about filesystem folks.
With regard to scalability, there is ongoing work in that area, and
patches on lkml that are being discussed even now, so that is hardly a
show stopper.

> > What is needed (if it doesn't already
> > exist) is a tool to gather these 'viewprints' automagically.
> 
> It doesn't exist, and viewprints are also not stored with executables 
> either, so it is not process oriented.
> 
> People think the problem is allowing the OS to enact fine grained 
> security.  It is not.  The problem is allowing the user to enact fine 
> grained security, and without a lot of work to automate it, users will 
> continue to be unable to bear that time cost.

Users don't want to think about fine grained security at all, and
automated schemes will inevitably generate policies that are insecure ;)

SELinux already has a significant corpus of policy that has been
developed over time, most of it contributed by external contributors,
with > 190 different program domains in the current example policy.  It
has the obvious simple tool for generating policy from audit messages
produced during a run of a program, but that tool has certainly not been
a good source for secure policy.  It has tools for analyzing policies,
including information flow and goal checking, although much work still
remains to be done here.  Much better investment to work on improving
SELinux in these areas than re-inventing the wheel...

-- 
Stephen Smalley <sds@epoch.ncsc.mil>
National Security Agency

