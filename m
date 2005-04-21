Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261655AbVDUXBp@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261655AbVDUXBp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 21 Apr 2005 19:01:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261637AbVDUXBo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 21 Apr 2005 19:01:44 -0400
Received: from fmr21.intel.com ([143.183.121.13]:11183 "EHLO
	scsfmr001.sc.intel.com") by vger.kernel.org with ESMTP
	id S261628AbVDUXBZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 21 Apr 2005 19:01:25 -0400
Date: Thu, 21 Apr 2005 16:01:13 -0700
From: tony.luck@intel.com
Message-Id: <200504212301.j3LN1Do05507@unix-os.sc.intel.com>
To: Linus Torvalds <torvalds@osdl.org>
cc: linux-ia64@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: ia64 git pull
In-Reply-To: <Pine.LNX.4.58.0504211520250.2344@ppc970.osdl.org>
References: <200504212042.j3LKgng04318@unix-os.sc.intel.com>
 <Pine.LNX.4.58.0504211403080.2344@ppc970.osdl.org>
 <200504212155.j3LLtho04949@unix-os.sc.intel.com>
 <200504212155.j3LLtho04949@unix-os.sc.intel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> It's mainly a clue to bad practice, in my opinion. I personally like the 
> "one repository, one head" approach, and if you want multiple heads you 
> just do multiple repositories (and you can then mix just the object 
> database - set your SHA1_FILE_DIRECTORY environment variable to point to 
> the shared object database, and you're good to go). 

Maybe I just have a terminology problem?

I want to have one "shared objects database" which I keep locally and
mirror publicly at kernel.org/pub/scm/...

I will have several "repositories" locally for various grades of patches,
each of which use SHA1_FILE_DIRECTORY to point to my single repository.
So I never have to worry about getting all the git commands to switch
context ... I just use "cd ../testing", and "cd ../release".

But now I need a way to indicate to consumers of the public shared object
data base which HEAD to use.

Perhaps I should just say "merge 821376bf15e692941f9235f13a14987009fd0b10
from rsync://rsync.kernel.org/pub/scm/linux/kernel/git/aegl/linux-2.6.git"?

That works for interacting with you, because you only pull from me when
I tell you there is something there to pull.

But Andrew had a cron job or somthing to keep polling every day.  So he
needs to see what the HEAD is.


Does this make sense ... or am I still missing the point?

-Tony
