Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S317547AbSGXU5L>; Wed, 24 Jul 2002 16:57:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S317552AbSGXU5L>; Wed, 24 Jul 2002 16:57:11 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:1035 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id <S317547AbSGXU5L>; Wed, 24 Jul 2002 16:57:11 -0400
To: linux-kernel@vger.kernel.org
From: torvalds@transmeta.com (Linus Torvalds)
Subject: Re: type safe lists (was Re: PATCH: type safe(r) list_entry repacement: generic_out_cast)
Date: Wed, 24 Jul 2002 21:00:05 +0000 (UTC)
Organization: Transmeta Corporation
Message-ID: <ahn4gl$347$1@penguin.transmeta.com>
References: <20020723114703.GM11081@unthought.net.suse.lists.linux.kernel> <3D3E75E9.28151.2A7FBB2@localhost.suse.lists.linux.kernel> <p73d6tdtg2s.fsf@oldwotan.suse.de>
X-Trace: palladium.transmeta.com 1027544393 13731 127.0.0.1 (24 Jul 2002 20:59:53 GMT)
X-Complaints-To: news@transmeta.com
NNTP-Posting-Date: 24 Jul 2002 20:59:53 GMT
Cache-Post-Path: palladium.transmeta.com!unknown@penguin.transmeta.com
X-Cache: nntpcache 2.4.0b5 (see http://www.nntpcache.org/)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

In article <p73d6tdtg2s.fsf@oldwotan.suse.de>, Andi Kleen  <ak@suse.de> wrote:
>> 
>> As long as your pointers are 32bit this seems to be ok. But on 
>> 64bit implementations pointers are not (unsigned long) so this cast 
>> seems to be wrong.
>
>A pointer fits into unsigned long on all 64bit linux ports.
>The kernel very heavily relies on that.

Not just the kernel, afaik.  I think it's rather tightly integrated into
gcc internals too (ie pointers are eventually just converted to SI
inside the compiler, and making a non-SI pointer would be hard). 

			Linus
