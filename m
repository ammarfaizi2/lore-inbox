Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750983AbWINQY1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750983AbWINQY1 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 14 Sep 2006 12:24:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750984AbWINQY1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 14 Sep 2006 12:24:27 -0400
Received: from terminus.zytor.com ([192.83.249.54]:42946 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S1750974AbWINQY0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 14 Sep 2006 12:24:26 -0400
Message-ID: <4509821C.2050502@zytor.com>
Date: Thu, 14 Sep 2006 09:23:56 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Albert Cahalan <acahalan@gmail.com>
CC: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>, Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH] i386/x86_64 signal handler arg fixes
References: <787b0d920609140134j5935c743kae4af8d51eea2a90@mail.gmail.com>	 <200609141211.53087.ak@suse.de>	 <787b0d920609140801r452ff7d7vdc2d96865836eefc@mail.gmail.com>	 <200609141540.44984.ak@suse.de> <787b0d920609140901l46ce6cd3l400c33e74a67b8db@mail.gmail.com>
In-Reply-To: <787b0d920609140901l46ce6cd3l400c33e74a67b8db@mail.gmail.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
> 
>> > Currently you remap signals. Whatever you do this for
>> > regparm(0) should also be done for regparm(3).
>>
>> Not sure I parse you here. You're asking how to fix the regparm(3)
>> case?
> 
> No. I'd thought that the two cases should match.
> The regparm(3) case should remap signals if and only if
> the regparm(0) case remaps signals. Perhaps this
> is not correct if the remapping is not needed for
> native Linux apps; I doubt iBCS stuff would ever be
> needing regparm(3) support.
> 

The two should definitely match, though.  Otherwise, life will be confusing.

> Since you plan to delete the remapping cruft from
> the regparm(0) case, then obviously it should not
> be added to the regparm(3) case.

Indeed.

	-hpa
