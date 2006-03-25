Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751070AbWCYBUE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751070AbWCYBUE (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 24 Mar 2006 20:20:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751106AbWCYBUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 24 Mar 2006 20:20:03 -0500
Received: from mx02.cybersurf.com ([209.197.145.105]:54174 "EHLO
	mx02.cybersurf.com") by vger.kernel.org with ESMTP id S1751012AbWCYBUA
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 24 Mar 2006 20:20:00 -0500
Subject: Re: [RFC][UPDATED PATCH 2.6.16] [Patch 9/9] Generic netlink
	interface for delay accounting
From: jamal <hadi@cyberus.ca>
Reply-To: hadi@cyberus.ca
To: balbir@in.ibm.com
Cc: Matt Helsley <matthltc@us.ibm.com>, Shailabh Nagar <nagar@watson.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       netdev <netdev@vger.kernel.org>
In-Reply-To: <20060324145459.GA7495@in.ibm.com>
References: <1142296834.5858.3.camel@elinux04.optonline.net>
	 <1142297791.5858.31.camel@elinux04.optonline.net>
	 <1142303607.24621.63.camel@stark> <1142304506.5219.34.camel@jzny2>
	 <20060322074922.GA1164@in.ibm.com> <1143122686.5186.27.camel@jzny2>
	 <20060323154106.GA13159@in.ibm.com> <1143209061.5076.14.camel@jzny2>
	 <20060324145459.GA7495@in.ibm.com>
Content-Type: text/plain
Organization: unknown
Date: Fri, 24 Mar 2006 20:19:25 -0500
Message-Id: <1143249565.5184.6.camel@jzny2>
Mime-Version: 1.0
X-Mailer: Evolution 2.2.1.1 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 2006-24-03 at 20:24 +0530, Balbir Singh wrote:

> Hmm... Would it be ok to send one message with the following format
> 
> 1. TLV=TASKSTATS_TYPE_PID
> 2. TLV=TASKSTATS_TYPE_STATS
> 3. TLV=TASKSTATS_TYPE_TGID
> 4. TLV=TASKSTATS_TYPE_STATS
> 
> It would still be one message, except that 3 and 4 would be optional.
> What do you think?
> 

No, that wont work since #2 and #4 are basically the same TLV. [Recall
that "T" is used to index an array]. Your other alternative is to have
#4 perhaps called TASKSTATS_TGID_STATS and #2 TASKSTATS_PID_STATS
although that would smell a little.
Dont be afraid to do the nest, it will be a little painful initially but
i am sure once you figure it out you will appreciate it.

cheers,
jamal

