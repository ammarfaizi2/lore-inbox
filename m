Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965179AbWILFGt@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965179AbWILFGt (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Sep 2006 01:06:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965184AbWILFGt
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Sep 2006 01:06:49 -0400
Received: from smtpout.mac.com ([17.250.248.176]:54984 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S965179AbWILFGs (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Sep 2006 01:06:48 -0400
In-Reply-To: <Pine.LNX.4.61.0609111334460.2498@soloth.lewis.org>
References: <20060907182304.GA10686@danisch.de> <D432C2F98B6D1B4BAE47F2770FEFD6B612B8B7@to1mbxs02.replynet.prv> <Pine.LNX.4.61.0609111334460.2498@soloth.lewis.org>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <8E63F0FB-DDD3-41D4-AFA7-88E66D0E9C8D@mac.com>
Cc: Perego Paolo Franco <p.perego@reply.it>, linux-kernel@vger.kernel.org,
       Hadmut Danisch <hadmut@danisch.de>, bugtraq@securityfocus.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: R: Linux kernel source archive vulnerable
Date: Tue, 12 Sep 2006 01:06:37 -0400
To: Jon Lewis <jlewis@remove2reply.lewis.org>
X-Mailer: Apple Mail (2.752.2)
X-Brightmail-Tracker: AAAAAQAAA+k=
X-Language-Identified: TRUE
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 11, 2006, at 14:29:58, Jon Lewis wrote:
> On Fri, 8 Sep 2006, Perego Paolo Franco wrote:
>
>> Anyway just few considerations:
>> 2) a good sysadmin is aware that /usr/src is NOT supposed to be  
>> world writable
>
> For some reason (bug in how they're being checked out of git, I  
> assume), the latest kernel source tar files have all files and  
> directories world writable.  This is not how it's been in the past  
> and is not how it should be.

-ENOBUG

Please see these threads and quit bringing up this topic like crazy:
http://marc.theaimsgroup.com/?l=linux-kernel&m=113304241100330&w=2
http://marc.theaimsgroup.com/?l=linux-kernel&m=114635639325551&w=2

To quote:
> Going over old ground again, any administrator a) compiling the  
> kernel as root or b) relying on GNU tar to make  
> _security_policy_decisions_ is completely insane.
>
> The only "trick" here is tar's decision not to apply umask, or root  
> uid/gid, to files in a tar when extracted as root.  This might make  
> sense for tars that you created and want to extract again (say  
> restoring a backup), but it certainly NEVER makes sense for files  
> downloaded off the Internet.

So if you must cause a senseless hubbub on securityfocus.com, please  
don't spill it over onto LKML.  This sort of thing is at _worst_ a  
bug in GNU tar that it's behavior is different when root.  I run a  
linux system with SELinux where user 0 is no different than any other  
user and has no special permissions at all, and this kind of  
stupidity bites me a lot.  My user 0 is "kyle" when I want to chown  
files I switch to the "sysadm" role, or if I absolutely need to  
override security policy for some reason I jump through hoops to get  
to the "root" role.  In neither of those cases do I care what UID I am.

So either deal insecure permissions when you can't be bothered to use  
GNU tar securely (easy), don't compile your kernel as root (easier)  
or fix GNU tar not to assume UID 0 is God in the first place.

Cheers,
Kyle Moffett
