Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S129311AbRBTCMH>; Mon, 19 Feb 2001 21:12:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S129466AbRBTCL5>; Mon, 19 Feb 2001 21:11:57 -0500
Received: from adsl-64-163-64-74.dsl.snfc21.pacbell.net ([64.163.64.74]:45061
	"EHLO konerding.com") by vger.kernel.org with ESMTP
	id <S129311AbRBTCLo>; Mon, 19 Feb 2001 21:11:44 -0500
Message-Id: <200102200211.f1K2BO002802@konerding.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
cc: neilb@cse.unsw.edu.au (Neil Brown), linux-kernel@vger.kernel.org,
        nfs@lists.sourceforge.net, mason@suse.com, dek_ml@konerding.com
Subject: Re: problems with reiserfs + nfs using 2.4.2-pre4 
In-Reply-To: Your message of "Tue, 20 Feb 2001 01:24:27 GMT."
             <E14V1Xa-0005Bf-00@the-village.bc.nu> 
Date: Mon, 19 Feb 2001 18:11:23 -0800
From: dek_ml@konerding.com
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox writes:
>>  This may seem like a lot, but several of these are already
>>  requirements which most filesystems don't meet, and other are there
>>  to tidy-up interfaces and make locking more straight forward.
>
>As a 2.5 thing it sounds like a very sensible path. It will also provide
>some of the operations groundwork needed for file systems that can only use
>NFS4 temporary handles
>

OK so I think what I can take from this is: for kernel 2.4 in the foreseeable
future, reiserfs over NFS won't work without a special patch.  And, filesystems
other than ext2 in general might not support NFS.  This all has to do with
internal design decisions, results of people coding against those decisions,
possibly abusing the decisions to acheive their own goals, etc, etc, all
of which lead to problems when the underlying design decisions changed and broke
code which depended on the old decisions.  

For the foreseeable future I am going to stick with ext2 for my NFS-exported
directories.  I think these problems need to be carefully stated in the Configure.help
for each filesystem which does not support NFS ... Configure.help is often the
most authoritative and up-to-date technical description of a particular kernel's
capabilities.

Dave
