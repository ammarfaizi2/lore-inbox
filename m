Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261320AbVGBXJp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261320AbVGBXJp (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 2 Jul 2005 19:09:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261323AbVGBXJp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 2 Jul 2005 19:09:45 -0400
Received: from e34.co.us.ibm.com ([32.97.110.132]:56487 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S261320AbVGBXJm
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 2 Jul 2005 19:09:42 -0400
Subject: Re: [Jfs-discussion] jfs mount causes oops on sparc64
From: Dave Kleikamp <shaggy@austin.ibm.com>
To: Alex Deucher <alexdeucher@gmail.com>
Cc: jfs-discussion@lists.sourceforge.net,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, ag@m-cam.com
In-Reply-To: <a728f9f905070111133a24590@mail.gmail.com>
References: <a728f9f905070111133a24590@mail.gmail.com>
Content-Type: text/plain
Date: Sat, 02 Jul 2005 18:09:39 -0500
Message-Id: <1120345779.9901.6.camel@kleikamp.austin.ibm.com>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2005-07-01 at 14:13 -0400, Alex Deucher wrote:
> I have a 6.9 TB jfs LVM volume on a sparc64 debian box, however mount
> seems to cause an oops when I attempt to mount the volume:
> 
> jfs_mount: diMount(ipaimap) failed w/rc = -5
> data_access_exception: SFSR[0000000000801009] SFAR[000000000043f770], going.

> kernel is 2.6.12rc3 on debian sparc.  Any ideas?

JFS has never worked on architectures with a page size greater than 4K
until (would you believe?) 2.6.12-rc4.  I bet if you would try a more
recent kernel, you would no longer see this problem.

In case you would continue to see problems with a newer kernel, I'd like
to know.  I'll be on vacation until July 13, so my email access will be
sporadic.

Thanks,
Shaggy
-- 
David Kleikamp
IBM Linux Technology Center

