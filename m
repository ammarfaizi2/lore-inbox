Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263054AbVHEQgV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263054AbVHEQgV (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 5 Aug 2005 12:36:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263045AbVHEQgH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 5 Aug 2005 12:36:07 -0400
Received: from dvhart.com ([64.146.134.43]:24960 "EHLO localhost.localdomain")
	by vger.kernel.org with ESMTP id S263081AbVHEQf4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 5 Aug 2005 12:35:56 -0400
Date: Fri, 05 Aug 2005 09:35:37 -0700
From: "Martin J. Bligh" <mbligh@mbligh.org>
Reply-To: "Martin J. Bligh" <mbligh@mbligh.org>
To: Hugh Dickins <hugh@veritas.com>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>
Cc: Danny ter Haar <dth@picard.cistron.nl>, Pavel Roskin <proski@gnu.org>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.13-rc5-git2 does not boot on (my) amd64
Message-ID: <833200000.1123259737@flay>
In-Reply-To: <113800000.1123197027@[10.10.2.4]>
References: <dctuso$tl$1@news.cistron.nl.suse.lists.linux.kernel><p73iryl73nm.fsf@bragg.suse.de> <Pine.LNX.4.61.0508042358530.8665@goblin.wat.veritas.com> <113800000.1123197027@[10.10.2.4]>
X-Mailer: Mulberry/2.1.2 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


>>> > Freeing unused kernel memory: 248k freed
>>> > VM: killing process hotplug
>>> > VM: killing process hotplug
>>> > VM: killing process hotplug
>>> > VM: killing process hotplug
>>> > Unable to handle kernel paging request at fffffff28017b5be RIP:
>>> > [<fffffff28017b5be>]
>>> 
>>> Looks weird. Just to make sure can you do a make distclean and try
>>> again? It might be a bad compile.
>> 
>> No, like Pavel's and Martin's reports, this is just an effect
>> of the not-quite-fully-baked do_wp_page/get_user_pages race fix in
>> 2.6.13-rc5-git2, which AlexN reported earlier.  Should now be fully
>> fixed in Linus' current git, and in the 2.6.13-rc6 akpm prophesies
>> to be coming soon - please all test that.
> 
> OK, nightly builds tests should auto-appear on http://test.kernel.org
> tommorow morning. I'll try to remember to look for it; if you remember
> before I wake up Hugh, should be published there ... ;-)

-git3 works! wheeeeeeeee! thanks guys.

M.

