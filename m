Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261308AbTETWlp (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 May 2003 18:41:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261311AbTETWlk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 May 2003 18:41:40 -0400
Received: from rwcrmhc53.attbi.com ([204.127.198.39]:19915 "EHLO
	rwcrmhc53.attbi.com") by vger.kernel.org with ESMTP id S261308AbTETWlh
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 May 2003 18:41:37 -0400
Message-ID: <3ECAB224.9070002@quark.didntduck.org>
Date: Tue, 20 May 2003 18:54:28 -0400
From: Brian Gerst <bgerst@quark.didntduck.org>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3) Gecko/20030313
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Kai Germaschewski <kai@tp1.ruhr-uni-bochum.de>
CC: mikpe@csd.uu.se, Brian Gerst <bgerst@didntduck.org>,
       Sam Ravnborg <sam@ravnborg.org>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Update fs Makefiles
References: <Pine.LNX.4.44.0305201139020.24017-100000@chaos.physics.uiowa.edu>
In-Reply-To: <Pine.LNX.4.44.0305201139020.24017-100000@chaos.physics.uiowa.edu>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kai Germaschewski wrote:
> On Tue, 20 May 2003 mikpe@csd.uu.se wrote:
> 
> 
>>Kai Germaschewski writes:
>> > o Possibly add "-y" support to 2.4 (it's a pretty trivial change)
>>
>>That's the worst thing you could do for those of us maintaining
>>2.4/2.5 compatibility in drivers etc.
>>Having to check "oh I'm in 2.4, let's see if I'm in 2.4.23 or
>>$VENDOR 2.4.blah because then these random 2.5-like changes occurred"
>>sucks like h*ll.
> 
> 
> It'd be an additional feature, i.e. if it causes trouble for the code you 
> maintain, don't use it.
> 
> People who want a Makefile which works in all 2.4 + vendor then would 
> choose to stay with -objs, whereas people who prefer do have 2.4.latest 
> and 2.5 in sync could use -y, like, I'd guess, USB.
> 
> --Kai

Easiest way to maintain 2.4 compatability is to add:

foo-objs := $(foo-y)

--
				Brian Gerst


