Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262420AbVFUWkn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262420AbVFUWkn (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 21 Jun 2005 18:40:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262428AbVFUWgy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 21 Jun 2005 18:36:54 -0400
Received: from agminet04.oracle.com ([141.146.126.231]:4702 "EHLO
	agminet04.oracle.com") by vger.kernel.org with ESMTP
	id S262316AbVFUWDY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 21 Jun 2005 18:03:24 -0400
Date: Tue, 21 Jun 2005 15:03:13 -0700
From: Mark Fasheh <mark.fasheh@oracle.com>
To: Steve French <smfltc@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org
Subject: Re: [RFC] [PATCH] OCFS2
Message-ID: <20050621220313.GA7531@ca-server1.us.oracle.com>
Reply-To: Mark Fasheh <mark.fasheh@oracle.com>
References: <1119388469.5701.145.camel@stevef95.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1119388469.5701.145.camel@stevef95.austin.ibm.com>
Organization: Oracle Corporation
User-Agent: Mutt/1.5.9i
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Steve,
On Tue, Jun 21, 2005 at 04:14:29PM -0500, Steve French wrote:
> You list features which OCFS2 does not support yet in fs/Kconfig as:
>                - extended attributes
>                - readonly mount
>                - shared writeable mmap
>                - loopback is supported, but data written will not
>                  be cluster coherent.
>                - quotas
>                - cluster aware flock

I think you may have misread that... the latest patch at least has:
+	  Note: Features which OCFS2 does not support yet:

If you see anywhere our supported feature set is actually misstated, please
let me know so I can correct that immediately.

> The above three (notify/lease/acl) are particularly important for
> Samba.  Are those planned for an upcoming release?
Generally we want to be as useful as possible, so we've got a long list of
planned features. I'd need to look more closely at the issues involved with
supporting these in a clustered environment before giving you any more
specific of an answer :)

> What is the timestamp granularity in your inode on-disk format?  For
> Samba4 supporting at least a 100nanosecond time stamp (used for DCE and
> CIFS) is helpful due to the time rounding issues that can come up with
> the primitive 1 second timestamp.
OCFS2 supports subsecond timestamps via a u32 nsec fields on dinode, so I
think at least that should work for you.
	--Mark

--
Mark Fasheh
Senior Software Developer, Oracle
mark.fasheh@oracle.com
