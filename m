Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266009AbUFIXjh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266009AbUFIXjh (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 9 Jun 2004 19:39:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266017AbUFIXjh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 9 Jun 2004 19:39:37 -0400
Received: from sccrmhc13.comcast.net ([204.127.202.64]:59897 "EHLO
	sccrmhc13.comcast.net") by vger.kernel.org with ESMTP
	id S266009AbUFIXjf (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 9 Jun 2004 19:39:35 -0400
Message-ID: <40C79FE2.4040802@namesys.com>
Date: Wed, 09 Jun 2004 16:40:18 -0700
From: Hans Reiser <reiser@namesys.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Dave Jones <davej@redhat.com>
CC: Chris Mason <mason@suse.com>,
       =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>,
       reiserfs-dev@namesys.com, linux-kernel@vger.kernel.org
Subject: Re: [STACK] >3k call path in reiserfs
References: <20040609122226.GE21168@wohnheim.fh-wedel.de> <1086784264.10973.236.camel@watt.suse.com> <1086800028.10973.258.camel@watt.suse.com> <40C74388.20301@namesys.com> <1086801345.10973.263.camel@watt.suse.com> <40C75141.7070408@namesys.com> <20040609182037.GA12771@redhat.com>
In-Reply-To: <20040609182037.GA12771@redhat.com>
X-Enigmail-Version: 0.83.3.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dave Jones wrote:

>On Wed, Jun 09, 2004 at 11:04:49AM -0700, Hans Reiser wrote:
> > >>Can you give me some background on whether this is causing real problems 
> > >>for real users?
> > >
> > >Especially with the 4k stack option enabled, it will cause real problems
> > >for real users.  A better change would be to cut down on the size of the
> > >tree balance struct, but that would be more invasive.  For starters we
> > >might be able to switch from ints to shorts for some of the arrays.
> > >
> > >-chris
> > >
> > Can you tell me about the "4k stack option"?
>
>Arjan's original patch & announcement are at
>http://people.redhat.com/arjanv/4kstack.patch
>
>		Dave
>
>
>
>  
>
Forcing kernel developers to distort their coding to keep stack sizes 
small is not a good idea, as it makes the whole kernel harder to code 
for a not very compelling (for 99% of users, please argue with me if you 
think it is otherwise) benefit.

I do not think I favor disturbing V3's stability for the sake of the 4k 
stack option, but my mind is still open.
