Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751664AbWIFQql@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751664AbWIFQql (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Sep 2006 12:46:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751667AbWIFQql
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Sep 2006 12:46:41 -0400
Received: from rgminet01.oracle.com ([148.87.113.118]:30874 "EHLO
	rgminet01.oracle.com") by vger.kernel.org with ESMTP
	id S1751661AbWIFQqk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Sep 2006 12:46:40 -0400
Message-ID: <44FEFB5A.7060905@oracle.com>
Date: Wed, 06 Sep 2006 09:46:18 -0700
From: Zach Brown <zach.brown@oracle.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: Jeff Moyer <jmoyer@redhat.com>
CC: linux-fsdevel@vger.kernel.org, linux-aio@kvack.org,
       linux-kernel@vger.kernel.org
Subject: Re: [RFC 0/5] dio: clean up completion phase of direct_io_worker()
References: <20060905235732.29630.3950.sendpatchset@tetsuo.zabbo.net> <x49hczl11ru.fsf@segfault.boston.devel.redhat.com>
In-Reply-To: <x49hczl11ru.fsf@segfault.boston.devel.redhat.com>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Brightmail-Tracker: AAAAAQAAAAI=
X-Whitelist: TRUE
X-Whitelist: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> This all looks good, the code is much easier to follow.  What do you think
> about making dio->result an unsigned quantity?  It should never be negative
> now that there is an io_error field.

Yeah, that has always bugged me too.  I considered renaming it 'issued',
or something, as part of this patchset but thought we could do it later.

While we're on this topic, I'm nervious that we increment it when
do_direct_IO fails.  It might be sound, but that we consider it the
amount of work "transferred" for dio->end_io makes me want to make sure
there aren't confusing corner cases here.

- z
