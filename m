Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262073AbUDHRF6 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Apr 2004 13:05:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262070AbUDHRF6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Apr 2004 13:05:58 -0400
Received: from zero.aec.at ([193.170.194.10]:41738 "EHLO zero.aec.at")
	by vger.kernel.org with ESMTP id S262049AbUDHRFt (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Apr 2004 13:05:49 -0400
To: Andy Whitcroft <apw@shadowen.org>
Subject: Re: HUGETLB commit handling.
References: <1IKJu-Zn-29@gated-at.bofh.it>
From: Andi Kleen <ak@muc.de>
Cc: "Chen, Kenneth W" <kenneth.w.chen@intel.com>,
       "'Ray Bryant'" <raybry@sgi.com>, "Martin J. Bligh" <mbligh@aracnet.com>,
       linux-kernel@vger.kernel.org, anton@samba.org, sds@epoch.ncsc.mil,
       ak@suse.de, lse-tech@lists.sourceforge.net, linux-ia64@vger.kernel.org
Date: Thu, 08 Apr 2004 19:05:40 +0200
In-Reply-To: <1IKJu-Zn-29@gated-at.bofh.it> (Andy Whitcroft's message of
 "Thu, 08 Apr 2004 18:40:12 +0200")
Message-ID: <m3u0zuwgbf.fsf@averell.firstfloor.org>
User-Agent: Gnus/5.110002 (No Gnus v0.2) Emacs/21.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Whitcroft <apw@shadowen.org> writes:

> We have been looking at the HUGETLB page commit issue (offlist) and are
> close a final merged patch.  However, our testing seems to have thrown up

This includes lazy allocation for i386 and IA64, right?

If yes, I'm waiting for your final patch then to remerge the NUMA
policy code into it (currently NUMA API contains a dumb version of lazy
allocation for i386 without any prereservation)

> I would contend this is the right thing to do, as it makes the semantics of
> hugepages match that of the existing small pages.  We are looking for a
> consensus as this might be construed as a semantic change.

I think it's more clean to do it at shmget() time too, so it's probably the
right thing to do.

-Andi

