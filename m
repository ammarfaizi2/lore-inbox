Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261703AbUKGWt7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261703AbUKGWt7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 7 Nov 2004 17:49:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261704AbUKGWt7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 7 Nov 2004 17:49:59 -0500
Received: from holomorphy.com ([207.189.100.168]:19088 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S261703AbUKGWt4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 7 Nov 2004 17:49:56 -0500
Date: Sun, 7 Nov 2004 14:49:48 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Anton Blanchard <anton@samba.org>
Cc: David Gibson <david@gibson.dropbear.id.au>, linux-kernel@vger.kernel.org,
       linuxppc64-dev@ozlabs.org, Adam Litke <agl@us.ibm.com>,
       Andy Whitworth <apw@shadowen.org>
Subject: Re: [RFC] Consolidate lots of hugepage code
Message-ID: <20041107224948.GO2890@holomorphy.com>
References: <20041029033708.GF12247@zax> <20041029034817.GY12934@holomorphy.com> <20041107172030.GA16976@krispykreme.ozlabs.ibm.com> <20041107192024.GM2890@holomorphy.com> <20041107193007.GC16976@krispykreme.ozlabs.ibm.com> <20041107210943.GN2890@holomorphy.com> <20041107212212.GD16976@krispykreme.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041107212212.GD16976@krispykreme.ozlabs.ibm.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

At some point in the past, I wrote:
>> Until it's fixed. Until then I'm considering it a byproduct of that same
>> development. And with your report, that makes it two architectures, not
>> one.

On Mon, Nov 08, 2004 at 08:22:12AM +1100, Anton Blanchard wrote:
> We _arent_ seeing it on ppc64. Can we at least have a complete bug
> report if we are to halt all hugetlb development? At the moment we dont
> have much information to go on at all.

Sorry, I don't get complete bugreports myself. If you care to try to
actually fix something (it's doubtful you yourself are the culprit) I'm
still trying to reproduce it myself with long-running database tests.
It's reliably reproducible on the reporters' machines.

The particular bug is only one piece of evidence. Just asking basic
questions about what was done for architecture code reveals that
all this "development" is not paying proper attention to architecture
code. I merely insist that development toward the end of stabilization
occur prior to that for large feature work.

And frankly, I'm rather unimpressed with the gravity of the proposed
featurework, particularly in comparison to the stability requirements
of users on typical production systems.

Nor am I impressed with the quality. The patch presentations have been
messy, the audits (as mentioned above) incomplete, the benefits not
clearly demonstrated, and the code itself not so pretty. Just
respinning the patches so they're properly incremental and the code
somewhat cleaner (e.g. some recent one nested tabs 5 deep or so)
would already remedy a large number of the issues with the featurework.
Once arranged that way the audits' incompleteness can be dealt with by
those with the fortitude to thoroughly audit and/or prior architecture
knowledge to correct the patches for arches they don't deal with properly.


-- wli
