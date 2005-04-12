Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262045AbVDLHK6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262045AbVDLHK6 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Apr 2005 03:10:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262044AbVDLHK5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Apr 2005 03:10:57 -0400
Received: from orb.pobox.com ([207.8.226.5]:31362 "EHLO orb.pobox.com")
	by vger.kernel.org with ESMTP id S262040AbVDLHFR (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Apr 2005 03:05:17 -0400
Date: Tue, 12 Apr 2005 00:05:07 -0700
From: "Barry K. Nathan" <barryn@pobox.com>
To: David Lang <david.lang@digitalinsight.com>
Cc: Christopher Li <lkml@chrisli.org>, Linus Torvalds <torvalds@osdl.org>,
       Paul Jackson <pj@engr.sgi.com>, junkio@cox.net, rddunlap@osdl.org,
       ross@jose.lug.udel.edu, linux-kernel@vger.kernel.org
Subject: Re: more git updates..
Message-ID: <20050412070507.GB8008@ip68-4-98-123.oc.oc.cox.net>
References: <7vhdifcbmo.fsf@assigned-by-dhcp.cox.net> <Pine.LNX.4.58.0504100824470.1267@ppc970.osdl.org> <20050410115055.2a6c26e8.pj@engr.sgi.com> <Pine.LNX.4.58.0504101338360.1267@ppc970.osdl.org> <20050410190331.GG13853@64m.dyndns.org> <Pine.LNX.4.58.0504101533020.1267@ppc970.osdl.org> <20050410195354.GH13853@64m.dyndns.org> <Pine.LNX.4.58.0504101611370.1267@ppc970.osdl.org> <20050410212850.GA23960@64m.dyndns.org> <Pine.LNX.4.62.0504112205190.16541@qynat.qvtvafvgr.pbz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.62.0504112205190.16541@qynat.qvtvafvgr.pbz>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2005 at 10:14:13PM -0700, David Lang wrote:
> I've been reading this and have another thought for you guys to keep in 
> mind for this tool.
> 
> version control of system config files on linux systems.

I've been thinking about this too. (I won't have time to implement this
however. If I do have time in the near future to do anything involving
git, it probably won't have anything to do with version control of
config files.)

> it sounds like you could put the / fileystem under the control of git 
> (after teaching it to not cross fileystem boundries so you can have 
> another filesystem to work with) and version control your entire system. 
> if this was done it would be nice to add a item type that would referance 
> a file in a distro package to save space. it sounds like you could run a 
> git checkin daily (as part of the updatedb run for example) at very little 
> cost.

I was thinking that the GIT checkin should actually be done by the
distro configuration tools, and not as a cronjob. And maybe the config
tools could do two checkins if there were any manual changes since the
last checkin, or something. (That is, one checkin to check in the manual
changes since the last checkin, and another to check in whatever the
config tool just did.)

Now that I think about it, it would be really good to have a simple tool
for doing a manual checkin after manual editing of config files, but I
think something like the dual-checkin scheme would be needed as a safety
net in case root forgets to do the checkin.

-Barry K. Nathan <barryn@pobox.com>

