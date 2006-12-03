Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1759641AbWLCMtQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759641AbWLCMtQ (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 3 Dec 2006 07:49:16 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758343AbWLCMtQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 3 Dec 2006 07:49:16 -0500
Received: from mx1.redhat.com ([66.187.233.31]:49539 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1757961AbWLCMtP (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 3 Dec 2006 07:49:15 -0500
Message-ID: <4572C7C8.5050900@redhat.com>
Date: Sun, 03 Dec 2006 07:49:12 -0500
From: Jeff Layton <jlayton@redhat.com>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: Brad Boyer <flar@allandria.com>
CC: linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH] ensure i_ino uniqueness in filesystems without permanent
 inode numbers (via idr)
References: <457040C4.1000002@redhat.com> <20061201085227.2463b185.randy.dunlap@oracle.com> <20061201172136.GA11669@dantu.rdu.redhat.com> <20061202053013.GC26389@cynthia.pants.nu> <45723CDB.1060304@redhat.com> <20061202125851.GA30187@cynthia.pants.nu>
In-Reply-To: <20061202125851.GA30187@cynthia.pants.nu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Brad Boyer wrote:
> 
> This sounds slightly petty to me. For example, generic_file_read() is
> there just to make it easier to implement the read callback, but it
> isn't required. In fact, I would think that any filesystem complex
> enough to be worth making proprietary would not use it. However, that
> doesn't seem to me to be a good argument for marking it GPL-only. The
> functionality in question is easier to reimplement, but that doesn't
> make it right to force it on people just because of a license choice.
> 

Yes, most filesystems have their own scheme for managing i_ino 
assignment, so this is primarily for "pseudo-filesystems". Stuff like 
pipefs, sockfs, /proc, etc...

>> I'm certainly open to discussion though. Is there a compelling reason to 
>> open this up to proprietary software authors?
> 
> I don't think there is a compelling reason to open it up since the
> functionality could be reimplemented if needed, but I also think
> the only reason it is being marked GPL-only is the very common
> attitude that there should not be any proprietary modules.
> 
> To be honest, I think it looks bad for someone associated with redhat
> to be suggesting that life should be made more difficult for those
> who write proprietary software on Linux. The support from commercial
> software is a major reason for the success of the RHEL product line.
> I can't imagine that this attitude will affect support from software
> companies as long as there is a demand for software on Linux, but
> it isn't exactly supportive.
> 

I have no problem with someone writing, selling and supporting 
proprietary modules. Knock yourself out. I just don't see a reason why I 
should contribute code to such an effort.

Still though, this was coded in part on company time. I certainly don't 
want to go against Red Hat's policy in such a matter, so I'll do some 
due diligence internally as to how this should be done.

In the meantime, does anyone have objections or comments on this 
approach on technical grounds?

Thanks,
Jeff
