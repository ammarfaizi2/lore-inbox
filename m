Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWCSIzY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWCSIzY (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 19 Mar 2006 03:55:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751451AbWCSIzY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 19 Mar 2006 03:55:24 -0500
Received: from smtpout.mac.com ([17.250.248.83]:6869 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751448AbWCSIzX convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 19 Mar 2006 03:55:23 -0500
In-Reply-To: <441C943A.6090307@tremplin-utc.net>
References: <20060318142827.419018000@localhost.localdomain> <20060318142830.607556000@localhost.localdomain> <20060318120728.63cbad54.akpm@osdl.org> <1142712975.17279.131.camel@localhost.localdomain> <20060318123102.7d8c048a.akpm@osdl.org> <9a8748490603181245v47b9f0a5v1ef252f91c30a7d2@mail.gmail.com> <441C943A.6090307@tremplin-utc.net>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=ISO-8859-1; delsp=yes; format=flowed
Message-Id: <73D6FB08-EE04-4D7C-BD70-6C36CF5F3921@mac.com>
Cc: Jesper Juhl <jesper.juhl@gmail.com>, Andrew Morton <akpm@osdl.org>,
       tglx@linutronix.de, linux-kernel@vger.kernel.org, mingo@elte.hu,
       trini@kernel.crashing.org
Content-Transfer-Encoding: 8BIT
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch 1/2] Validate itimer timeval from userspace
Date: Sun, 19 Mar 2006 03:55:06 -0500
To: Eric Piel <Eric.Piel@tremplin-utc.net>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mar 18, 2006, at 18:14:02, Eric Piel wrote:
> 18.03.2006 21:45, Jesper Juhl wrote/a écrit:
>> If the change only affects buggy apps (as Thomas says), then it seems
>> completely obvious to me that the change should be made.
>> 1. We'll be in compliance with the spec
>> 2. Buggy applications will actually be helped by this by getting a  
>> clear error instead of undefined behaviour silently hiding the  
>> fact that they are buggy.
>> 3. Correct applications are unaffected.
> 4. Applications written for an OS which respects the spec (and  
> using this particular rule) will finally work on Linux.
>
> Well, I'd vote for just making Linux conform to the spec as soon as  
> someone notices a non-compliance. However, as this rule doesn't  
> play well with a stable ABI, a "trade-off" solution could consists in:
> - Keeping the old behavior for now and generate a printk() each  
> time this code path is entered;
> - Add an entry to feature-removal-schedule.txt saying Linux will  
> start conforming to the spec next year.

I think Eric brings up a good point.  Perhaps we should rename  
feature-removal-schedule.txt to future-abi-changes.txt and start  
including other kinds of predicted future ABI changes and  
incompatibilities.  For example the sysfs class API changes which are  
planned are not feature removals but API changes, and as such could  
be usefully mentioned and tentatively assigned a date of  
implementation.  Something like that wouldn't add a _lot_ of extra  
work, but would help developers more carefully consider the extent of  
all their ABI changes.

Cheers,
Kyle Moffett

