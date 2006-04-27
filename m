Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965114AbWD0MeJ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965114AbWD0MeJ (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 27 Apr 2006 08:34:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965115AbWD0MeI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 27 Apr 2006 08:34:08 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:18057 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965114AbWD0MeH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 27 Apr 2006 08:34:07 -0400
To: Sam Vilain <sam@vilain.net>
Cc: "Serge E. Hallyn" <serue@us.ibm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC][PATCH 4/5] utsname namespaces: sysctl hack
References: <20060407095132.455784000@sergelap>
	<20060407183600.E40C119B902@sergelap.hallyn.com>
	<4446547B.4080206@sw.ru> <m1wtdlmvmr.fsf@ebiederm.dsl.xmission.com>
	<20060419175123.GD1238@sergelap.austin.ibm.com>
	<m1ejztjua2.fsf@ebiederm.dsl.xmission.com>
	<4446AF56.9060706@vilain.net>
	<20060425220022.GD7228@sergelap.austin.ibm.com>
	<444EF25D.9070702@vilain.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Thu, 27 Apr 2006 06:32:23 -0600
In-Reply-To: <444EF25D.9070702@vilain.net> (Sam Vilain's message of "Wed, 26
 Apr 2006 16:09:01 +1200")
Message-ID: <m1ejzjdwrs.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Vilain <sam@vilain.net> writes:

> Serge E. Hallyn wrote:
>
>>>>Can we please suggest a syscall interface?
>>>>      
>>>>
>>
>>Eric,
>>
>>Did you have any ideas for how you'd want to interface to look?  Are
>>you fine with the vserver approach?

My preference is for a clone/unshare flag.

My second preference would be a new syscall that simply
creates the interface.

The important point is that we have something that works
and solves the subset of the problem we are working on.

> Eric has said that his understanding was that syscall switches (ie,
> syscalls with subcommands) were bad form.
>
> I understand the concern, but I think while it's still in prototype
> stages, that it's a sensible and pragmatic approach. Once individual
> subcommands are "finalised" then they can be split out into a seperate
> syscall, and any level of backwards compatibility can be maintained by
> whoever needs it.

This is a key point.  We are not in prototype stage.
Linux-Vserver, OpenVZ and other less polished implementations
work have already provided that.

Where we are now is implementing well understood subsets of the
problem in a way that everyone can use.

So all that really matters is an interface that is good enough
for the current subset.

Since each subset of the problem can stand on it's own we
can give it a very thorough technical review.

Eric
