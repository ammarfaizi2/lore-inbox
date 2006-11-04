Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751046AbWKDCKZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751046AbWKDCKZ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 3 Nov 2006 21:10:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750912AbWKDCKZ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 3 Nov 2006 21:10:25 -0500
Received: from smtpout.mac.com ([17.250.248.175]:7377 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1750715AbWKDCKX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 3 Nov 2006 21:10:23 -0500
In-Reply-To: <20061103204706.GA31398@sergelap.austin.ibm.com>
References: <20061103175730.87f55ff8.chris@friedhoff.org> <20061103200011.GA2206@sergelap.austin.ibm.com> <1162585797.5519.175.camel@moss-spartans.epoch.ncsc.mil> <20061103204706.GA31398@sergelap.austin.ibm.com>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <04A6CE5F-C68B-4F1A-B3CB-F3BB77D9EA9A@mac.com>
Cc: Stephen Smalley <sds@tycho.nsa.gov>,
       20060906182719.GB24670@sergelap.austin.ibm.com,
       linux-security-module@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [PATCH 1/1] security: introduce fs caps
Date: Fri, 3 Nov 2006 21:08:55 -0500
To: "Serge E. Hallyn" <serue@us.ibm.com>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAA==
X-Brightmail-scanned: yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 03, 2006, at 15:47:06, Serge E. Hallyn wrote:
>  Quoting Stephen Smalley (sds@tycho.nsa.gov):
>> On Fri, 2006-11-03 at 14:00 -0600, Serge E. Hallyn wrote:
>>> One question is, if this were to be tested in -mm, do we want to  
>>> keep
>>> this mutually exclusive from selinux through config, or should  
>>> selinux
>>> stack on top of this?
>>
>> Given that SELinux already stacks with capability and you aren't  
>> using
>> the security fields (last I looked), it would seem trivial to enable
>> stacking with fscaps (just add a few secondary_ops calls to the  
>> SELinux
>> hooks, right?).
>
> Yup, I just wasn't sure if there would be actual objections to the  
> idea of enabling both at once.
>
> I'll send out a patch - just as soon as I figure out where I left  
> the src to begin with :)

To be honest from my understanding of SELinux there is no need at all  
to use FS caps on an SELinux system.  Anything that could be done  
with FS caps would be done in a much more fine-grained method with  
SELinux, and the inheritance of filesystem-based capabilities should  
be masked by SELinux-allowed capabilities anyways.  I guess it _can_  
be done, but why?  It's possible to set up an SELinux system so that  
there aren't even any SUID binaries, right?  /etc/passwd can run as  
whatever random user and it will automatically transition to the  
appropriate domain such that it can read and modify /etc/shadow.

Cheers,
Kyle Moffett

