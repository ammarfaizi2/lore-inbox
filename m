Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264913AbSJVSQt>; Tue, 22 Oct 2002 14:16:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264906AbSJVSPd>; Tue, 22 Oct 2002 14:15:33 -0400
Received: from kathmandu.sun.com ([192.18.98.36]:31629 "EHLO kathmandu.sun.com")
	by vger.kernel.org with ESMTP id <S264905AbSJVSPN>;
	Tue, 22 Oct 2002 14:15:13 -0400
Message-ID: <3DB59722.2090701@sun.com>
Date: Tue, 22 Oct 2002 11:21:22 -0700
From: Tim Hockin <thockin@sun.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.1) Gecko/20020827
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Jesse Pollard <pollard@admin.navo.hpc.mil>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [BK PATCH 1/4] fix NGROUPS hard limit (resend)
References: <200210220036.g9M0aP831358@scl2.sfbay.sun.com> <1035308740.31873.107.camel@irongate.swansea.linux.org.uk> <3DB58CBD.3030207@sun.com> <200210221303.47488.pollard@admin.navo.hpc.mil>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jesse Pollard wrote:

> Does it actually work with NFS???? or any networked file system?
> Most of them limit ngroups to 16 to 32, and cannot send any data
> if there is an overflow, since that overflow would replace all of the
> data you try to send/recieve...

NFS has a smaller limit, that is correct.  An unfortunate limitation.

> And I really doubt that anybody has 10000 unique groups (or even
> close to that) running under any system. The center I'm at has
> some of the largest UNIX systems ever made, and there are only
> about 600 unique groups over the entire center. The largest number
> of groups a user can be in is 32. And nobody even comes close.

I'm glad it doesn't affect you.  If it was a more common problem, it 
would have been solved a long time ago.  It does affect some people, 
though.  Maybe they can redesign their group structures, but why not 
remove this arbitrary limit, since we can?

Tim

-- 
Tim Hockin
Systems Software Engineer
Sun Microsystems, Linux Kernel Engineering
thockin@sun.com

