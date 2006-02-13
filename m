Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030273AbWBMXPm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030273AbWBMXPm (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Feb 2006 18:15:42 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030267AbWBMXPV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Feb 2006 18:15:21 -0500
Received: from smtp-5.smtp.ucla.edu ([169.232.47.138]:59294 "EHLO
	smtp-5.smtp.ucla.edu") by vger.kernel.org with ESMTP
	id S1030269AbWBMXPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Feb 2006 18:15:19 -0500
Date: Mon, 13 Feb 2006 15:15:16 -0800 (PST)
From: Chris Stromsoe <cbs@cts.ucla.edu>
To: Neil Brown <neilb@suse.de>
cc: linux-kernel@vger.kernel.org
Subject: Re: any FS with tree-based quota system?
In-Reply-To: <17393.904.252068.459547@cse.unsw.edu.au>
Message-ID: <Pine.LNX.4.64.0602131459150.330@potato.cts.ucla.edu>
References: <Pine.LNX.4.64.0602130959270.28894@potato.cts.ucla.edu>
 <17393.904.252068.459547@cse.unsw.edu.au>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
X-Probable-Spam: no
X-Spam-Report: none
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 14 Feb 2006, Neil Brown wrote:
> On Monday February 13, cbs@cts.ucla.edu wrote:
>>
>> I would like to be able to apply a quota to a particular tree, and have 
>> every file and directory in the path of that tree count toward that 
>> tree's quota usage.  I can prevent hard links across trees.
>>
>> I noticed that Neil Brown wrote some patches fairly early on in the 2.4 
>> cycle to do tree-based quota by UID.  The last patch-set I found was 
>> against 2.4.14 
>> (http://cgi.cse.unsw.edu.au/~neilb/patches/linux/2.4.14/) from late 
>> 2001, and did not come with patches to quota-tools.
>
> Following is my tree-quota patch updated to 2.6.14.3.  However it 
> doesn't do exactly what you claim to want.

Thanks.

> You still need to assign a uid to each user (the kernel needs some 
> number to use as an index into the quotas file).  But only the top-level 
> directory of each tree needs to be owned by the uid.  Files beneath the 
> top can be owned by anyone.

I'm hoping to modify your patch to use the inode at the root of the tree 
instead of a particular uid as the quota owner, so that setting a quota of 
50Mb on /some/location would charge usage for any children of 
/some/location to the inode of /some/location.

> I can dig-up a patch for quota-utils if you want to proceed with this.

I would appreciate that.



-Chris
