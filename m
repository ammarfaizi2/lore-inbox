Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264655AbUD1FUY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264655AbUD1FUY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Apr 2004 01:20:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264661AbUD1FUX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Apr 2004 01:20:23 -0400
Received: from zcars04f.nortelnetworks.com ([47.129.242.57]:39130 "EHLO
	zcars04f.nortelnetworks.com") by vger.kernel.org with ESMTP
	id S264655AbUD1FUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Apr 2004 01:20:19 -0400
Message-ID: <408F3EE4.1080603@nortelnetworks.com>
Date: Wed, 28 Apr 2004 01:19:32 -0400
X-Sybari-Space: 00000000 00000000 00000000 00000000
From: Chris Friesen <cfriesen@nortelnetworks.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.6) Gecko/20040113
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: ncunningham@linuxmail.org
CC: Jurriaan <thunder7@xs4all.nl>, linux-kernel@vger.kernel.org
Subject: Re: What does tainting actually mean?
References: <opr65eq9ncshwjtr@laptop-linux.wpcb.org.au> <20040428042742.GA1177@middle.of.nowhere> <opr65f48sfshwjtr@laptop-linux.wpcb.org.au>
In-Reply-To: <opr65f48sfshwjtr@laptop-linux.wpcb.org.au>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Nigel Cunningham wrote:

> Is that true? We can see where the oops occurs. If it's in the module,  
> nothing more needs to be said. If it's in the kernel itself, we can 
> check  our source. We could check all the calls the module makes to open 
> source  code and validate that the parameters are correct. We should be 
> able to  say with authority 'the module is doing the wrong thing'. We 
> might not be  able to say exactly what, but we could determine that it 
> is the module.

If only it were that easy.

There has already been a case mentioned of a binary module that messed up something that was only 
visible once that module was unloaded and another one loaded.  It all depends totally on usage patterns.

Generally speaking, if a user is technical enough to patch their kernel, they're aware of the 
possible problems and will submit bug reports with things like "kernel version blah, with the foo 
and bar patches applied".  The developers can then say "there's a known issue with foo/bar together".

Binary modules, on the other hand, are often loaded up by users that know just barely enough to 
download them and run an install script.  In this case, it can be helpful to know up front that 
there has been proprietary code running in kernel space, and aside from calls to kernel APIs, we 
have no clue what else it was doing, what memory was being trampled, what cpu registers were 
whacked, etc.

Chris
