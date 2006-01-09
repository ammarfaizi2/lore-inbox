Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751346AbWAIVFW@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751346AbWAIVFW (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 9 Jan 2006 16:05:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751351AbWAIVFW
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 9 Jan 2006 16:05:22 -0500
Received: from omx1-ext.sgi.com ([192.48.179.11]:55733 "EHLO
	omx1.americas.sgi.com") by vger.kernel.org with ESMTP
	id S1751346AbWAIVFV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 9 Jan 2006 16:05:21 -0500
Message-ID: <43C2CFBD.8040901@sgi.com>
Date: Mon, 09 Jan 2006 15:03:57 -0600
From: Eric Sandeen <sandeen@sgi.com>
User-Agent: Mozilla Thunderbird 1.0.6-1.1.fc4 (X11/20050720)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org,
       linux-xfs@oss.sgi.com
Subject: Re: xfs: Makefile-linux-2.6 => Makefile?
References: <20060109164214.GA10367@mars.ravnborg.org> <20060109164611.GA1382@infradead.org>
In-Reply-To: <20060109164611.GA1382@infradead.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Christoph Hellwig wrote:
> On Mon, Jan 09, 2006 at 05:42:14PM +0100, Sam Ravnborg wrote:
> 
>>Hi hch.
>>
>>Any specific reason why xfs uses a indirection for the Makefile?
>>It is planned to drop export of VERSION, PATCHLEVEL etc. from
>>main makefile and it is OK except for xfs due to the funny
>>Makefile indirection.
>>
>>I suggest:
>>git mv fs/xfs/Makefile-linux-2.6 fs/xfs/Makefile
> 
> 
> I'd be all for it, but the SGI people like this layout to keep a common
> fs/xfs for both 2.4 and 2.6 (with linux-2.4 and linux-2.6 subdirs respectively)
> 
> p.s. and no, I'm not official xfs maintainer and never have been, so cc set
> to linux-xfs were all interested parties hang around.
> 

Yep, our internal tree has both linux-2.4/ and linux-2.6/ subdirs, so this is 
handy internal to sgi.  But I don't have a big problem with the kernel.org code 
losing the indirection, even if we keep it here.  I'd check with Nathan first 
though, because he'd have to work around that difference when he pushes code out.

Out of curiosity, what's the reason to drop VERSION & PATCHLEVEL... seems handy 
if you have a common body of code that needs to build for various kernels, with 
various Makefiles to suit.  As above. :)

Thanks,

-Eric
