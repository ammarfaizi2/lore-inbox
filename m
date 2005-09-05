Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964965AbVIEXhh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964965AbVIEXhh (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 5 Sep 2005 19:37:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964967AbVIEXhh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 5 Sep 2005 19:37:37 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:38507 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S964965AbVIEXhg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 5 Sep 2005 19:37:36 -0400
Date: Mon, 5 Sep 2005 16:37:31 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Bernd Eckenfels <be-mail2005@lina.inka.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: GFS, what's remaining
Message-ID: <20050905233731.GA24523@ca-server1.us.oracle.com>
Mail-Followup-To: Bernd Eckenfels <be-mail2005@lina.inka.de>,
	linux-kernel@vger.kernel.org
References: <20050903070639.GC4593@ca-server1.us.oracle.com> <E1EBSRB-0003lW-00@calista.eckenfels.6bone.ka-ip.net> <20050905141631.GG5498@marowsky-bree.de> <20050905202403.GB7580@lina.inka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050905202403.GB7580@lina.inka.de>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.10i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 05, 2005 at 10:24:03PM +0200, Bernd Eckenfels wrote:
> The whole point of the orcacle cluster filesystem as it was described in old
> papers was about pfiles, control files and software, because you can easyly
> use direct block access (with ASM) for tablespaces.

	OCFS, the original filesystem, only works for datafiles,
logfiles, and other database data.  It's currently used in serious anger
by several major customers.  Oracle's websites must have a list of them
somewhere.  We're talking many terabytes of datafiles.

> Yes, I dont dispute the usefullness of OCFS for ORA_HOME (beside I think a
> replicated filesystem makes more sense), I am just nor sure if anybody sane
> would use it for tablespaces.

	OCFS2, the new filesystem, is fully general purpose.  It
supports all the usual stuff, is quite fast, and is what we expect folks
to use for both ORACLE_HOME and datafiles in the future.  Customers can,
of course, use ASM or even raw devices.  OCFS2 is as fast as raw
devices, and far more manageable, so raw devices are probably not a
choice for the future.  ASM has its own management advantages, and we
certainly expect customers to like it as well.  But that doesn't mean
people won't use OCFS2 for datafiles depending on their environment or
needs.


-- 

"The first requisite of a good citizen in this republic of ours
 is that he shall be able and willing to pull his weight."
	- Theodore Roosevelt

Joel Becker
Senior Member of Technical Staff
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
