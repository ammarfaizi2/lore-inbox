Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269416AbUJFTvQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269416AbUJFTvQ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 6 Oct 2004 15:51:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269415AbUJFTvP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 6 Oct 2004 15:51:15 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:51385 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S269416AbUJFTsX
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 6 Oct 2004 15:48:23 -0400
Message-ID: <41644BF1.7030904@pobox.com>
Date: Wed, 06 Oct 2004 15:48:01 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>, mingo@redhat.com
CC: nickpiggin@yahoo.com.au, kenneth.w.chen@intel.com,
       linux-kernel@vger.kernel.org, judith@osdl.org
Subject: Re: new dev model (was Re: Default cache_hot_time value back to 10ms)
References: <200410060042.i960gn631637@unix-os.sc.intel.com>	<20041005205511.7746625f.akpm@osdl.org>	<416374D5.50200@yahoo.com.au>	<20041005215116.3b0bd028.akpm@osdl.org>	<41637BD5.7090001@yahoo.com.au>	<20041005220954.0602fba8.akpm@osdl.org>	<416380D7.9020306@yahoo.com.au>	<20041005223307.375597ee.akpm@osdl.org>	<41638E61.9000004@pobox.com> <20041005233958.522972a9.akpm@osdl.org> <41644A3D.4050100@pobox.com>
In-Reply-To: <41644A3D.4050100@pobox.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


So my own suggestions for increasing 2.6.x stability are:

1) Create a release numbering system that is __clear to users__, not 
just developers.  This is a human, not technical problem.  Telling users 
"oh, -rc1 doesn't really mean Release Candidate, we start getting 
serious around -rc2 or so but some stuff slips in and..." is hardly clear.

2) Really (underscore underscore) only accept bugfixes after the chosen 
line of demarcation.  No API changes.  No new stuff (new stuff may not 
break anything, but it's a distraction).  Chill out on all the sparse 
notations.  _Just_ _bug_ _fixes_.  The fluff (comments/sparse/new 
features) just serves to make reviewing the changes more difficult, as 
it vastly increases the noise-to-signal ratio.

With all the noise of comment fixes, new features, etc. during Release 
Candidate, you kill the value of reviewing the -rc patch.  Developers 
and users have to either (a) boot and pray or (b) wade through tons of 
non-bugfix changes in an attempt to review the changes.

I know it's an antiquated idea, _reading_ and reviewing a -rc patch, but 
still...

	Jeff



