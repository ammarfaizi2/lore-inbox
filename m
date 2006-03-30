Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751448AbWC3CYz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbWC3CYz (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 29 Mar 2006 21:24:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751450AbWC3CYz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 29 Mar 2006 21:24:55 -0500
Received: from watts.utsl.gen.nz ([202.78.240.73]:3983 "EHLO watts.utsl.gen.nz")
	by vger.kernel.org with ESMTP id S1751448AbWC3CYz (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 29 Mar 2006 21:24:55 -0500
Message-ID: <442B4168.6070806@vilain.net>
Date: Thu, 30 Mar 2006 14:24:40 +1200
From: Sam Vilain <sam@vilain.net>
User-Agent: Mozilla Thunderbird 1.0.7 (X11/20051013)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
Cc: Chris Wright <chrisw@sous-sol.org>, Nick Piggin <nickpiggin@yahoo.com.au>,
       Herbert Poetzl <herbert@13thfloor.at>, Bill Davidsen <davidsen@tmr.com>,
       Linux Kernel ML <linux-kernel@vger.kernel.org>,
       "Serge E. Hallyn" <serue@us.ibm.com>
Subject: Re: [RFC] Virtualization steps
References: <1143228339.19152.91.camel@localhost.localdomain>	<4428BB5C.3060803@tmr.com> <20060328085206.GA14089@MAIL.13thfloor.at>	<4428FB29.8020402@yahoo.com.au>	<20060328142639.GE14576@MAIL.13thfloor.at>	<44294BE4.2030409@yahoo.com.au>	<m1psk5kcpj.fsf@ebiederm.dsl.xmission.com> <442A26E9.20608@vilain.net>	<20060329182027.GB14724@sorel.sous-sol.org>	<442B0BFE.9080709@vilain.net>	<20060329225241.GO15997@sorel.sous-sol.org> <m1psk4g2xa.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1psk4g2xa.fsf@ebiederm.dsl.xmission.com>
X-Enigmail-Version: 0.92.1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:

>I think what we really want are stacked security modules.
>
>I have not yet fully digested all of the requirements for multiple servers
>on the same machine but increasingly the security aspects look
>like a job for a security module.
>
>Enforcing policies like container A cannot send signals to processes
>in container B or something like that.
>  
>

We could even end up making security modules to implement standard unix
security. ie, which processes can send any signal to other processes.
Why hardcode the (!sender.user_id || (sender.user_id == target.user_id)
) rule at all? That rule should be the default rule in a security module
chain.

I just think that doing it this way is the wrong way around, but I guess
I'm hardly qualified to speak on this. Aren't security modules supposed
to be for custom security policy, not standard system semantics ?

Sam.
