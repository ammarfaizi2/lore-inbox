Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265572AbUABThj (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 2 Jan 2004 14:37:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265574AbUABThj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 2 Jan 2004 14:37:39 -0500
Received: from firewall.conet.cz ([213.175.54.250]:50076 "EHLO
	localhost.localdomain") by vger.kernel.org with ESMTP
	id S265572AbUABThi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 2 Jan 2004 14:37:38 -0500
Message-ID: <3FF5C881.2080004@conet.cz>
Date: Fri, 02 Jan 2004 20:37:37 +0100
From: Libor Vanek <libor@conet.cz>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.4.1) Gecko/20031030
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: =?ISO-8859-1?Q?J=F6rn_Engel?= <joern@wohnheim.fh-wedel.de>
CC: linux-kernel@vger.kernel.org
Subject: Re: Syscall table AKA hijacking syscalls
References: <3FF56B1C.1040308@conet.cz> <20040102151206.GJ1718@actcom.co.il> <3FF59073.3060305@conet.cz> <20040102160020.A24026@infradead.org> <20040102163552.GD31489@wohnheim.fh-wedel.de> <3FF5A36A.5070501@conet.cz> <20040102180431.GB6577@wohnheim.fh-wedel.de> <3FF5BF68.8060303@conet.cz> <20040102191805.GA12905@wohnheim.fh-wedel.de>
In-Reply-To: <20040102191805.GA12905@wohnheim.fh-wedel.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jörn Engel wrote:
> On Fri, 2 January 2004 19:58:48 +0100, Libor Vanek wrote:
> 
>>On Fri, Jan 02, 2004 at 07:04:31PM +0100, Jörn Engel wrote:
>>
>>>On Fri, 2 January 2004 17:59:22 +0100, Libor Vanek wrote:
>>>
>>>>This is also something (but just a bit) different - I don't need "change 
>>>>notification" but "pre-change notification" ;)
>>>
>>>"Vor dem Spiel ist nach dem Spiel" -- Sepp Herberger
>>>
>>>Except for exactly two cases, pre-change and post-change and the same,
>>>just off-by-one.  So you would need a bootup/mount/whenever special
>>>case now, is that a big problem?
>>
>>Probably my english is bad but I don't understand what are you trying to 
>>say (except the german part ;-))
>>A bit more about pre/post-change (if this is what are you trying to say) - 
>>I need allways pre-change because after file is changed I can no longer get 
>>original (pre-change) version of file which I need for snapshot.
> If you take a snapshot on every change within your scope, it doesn't
> really matter whether you do it before or after the change.  Before
> change n is just after change n-1.  All you have to do is take another
> snapshot before the first change, that is the special case.

But this special case in fact means to copy all the data, if wanted to do it 100% working ;-) And I suggest that it wont' go through my exam ;)

> Actually, with userspace notification in place, you could even get
> this with just cvs.  Whenever a file is changed, commit.  cvs add on
> creation, etc.  Yes, it sucks, but implementation simplicity has it's
> own beauty and it would only take a few minutes. :)

I've heard about some fs from Microsoft which should have cvs-like behaviour for all the time ("I want this file version from yesterday") - but I haven't had any details (and I suppose performance hit must be big)

-- 

Libor Vanek




