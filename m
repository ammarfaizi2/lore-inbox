Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751198AbWDMIk5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751198AbWDMIk5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 13 Apr 2006 04:40:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751203AbWDMIk5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 13 Apr 2006 04:40:57 -0400
Received: from vanessarodrigues.com ([192.139.46.150]:57286 "EHLO
	jaguar.mkp.net") by vger.kernel.org with ESMTP id S1751198AbWDMIk4
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 13 Apr 2006 04:40:56 -0400
To: Herbert Poetzl <herbert@13thfloor.at>
Cc: Linux Kernel ML <linux-kernel@vger.kernel.org>, linux-xfs@oss.sgi.com,
       xfs-masters@oss.sgi.com, stern@rowland.harvard.edu, sekharan@us.ibm.com,
       akpm@osdl.org, David Chinner <dgc@sgi.com>
Subject: Re: notifier chain problem? (was Re: 2.6.17-rc1 did break XFS)
References: <20060413052145.GA31435@MAIL.13thfloor.at>
	<20060413072325.GF2732@melbourne.sgi.com>
From: Jes Sorensen <jes@sgi.com>
Date: 13 Apr 2006 04:40:54 -0400
In-Reply-To: <20060413072325.GF2732@melbourne.sgi.com>
Message-ID: <yq0k69tuauh.fsf@jaguar.mkp.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.4
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>>>> "David" == David Chinner <dgc@sgi.com> writes:

David> On Thu, Apr 13, 2006 at 07:21:45AM +0200, Herbert Poetzl wrote:
David> It looks like we landed on top of a a notifier call chain
David> implementation change in -rc1. However, this should not matter
David> to XFS because the interface to register_cpu_notifier() did not
David> change and XFS is completely abstracted away from the notifier
David> chain implementation. We do:

Dave,

Looks strange, the faulting address is in the same region as the
eip. I am not that strong on x86 layouts, so I am not sure whether
0x78xxxxxx is the kernel's mapping or it's module space. Almost looks
like something else had registered a notifier and then gone away
without unregistering it.

Herbert, any chance you can make the complete boot log up to the point
where it crashes, as well as a System.map and your .config available?
(probably not posted to all the lists :)

Cheers,
Jes


