Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S288553AbSAHXKs>; Tue, 8 Jan 2002 18:10:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S288552AbSAHXKm>; Tue, 8 Jan 2002 18:10:42 -0500
Received: from petasus.iil.intel.com ([192.198.152.69]:38869 "EHLO
	petasus.iil.intel.com") by vger.kernel.org with ESMTP
	id <S288550AbSAHXKX>; Tue, 8 Jan 2002 18:10:23 -0500
Message-ID: <3C3B7C3D.1090000@intel.com>
Date: Wed, 09 Jan 2002 01:09:49 +0200
From: Vladimir Kondratiev <vladimir.kondratiev@intel.com>
Organization: Intel
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:0.9.7) Gecko/20011221
X-Accept-Language: en-us
MIME-Version: 1.0
To: nelcomp@attglobal.net
CC: linux-kernel@vger.kernel.org
Subject: Re: __FUNCTION__
In-Reply-To: <3C3B664B.3060103@intel.com> <3C3B6BD2.9070201@attglobal.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Ian S. Nelson wrote:

> I suspect this might be about as religious an issue as there is but 
> has anyone thought about coming up with some "standard" debugging 
> macros, perhaps something that can be configured at compile time from 
> the configuration for everyone to use everywhere?  I've got my own 
> debug macros,  essentially a printk with the file, function and line 
> added wrapped in #ifdef DEBUG.  I've seen several other schemes in 
> other parts of the kernel and now some of them aren't correct.
>
> I guess what I would envision is some kind of debug menu item in the 
> configuration tool that let's you select if you want messages, and/or 
> filenames, and/or line numbers, and/or function names, or nothing at 
> all.   They could still be controlled at the module level by defining 
> or not defining some constant.   It just seems kind of pointless to 
> have 10-20 different macros or methods that all do the same thing for 
> different parts of the kernel. 
> Ian
>
I am fully agree with idea of one set of debug/info/warn/etc. macros.
My main point in prev. posting was to fix __FUNCTION__, for USB this 
seems to be easy doable since there is already subsystem-wide dbg() and 
alike macros. Actually, there is no sense for __FUNCTION__ to appear 
outside macros; in real code it provides no added value (except easy 
cut-n-paste from function to function).



