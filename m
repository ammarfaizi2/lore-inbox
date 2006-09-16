Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964806AbWIPQHV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964806AbWIPQHV (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 16 Sep 2006 12:07:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964814AbWIPQHU
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 16 Sep 2006 12:07:20 -0400
Received: from srv5.dvmed.net ([207.36.208.214]:57513 "EHLO mail.dvmed.net")
	by vger.kernel.org with ESMTP id S964806AbWIPQHT (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 16 Sep 2006 12:07:19 -0400
Message-ID: <450C2134.7040200@garzik.org>
Date: Sat, 16 Sep 2006 12:07:16 -0400
From: Jeff Garzik <jeff@garzik.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060808)
MIME-Version: 1.0
To: Willy Tarreau <w@1wt.eu>
CC: Tejun Heo <htejun@gmail.com>, Tom Mortensen <tmmlkml@gmail.com>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.4.x libata resync
References: <a52a95e30609152214uc7a2114qfe681781a50db24e@mail.gmail.com> <20060916053713.GJ541@1wt.eu> <450B9940.5030609@gmail.com> <20060916063808.GK541@1wt.eu> <450C1CF2.4080308@garzik.org> <20060916155141.GA18409@1wt.eu>
In-Reply-To: <20060916155141.GA18409@1wt.eu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Score: -4.3 (----)
X-Spam-Report: SpamAssassin version 3.1.3 on srv5.dvmed.net summary:
	Content analysis details:   (-4.3 points, 5.0 required)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Willy Tarreau wrote:
> On Sat, Sep 16, 2006 at 11:49:06AM -0400, Jeff Garzik wrote:
>> Willy Tarreau wrote:
>>> There are a bunch of small patches in the early 2.6 version which look
>>> like bugfixes, but with non-descriptive comments, so I'm not sure what
>>> they fix. Several of them would apply to 2.4, but I don't want to touch
>>> this area as long as nobody complains about problems.
>> Oh there are tons of SATA bug fixes that 2.4.x is missing.  One of the 
>> biggest is the completely crappy exception handling.  If a SATA device 
>> is unplugged or spazzes out, the system may or may not recover.
> 
> Already encountered on sata_nv in a sun x2100 :-)
> 
> Jeff, I did not want to blindly merge patches from 2.6 to 2.4, but if
> you point me to a few ones you consider important, I'm willing to merge
> them.

As was hinted, it's not that easy, otherwise someone would have done it 
by now.  libata bug fixes require infrastructure that isn't present on 
2.4.  The overall codebase is just too different to easily pull out 
select bug fixes.

	Jeff



