Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263185AbVBESuG@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263185AbVBESuG (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 5 Feb 2005 13:50:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263633AbVBESuG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 5 Feb 2005 13:50:06 -0500
Received: from terminus.zytor.com ([209.128.68.124]:12701 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S273525AbVBESsJ
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 5 Feb 2005 13:48:09 -0500
Message-ID: <42051460.9060208@zytor.com>
Date: Sat, 05 Feb 2005 10:45:52 -0800
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Mozilla Thunderbird 0.9 (X11/20041127)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Adrian Bunk <bunk@stusta.de>
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] add compiler-gcc4.h
References: <20050130130308.GK3185@stusta.de> <m1pszn3t2w.fsf@muc.de> <41FCFED4.1070301@tiscali.de> <ctrtbe$570$1@terminus.zytor.com> <20050205135026.GC3129@stusta.de>
In-Reply-To: <20050205135026.GC3129@stusta.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Adrian Bunk wrote:
> 
> As I already said in this thread:
>   The currently used file for gcc 4 is compiler-gcc+.h, not
>   compiler-gcc3.h .
> 
> And the current setup is to have one file for every major number of gcc.
> I have no strong opinion whether this approach or the approach of one 
> file for all gcc versions is better - but with the current approach, 
> everything else than a separate file for gcc 4 wasn't logical.

Yes it is.  It's perfectly logical: gcc+ contains the "going forward" 
version, and until it supports some feature that isn't in all versions 
of gcc4, it's the right thing to do.

> I can offer the following choices:
> - please apply this compiler-gcc4.h patch
> - let me send a patch merging all compiler-gcc*.h files into one
>   compiler-gcc.h file
> - let me send a patch merging all compiler-gcc*.h files back into 
>   compiler.h

No.  Leave it the way it currently is until there is a *reason* to fork 
a gcc4 module.

This isn't a cleanup you're proposing, it's a mess-up.

	-hpa
