Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262006AbSKDRRX>; Mon, 4 Nov 2002 12:17:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262181AbSKDRRW>; Mon, 4 Nov 2002 12:17:22 -0500
Received: from mailout09.sul.t-online.com ([194.25.134.84]:16267 "EHLO
	mailout09.sul.t-online.com") by vger.kernel.org with ESMTP
	id <S262006AbSKDRRV>; Mon, 4 Nov 2002 12:17:21 -0500
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       <wirges@purdue.edu>
References: <Pine.LNX.4.44.0211041138060.16432-100000@ibm-ps850.purdueriots.com>
From: Olaf Dietsche <olaf.dietsche#list.linux-kernel@t-online.de>
To: Patrick Finnegan <pat@purdueriots.com>
Subject: Re: Filesystem Capabilities in 2.6?
Date: Mon, 04 Nov 2002 18:23:28 +0100
In-Reply-To: <Pine.LNX.4.44.0211041138060.16432-100000@ibm-ps850.purdueriots.com> (Patrick
 Finnegan's message of "Mon, 4 Nov 2002 11:53:56 -0500 (EST)")
Message-ID: <87ela1fdv3.fsf@goat.bogus.local>
User-Agent: Gnus/5.090005 (Oort Gnus v0.05) XEmacs/21.4 (Honest Recruiter,
 i386-debian-linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Patrick Finnegan <pat@purdueriots.com> writes:

> On Mon, 4 Nov 2002, Olaf Dietsche wrote:
>
>> Take a look at <http://atrey.karlin.mff.cuni.cz/~pavel/elfcap.html>.
>> Maybe this is what you had in mind?
>
> Similar, but not exactly the same:
>
> 1) Capabilities should be enabled explicitly not dropped explicitly -
>    it's a 'more secure' way to do it.
>
> 2) Capabilities shouldn't be preserved across an execve except for once,

For this you need to clear the permitted and inheritable set.

>    as needed by wrapper scripts/binaries. This way even if someone figures
>    out how to exploit the code to do an exec, they're left with no caps at
>    all.  If desired, a new binfmt "cap_wrap" could be created that can be
>    used as a capabilities wrapper for executables, which the kernel looks
>    at to determine 1) what caps to use and 2) what binary to run.  The
>    wrapper will need to be suid root in order to gain caps still.

Here you will find capabilities with a new binfmt type:
<http://groups.google.com/groups?selm=linux.kernel.20020317121118.A18548%40glacier.arctrix.com>

Elfcap and capwrap both allow to have capabilities.

Regards, Olaf.
