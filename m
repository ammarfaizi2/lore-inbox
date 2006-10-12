Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1422768AbWJLGye@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422768AbWJLGye (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Oct 2006 02:54:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422769AbWJLGye
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Oct 2006 02:54:34 -0400
Received: from agminet01.oracle.com ([141.146.126.228]:36773 "EHLO
	agminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1422768AbWJLGyd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Oct 2006 02:54:33 -0400
Date: Wed, 11 Oct 2006 23:54:17 -0700
From: Joel Becker <Joel.Becker@oracle.com>
To: Chandra Seetharaman <sekharan@us.ibm.com>
Cc: Paul Menage <menage@google.com>, Greg KH <gregkh@suse.de>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: unlimited read buffer support on configfs
Message-ID: <20061012065417.GN7911@ca-server1.us.oracle.com>
Mail-Followup-To: Chandra Seetharaman <sekharan@us.ibm.com>,
	Paul Menage <menage@google.com>, Greg KH <gregkh@suse.de>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20061011001122.GO7911@ca-server1.us.oracle.com> <1160596037.6389.64.camel@linuxchandra> <20061011220130.GA7911@ca-server1.us.oracle.com> <1160608621.6389.71.camel@linuxchandra> <20061011234552.GF7911@ca-server1.us.oracle.com> <6599ad830610111715s13f92c99y2c0ac82bf524c9d2@mail.gmail.com> <20061012001914.GI7911@ca-server1.us.oracle.com> <6599ad830610111740m30bc3db0se1f7becd7fc4c62e@mail.gmail.com> <20061012004615.GJ7911@ca-server1.us.oracle.com> <1160615452.6389.91.camel@linuxchandra>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1160615452.6389.91.camel@linuxchandra>
X-Burt-Line: Trees are cool.
X-Red-Smith: Ninety feet between bases is perhaps as close as man has ever come to perfection.
User-Agent: Mutt/1.5.11
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 11, 2006 at 06:10:52PM -0700, Chandra Seetharaman wrote:
> So, what you are saying is that we should not be using configfs, even
> though it fits nicely except the fact that we are not fitting the "one
> file == one attribute" model ?
> 
> In other words, write our own file system instead of expanding the
> existing infrastructure (just to have one additional feature) ?

	No, I'm not saying that you shouldn't use configfs.  Greg is
more adamant than I, actually, on the "file == attribute" model.
	Here's the thing.  For most users, there is no reason they can't
use configfs for _config_ and something like netlink for bulk data
movement.  configfs isn't a kitchen sink, and it never should be.
	Now, I know that your group/pids list fits really nicely as a
concept in the configfs tree.  You certainly can't be calling a usermode
helper for each fork() and exit().  So this is why we're still having a
discussion and working on it.

> I think we should be talking these in lkml as it is more on the
> philosophical discusiion than a technical discussion. 

	Fair enough, Cc'd!

Joel

-- 

"The question of whether computers can think is just like the question
 of whether submarines can swim."
	- Edsger W. Dijkstra

Joel Becker
Principal Software Developer
Oracle
E-mail: joel.becker@oracle.com
Phone: (650) 506-8127
