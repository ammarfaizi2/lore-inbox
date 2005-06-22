Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262485AbVFVANk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262485AbVFVANk (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 20:13:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262384AbVFVALG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 20:11:06 -0400
Received: from rgminet03.oracle.com ([148.87.122.32]:42741 "EHLO
	rgminet03.oracle.com") by vger.kernel.org with ESMTP
	id S262484AbVFVAFE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 20:05:04 -0400
Date: Tue, 21 Jun 2005 17:04:43 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Steve French <smfltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] [PATCH] OCFS2
Message-ID: <20050622000442.GB7531@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <1119388469.5701.145.camel@stevef95.austin.ibm.com> <20050621220313.GA7531@ca-server1.us.oracle.com> <1119393793.5690.170.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119393793.5690.170.camel@stevef95.austin.ibm.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2005 at 05:43:13PM -0500, Steve French wrote:
> The list is not wrong. I was just noting that it was too short, missing
> three items of particular interest for server filesystems (which seems
> to be the target environment). Support for:
> 	Directory change notification (F_NOTIFY)
> 	Distributed Caching (F_SETLEASE/F_GETLEASE/break_lease)
> 	POSIX ACLs
Ahh, it seems I misread your earlier e-mail! In any case, I'll add those to
the list of missing features.

> The lack of support for lsattr/chattr (chflags) is less important, and
> the lack of support for the multipage operations (writepages and
> readpages) is not a compatability issue and is not critical, although it
> might hurt performance.
Yeah, I'm not sure how high a priority chflags are right now. Keeping in
mind that I'm mostly ignorant of cifs / samba, is there a particular set of
attributes there that it likes to use?

I'll have to look into why we don't currently support readpages /
writepages. I'm guessing it boiled down to lack of developer time :)
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
