Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263824AbTEGO45 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 10:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263880AbTEGO44
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 10:56:56 -0400
Received: from gateway-1237.mvista.com ([12.44.186.158]:32502 "EHLO
	av.mvista.com") by vger.kernel.org with ESMTP id S263824AbTEGO4s
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 10:56:48 -0400
Message-ID: <3EB92176.8010803@mvista.com>
Date: Wed, 07 May 2003 08:08:38 -0700
From: george anzinger <george@mvista.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2) Gecko/20021202
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Sam Ravnborg <sam@ravnborg.org>
CC: "David S. Miller" <davem@redhat.com>, akpm@zip.com.au,
       kbuild-devel@lists.sourceforge.net, mec@shout.net,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] asm-generic magic
References: <3EB75924.1080304@mvista.com> <1052205991.983.13.camel@rth.ninka.net> <3EB817C9.8020603@mvista.com> <20030506.195511.74729679.davem@redhat.com> <3EB8D36E.10206@mvista.com> <20030507143059.GA1057@mars.ravnborg.org>
In-Reply-To: <20030507143059.GA1057@mars.ravnborg.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg wrote:
> On Wed, May 07, 2003 at 02:35:42AM -0700, george anzinger wrote:
> 
>>If the arch wanted to supply only some of the content, the configure 
>>option as is used with some today, is still available.  CURRENT USAGE 
>>IS NOT AFFECTED.
> 
> 
> The usage of magic symlinks shall be kept minimal. 
> The asm -> $(ARCH)-asm symlink already has caused me troubles when
> doing cross compilation. Also the separate obj tree patch treats
> the symlink with special care.
> 
> the gain should be high introducing one more symlink.
> For what I understood the gain is only to avoid a couple of
> one line files that include another file. Not enough to justify a 
> second symlink IMHO.

That is a good point.  To the other side, the symlink is arch 
independent and is just "asm->."  Also, if you are introducing a file 
with asm code, you either cause all "other" archs to fail (till they 
catch up) or you must introduce the simple one line file in each arch.

-- 
George Anzinger   george@mvista.com
High-res-timers:  http://sourceforge.net/projects/high-res-timers/
Preemption patch: http://www.kernel.org/pub/linux/kernel/people/rml

