Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264062AbTEGPn5 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 11:43:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264057AbTEGPn5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 11:43:57 -0400
Received: from mail.convergence.de ([212.84.236.4]:62355 "EHLO
	mail.convergence.de") by vger.kernel.org with ESMTP id S264062AbTEGPnz
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 11:43:55 -0400
Message-ID: <3EB92CAD.2040502@convergence.de>
Date: Wed, 07 May 2003 17:56:29 +0200
From: Michael Hunold <hunold@convergence.de>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de-AT; rv:1.3) Gecko/20030408
X-Accept-Language: de-at, de, en-us, en
MIME-Version: 1.0
To: Christoph Hellwig <hch@infradead.org>
CC: linux-kernel@vger.kernel.org, torvalds@transmeta.com
Subject: Re: [PATCH[[2.5][3-11] update dvb subsystem core
References: <3EB7DCF0.2070207@convergence.de> <20030506220828.A19971@infradead.org> <3EB8C67A.4020500@convergence.de> <20030507102256.B14040@infradead.org>
In-Reply-To: <20030507102256.B14040@infradead.org>
X-Enigmail-Version: 0.73.1.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Christoph,

> That okay in principle, but I'd like to ask you nicely to not touch any
> devfs-related stuff currently.  I'ts in flux and any external change
> makes my life in cleaning up the mess a lot harder.

The problem was that the devices disappeared. I did not realize that you 
did a typo and they were created at another place, though.

So I rewrote the code for both 2.4 and 2.5 and it worked again.

>>I understand. But delaying the dvb updates just because a few calls to 
>>the devfs subsystem (which are now separated by #ifdefs and can easily 
>>be found) is not a good option either, or is it?

> I think it is :)  Esepcially as you don't just add ifdefs (which give
> me lots of rejects and you much uglier code than just using the
> compat header I'll send to lkml once I'm done with the API changes) but
> you also change the code that's ifdefed for 2.5 to reverse change I
> did.  There is a reason why I removed every occurance of devfs_handle_t
> from all drivers and the particular reason is that it will go away in
> the next series of patches.

Ok, I understand.

I promise that I don't touch the devfs related code anymore. But, how do 
we proceed in general?

Will the other patches be applied and who does that for which tree?
Shall I resend the patches where you had objections?

CU
Michael.

