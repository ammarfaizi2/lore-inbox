Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266477AbUIIRc4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266477AbUIIRc4 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 9 Sep 2004 13:32:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266376AbUIIRZm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 9 Sep 2004 13:25:42 -0400
Received: from holomorphy.com ([207.189.100.168]:46001 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S266366AbUIIRWU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 9 Sep 2004 13:22:20 -0400
Date: Thu, 9 Sep 2004 10:22:00 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Stephen Smalley <sds@epoch.ncsc.mil>
Cc: Roger Luethi <rl@hellgate.ch>, Andrew Morton <akpm@osdl.org>,
       lkml <linux-kernel@vger.kernel.org>,
       Albert Cahalan <albert@users.sourceforge.net>,
       "Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>
Subject: Re: [1/1][PATCH] nproc v2: netlink access to /proc information
Message-ID: <20040909172200.GX3106@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Stephen Smalley <sds@epoch.ncsc.mil>, Roger Luethi <rl@hellgate.ch>,
	Andrew Morton <akpm@osdl.org>, lkml <linux-kernel@vger.kernel.org>,
	Albert Cahalan <albert@users.sourceforge.net>,
	"Martin J. Bligh" <mbligh@aracnet.com>, Paul Jackson <pj@sgi.com>
References: <20040908184130.GA12691@k3.hellgate.ch> <1094730811.22014.8.camel@moss-spartans.epoch.ncsc.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1094730811.22014.8.camel@moss-spartans.epoch.ncsc.mil>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2004-09-08 at 14:41, Roger Luethi wrote:
>> A few notes:
>> - Access control can be implemented easily. Right now it would be bloat,
>>   though -- the vast majority of fields in /proc are world-readable
>>   (/proc/pid/environ being the notable exception).

On Thu, Sep 09, 2004 at 07:53:31AM -0400, Stephen Smalley wrote:
> They aren't world readable when using a security module like SELinux;
> they are then typically only accessible by processes in the same
> security domain, aside from processes in privileged domains. 
> security_task_to_inode() hook sets the security attributes on the
> /proc/pid inodes based on their security context, and then
> security_inode_permission() hook controls access to them.  So you need
> at least comparable controls.

Can you make a more specific suggestion regarding the controls to use?
It's a bit awkward for those highly unfamiliar with the subsystem to
invent new methods for the security layer independently, so it's likely
best some guidance (e.g. function prototype) be given.


-- wli
