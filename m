Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261970AbTFKOWX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Jun 2003 10:22:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261985AbTFKOWX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Jun 2003 10:22:23 -0400
Received: from franka.aracnet.com ([216.99.193.44]:10934 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261970AbTFKOWW
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Jun 2003 10:22:22 -0400
Date: Wed, 11 Jun 2003 07:36:00 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Andrew Morton <akpm@digeo.com>
cc: linux-kernel@vger.kernel.org
Subject: Re: 2.5.70 (virgin) hangs running SDET
Message-ID: <26960000.1055342159@[10.10.2.4]>
In-Reply-To: <20030610222116.2fb9c001.akpm@digeo.com>
References: <60380000.1055188542@flay><20030609140834.11ad0d63.akpm@digeo.com><5930000.1055254447@[10.10.2.4]><12190000.1055266471@flay><20030610124613.40e65da7.akpm@digeo.com><25140000.1055307962@[10.10.2.4]> <20030610222116.2fb9c001.akpm@digeo.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>> OK, did that. your patches + debug up the wazoo. Bugger all output,
>>  and a hang that looks similar, but the culprit is hiding even more,
>>  as far as I can't see ;-(
> 
> yes, nobody's spinning on the /proc lock any more.
> 
> I don't understand why all the tasks in set_cpus_allowed() are showing up
> as being in " R " state.  Possibly the wait_for_completion() in there is
> stack gunk and they're really spinning on the runqueue lock?

Damn it, we really need this shit to use frame pointers, and give accurate
info ;-(
 
> You haven't tried disabling sched_migrate_task() yet?

Nope, will do that next, but I presume you mean balance on exec, from
previous conversations ... 

Thanks,

M.


