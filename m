Return-Path: <linux-kernel-owner+willy=40w.ods.org-S269057AbUJQFe7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S269057AbUJQFe7 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Oct 2004 01:34:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269060AbUJQFe7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Oct 2004 01:34:59 -0400
Received: from relay.pair.com ([209.68.1.20]:34059 "HELO relay.pair.com")
	by vger.kernel.org with SMTP id S269057AbUJQFe5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Oct 2004 01:34:57 -0400
X-pair-Authenticated: 24.126.73.164
Message-ID: <4171F741.2070209@kegel.com>
Date: Sat, 16 Oct 2004 21:38:25 -0700
From: Dan Kegel <dank@kegel.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040913
X-Accept-Language: en, de-de
MIME-Version: 1.0
To: Albert Cahalan <albert@users.sf.net>
CC: linux-kernel mailing list <linux-kernel@vger.kernel.org>, sam@ravnborg.org
Subject: Re: Building on case-insensitive systems
References: <1097989574.2674.14246.camel@cube>
In-Reply-To: <1097989574.2674.14246.camel@cube>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Cahalan wrote:
>>There are today ~1400 files named *.S in the tree, but none named *.s.
>>So my idea was to do it like:
>>*.S => *.asm => *.o
> 
> The logic is sound, but... yuck!

Yes, but worth it, I think.  Maybe some configure magic could
pick .asm as the suffix only when building on case-insensitive
filesystems, if that's the only way to make this palatable
to those devoted to the .s/.S idiom.

>>Btw. this is not about "case-challenged" filesystems in general.
>>This is about making the kernel usefull out-of-the-box for the
>>increasing embedded market. Less work-around patces needed the
>>better. And these people are oftenb ound to Windoze boxes - for
>>different reasons. And the individual developer may not be able
>>to change this.
> 
> The difficulty in building on a case-insensitive filesystem may
> be the only hope these developers have for escaping Windows.
> You turn "we must have Linux build systems to build our product"
> into the less effective "we want Linux".       
> 
> For the sake of these suffering developers, it would be better
> to make sure that building Linux on Windows is a lost cause.
> We could name a file "con" or "a:foo" for example.

You are betting that you can force developers to switch away
from Windows and MacOSX workstations.  That's like
trying to get someone to stop smoking.  Yes, they should stop,
but nagging them will just annoy them.  In particular,
they'll simply apply the patch that makes the pain go away.
We may as well be nice and apply the patch in the mainline.
- Dan

-- 
Trying to get a job as a c++ developer?  See http://kegel.com/academy/getting-hired.html
