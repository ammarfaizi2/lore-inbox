Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750788AbWF2PGK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750788AbWF2PGK (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 11:06:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWF2PGK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 11:06:10 -0400
Received: from mail.tmr.com ([64.65.253.246]:26562 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1750784AbWF2PFr (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 11:05:47 -0400
Message-ID: <44A3E5F6.6020607@tmr.com>
Date: Thu, 29 Jun 2006 10:38:46 -0400
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.4) Gecko/20060516 SeaMonkey/1.0.2
MIME-Version: 1.0
To: Junio C Hamano <junkio@cox.net>
CC: linux-kernel@vger.kernel.org, "Joshua Hudson" <joshudson@gmail.com>
Subject: Re: Kernelsources writeable for everyone?!
References: <200606242000.51024.damage@rooties.de>	<20060624181702.GG27946@ftp.linux.org.uk>	<1151198452.6508.10.camel@mjollnir> <449E216E.8010508@sbcglobal.net>	<bda6d13a0606251309x3e07e9feoad777d9a062f923f@mail.gmail.com> <7v4py4wkwk.fsf@assigned-by-dhcp.cox.net>
In-Reply-To: <7v4py4wkwk.fsf@assigned-by-dhcp.cox.net>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Junio C Hamano wrote:
> "Joshua Hudson" <joshudson@gmail.com> writes:
> 
>> I feel like asking how they initially get set to world-writable. To me
>> it means that the tree that is being tarred up for distribution is
>> world-writible. I sure hope that it is a single-user box.
> 
> It is _not_ coming from a working tree at all.
> 
> git-tar-tree generates the tar image from a git tree object, and
> when it does so, it deliberately sets the mode bits to 0666/0777
> so that umask of the people who extract the tarball is honored.
> In very early days once we made a mistake of generating the tar
> archive with more restrictive permission bits (I think it was
> 0644 or 0755) which was very impolite way to annoy people with
> 002 umask.
> 
I have my unpack/build directory set to a group ownership which prevents 
"just anyone" from writing, and have the "setgid" bit on (mode 2775) 
which interestingly propagates. So everything has the same group, and 
you can set your umask to do what you want. I want everything world 
readable, writable by group. YMMV.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.


