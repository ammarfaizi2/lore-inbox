Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261288AbULEKB7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261288AbULEKB7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 5 Dec 2004 05:01:59 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261287AbULEKB7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 5 Dec 2004 05:01:59 -0500
Received: from atrey.karlin.mff.cuni.cz ([195.113.31.123]:54202 "EHLO
	atrey.karlin.mff.cuni.cz") by vger.kernel.org with ESMTP
	id S261289AbULEKBl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 5 Dec 2004 05:01:41 -0500
Date: Fri, 3 Dec 2004 18:41:36 +0100
From: Pavel Machek <pavel@suse.cz>
To: Gerrit Huizenga <gh@us.ibm.com>
Cc: linux-kernel@vger.kernel.org, akpm@osdl.org,
       Rik van Riel <riel@redhat.com>, Chris Mason <mason@suse.com>,
       ckrm-tech <ckrm-tech@lists.sourceforge.net>
Subject: Re: [PATCH] CKRM: 10/10 CKRM:  Documentation
Message-ID: <20041203174135.GE4670@openzaurus.ucw.cz>
References: <E1CYqcl-0005Ap-00@w-gerrit.beaverton.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1CYqcl-0005Ap-00@w-gerrit.beaverton.ibm.com>
User-Agent: Mutt/1.3.27i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> +           class. In other words, the sum of "guarantee"s of all children
> +	   of this class cannot exit this number.

Did you mean "exceed"?

> +None of this parameters are absolute or have any units associated with
> +them. These are just numbers(that are 
missing space before (.

+-----------------------------------------------
> +
> +1. Create a class
> +
> +   # mkdir /rcfs/taskclass/c1
> +   creates a taskclass named c1 , while
> +   # mkdir /rcfs/socket_class/s1
> +   creates a socketclass named s1 

Uh, having taskclass vs. socket *underscore* class is ugly, right?

> +   # cat /rcfs/taskclass/c1/shares
> +
> +   "guarantee=-2,limit=-2,total_guarantee=100,max_limit=100" is the default
> +   value set for resources that have controllers registered with CKRM.

Unbalanced ".

> +   If any of these parameters are not specified, the current value will be
> +   retained. 

Could this be made sysfs-like one-value-per-file?


> +6. Get the statictics of different resources of a class

typo in statistics.

> +   # cat /rcfs/tasksclass/c1/stats
> +   shows c1's statistics for each resource with a registered resource
> +   controller.
> +
> +   # cat /rcfs/socket_class/s1/stats
> +   show's s1's stats for the listenaq controller.	

listenaq? too many 's?

> +CRBCE
> +----------

Perhaps at least here acronym should be explained.


> +To illustrate the utility of the data gathered by crbce, we provide a
> +userspace daemon called crbcedmn that prints the header info received

Uh that's really creative name for deamon. Try to pronounce it few times...
We do not have syslogdmn, perhaps it should be crbced?

> +from the records sent by the crbce module.
> +
> +0. Ensure that a CKRM-enabled kernel with following options configured
> +   has been compiled. At a minimum, core, rcfs, atleast one classtype,
> +   delay-accounting patch and relayfs. 
Sentence with no verb?
> +++ linux-2.6.10-rc2/Documentation/ckrm/installation	2004-11-19 20:50:04.023930579 -0800
> @@ -0,0 +1,70 @@

Other text files in documentation have .txt extension, perhaps these should
have it, too? And install.txt is probably better name.


> +    This will create the directories /rcfs/taskclass and
> +    /rcfs/socketclass which are the "roots" of subtrees for creating
> +    taskclasses and socketclasses respectively.

So is it socketclass or socket_class?


				Pavel

-- 
64 bytes from 195.113.31.123: icmp_seq=28 ttl=51 time=448769.1 ms         

