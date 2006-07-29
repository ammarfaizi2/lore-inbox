Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932154AbWG2TWs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932154AbWG2TWs (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jul 2006 15:22:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752070AbWG2TWr
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jul 2006 15:22:47 -0400
Received: from e34.co.us.ibm.com ([32.97.110.152]:13965 "EHLO
	e34.co.us.ibm.com") by vger.kernel.org with ESMTP id S1752062AbWG2TWr
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jul 2006 15:22:47 -0400
Subject: Re: [Patch] 1/5 in support of hot-add memory x86_64 nodes_add
	cleanup
From: keith mannthey <kmannth@us.ibm.com>
Reply-To: kmannth@us.ibm.com
To: Andi Kleen <ak@suse.de>
Cc: lkml <linux-kernel@vger.kernel.org>,
       lhms-devel <lhms-devel@lists.sourceforge.net>,
       discuss <discuss@x86-64.org>, andrew <akpm@osdl.org>,
       dave hansen <haveblue@us.ibm.com>,
       kame <kamezawa.hiroyu@jp.fujitsu.com>, konrad <darnok@us.ibm.com>
In-Reply-To: <200607291824.25584.ak@suse.de>
References: <1154141535.5874.145.camel@keithlap>
	 <200607291824.25584.ak@suse.de>
Content-Type: text/plain
Organization: Linux Technology Center IBM
Date: Sat, 29 Jul 2006 12:22:42 -0700
Message-Id: <1154200962.7900.28.camel@keithlap>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 (2.0.4-4) 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 2006-07-29 at 18:24 +0200, Andi Kleen wrote:
> If you add attachments (which are harder to review because they cannot be 
> quoted) put at least a copy of the description into the attachment and make
> them inline.

Sorry I will do this if the future.  
> 
> One thing that's unclear to me is why you make the reserve hotadd Kconfig
> user visible (and why put it into Kconfig at all). I don't think it should be 
> user visible.

It was suggested to me in an earlier patch set to move RESERVE_HOTADD to
Kconfig.  I can make it a non-user option.  It seems that MEMORY_HOTPLUG
is a user options so I figured why not make RESERVE one as well.  Also I
don't think people should use reserve with sparsmem. 

> Also most of the patch seems to be renaming a variable which seems somewhat
> pointless?

  srat.c as it stands is very reserve specific (understandably).
Changing found_add_area to reserve_add_area is extra change help the var
names be more clear with the sharing of the code path as to what is
happening.  reserve_add_area is used as a switch for the reserve path. 
Since the logic of the code was changing I thought it would be a good
time to change the name to help the clarity of the code. 

  If you see this as a waste/unneeded I will revert the name change.  


Thanks for the comments,
  Keith 

