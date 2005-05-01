Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261317AbVEAEQd@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261317AbVEAEQd (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 1 May 2005 00:16:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261521AbVEAEQd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 1 May 2005 00:16:33 -0400
Received: from warden2-p.diginsite.com ([209.195.52.120]:36280 "HELO
	warden2.diginsite.com") by vger.kernel.org with SMTP
	id S261317AbVEAEQ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 1 May 2005 00:16:29 -0400
Date: Sat, 30 Apr 2005 21:14:45 -0700 (PDT)
From: David Lang <dlang@digitalinsight.com>
X-X-Sender: dlang@dlang.diginsite.com
To: "Theodore Ts'o" <tytso@mit.edu>
cc: Daniel Phillips <phillips@istop.com>, Lars Marowsky-Bree <lmb@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/7] dlm: overview
In-Reply-To: <20050501035746.GA6578@thunk.org>
Message-ID: <Pine.LNX.4.62.0504302110530.9153@qynat.qvtvafvgr.pbz>
References: <20050425151136.GA6826@redhat.com> <20050428145715.GA21645@marowsky-bree.de>
 <Pine.LNX.4.62.0504281731450.6139@qynat.qvtvafvgr.pbz>
 <200504282152.31137.phillips@istop.com> <Pine.LNX.4.62.0504291011220.7439@qynat.qvtvafvgr.pbz>
 <20050501035746.GA6578@thunk.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 30 Apr 2005, Theodore Ts'o wrote:

>> the claim was that UUID's are unique and don't have to be assigned by the
>> admins.
>>
>> I'm saying that in my experiance there isn't any standard or reliable way
>> to generate such a UUID and I'm asking for the people makeing the
>> claim to educate me on what I'm missing becouse a reliable UUID for linux
>> on all hardware would be extremely useful for many things.
>
> How to reliably generate universally unique ID's have been well
> understood for over twenty years, and is implemented on nearly every
> Linux system for over ten.  For more information I refer you to
> doc/draft-leach-uuid-guids-01.txt in the e2fsprogs sources, and for an
> implementation, the uuid library in e2fsprogs, which is used by both
> GNOME and KDE.  UUID's are also used by Apple's Mac OS X (using
> libuuid from e2fsprogs), Microsoft Windows, more historically by the
> OSF DCE, and even more historically by the Apollo Domain OS (1980 --
> 1989, RIP).  Much of this usage is due to the efforts of Paul Leach, a
> key architect at Apollo, and OSF/DCE, before he left and joined the
> Dark Side at Microsoft.
>
> Also, FYI the OSF/DCE, including the specification for generating
> UUID's, was submitted by OSF to the X/Open where it was standardized,
> who in turn submitted it to the ISO where it was approved as
> Publically Available Specification (PAS).  So technically, there *is*
> an internationally standardized way of generating UUID's, and it is
> already implemented and deployed on nearly all Linux systems.

thanks for the pointer. I wasn't aware of this draft (although from a 
reasonably short search it appears that this draft was allowed to expire, 
with no direct replacement that I could find)

I will say that this wasn't what I thought we was being talked about for 
cluster membership, becouse I assumed that the generation of an ID would 
be repeatable so that a cluster node could be rebuilt and re-join the 
cluster with it's old ID.

David Lang

-- 
There are two ways of constructing a software design. One way is to make it so simple that there are obviously no deficiencies. And the other way is to make it so complicated that there are no obvious deficiencies.
  -- C.A.R. Hoare
