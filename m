Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263408AbTEISHj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 May 2003 14:07:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263409AbTEISHj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 May 2003 14:07:39 -0400
Received: from holomorphy.com ([66.224.33.161]:34977 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S263408AbTEISHi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 May 2003 14:07:38 -0400
Date: Fri, 9 May 2003 11:20:01 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <mbligh@aracnet.com>
Cc: Dave Hansen <haveblue@us.ibm.com>, Linus Torvalds <torvalds@transmeta.com>,
       Jamie Lokier <jamie@shareable.org>, Roland McGrath <roland@redhat.com>,
       Andrew Morton <akpm@digeo.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386 uaccess to fixmap pages
Message-ID: <20030509182001.GA8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <mbligh@aracnet.com>,
	Dave Hansen <haveblue@us.ibm.com>,
	Linus Torvalds <torvalds@transmeta.com>,
	Jamie Lokier <jamie@shareable.org>,
	Roland McGrath <roland@redhat.com>, Andrew Morton <akpm@digeo.com>,
	linux-kernel@vger.kernel.org
References: <Pine.LNX.4.44.0305090856500.9705-100000@home.transmeta.com> <3EBBD982.9070006@us.ibm.com> <44170000.1052495699@[10.10.2.4]>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44170000.1052495699@[10.10.2.4]>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, dhansen wrote:
>> Don't anyone go applying these yet, though.  I think there has been a
>> bugfix or two since Martin released 2.5.68-mjb1, where these came from.
>>  So, consider them just an example for now.

On Fri, May 09, 2003 at 08:55:00AM -0700, Martin J. Bligh wrote:
> Here's the latest (fixed) sequence of patches, which seems to work pretty 
> happily. Might need some merging to get them to go against mainline, but 
> nothing major.

The patch needs to do some kind of work in kernel_pmd_ctor() and
introduce a kernel_pmd_dtor() and do things analogous to what the
re-slabification patches are doing for the non-PAE case in order to fix
the bugs where pageattr.c doesn't get a chance to clean up cached pgd's
and add a pmd invalidation loop to set_pmd_pte() in pageattr.c.


-- wli
