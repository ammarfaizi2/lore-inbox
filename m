Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290850AbSARWMR>; Fri, 18 Jan 2002 17:12:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290852AbSARWMI>; Fri, 18 Jan 2002 17:12:08 -0500
Received: from marc1.theaimsgroup.com ([63.238.77.171]:28169 "EHLO
	mailer.progressive-comp.com") by vger.kernel.org with ESMTP
	id <S290850AbSARWLz>; Fri, 18 Jan 2002 17:11:55 -0500
Date: Fri, 18 Jan 2002 17:11:39 -0500
Message-Id: <200201182211.RAA06149@mailer.progressive-comp.com>
From: Hank Leininger <linux-kernel@progressive-comp.com>
Reply-To: Hank Leininger <hlein@progressive-comp.com>
To: linux-kernel@vger.kernel.org
Subject: Re: rm-ing files with open file descriptors
X-Shameless-Plug: Check out http://marc.theaimsgroup.com/
X-Warning: This mail posted via a web gateway at marc.theaimsgroup.com
X-Warning: Report any violation of list policy to abuse@progressive-comp.com
X-Posted-By: Hank Leininger <hlein@progressive-comp.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 2002-01-18, Ken Brownfield <brownfld@irridia.com> wrote:

> One nasty side-effect is space allocation -- after unlinking a file and
> writing to it, you can fill the disk without the file showing up in
> 'ls' or 'du', etc.  Hard to debug.  Stronghold on Solaris used to do
> this with log files -- HUP did not discard the old FDs.

Hell, syslogd on Linux used to do that ;)

Linux's /proc/PID/fd/* will (nowadays) tell you the path/name of files that
have been unlinked but have active file descriptors, which at least makes
this less painful to track down *once you think of it*.

--
Hank Leininger <hlein@progressive-comp.com> 
  
