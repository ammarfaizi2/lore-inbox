Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262420AbTBSW6w>; Wed, 19 Feb 2003 17:58:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262446AbTBSW6w>; Wed, 19 Feb 2003 17:58:52 -0500
Received: from terminus.zytor.com ([63.209.29.3]:53186 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP
	id <S262420AbTBSW6u>; Wed, 19 Feb 2003 17:58:50 -0500
Message-ID: <2018.217.208.70.153.1045696112.squirrel@www.zytor.com>
Date: Wed, 19 Feb 2003 15:08:32 -0800 (PST)
Subject: Re: [BK PATCH] klibc for 2.5.62
From: "H. Peter Anvin" <hpa@zytor.com>
To: <greg@kroah.com>
In-Reply-To: <20030219202754.GA17593@kroah.com>
References: <20030219193907.GA17248@kroah.com>
        <20030219200935.GB1623@mars.ravnborg.org>
        <20030219202754.GA17593@kroah.com>
X-Priority: 3
Importance: Normal
X-MSMail-Priority: Normal
Cc: <torvalds@transmeta.com>, <linux-kernel@vger.kernel.org>, <hpa@zytor.com>,
       <rmk@arm.linux.org.uk>
X-Mailer: SquirrelMail (version 1.2.7)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> On Wed, Feb 19, 2003 at 09:09:35PM +0100, Sam Ravnborg wrote:
>> On Wed, Feb 19, 2003 at 11:39:07AM -0800, Greg KH wrote:
>> >  usr/lib/arch/arm/MCONFIG                        |   26
>> Any good reasons for such a screaming name?
>> makefile.config eventually.
>
> Ask Peter :)

Simply because several other projects I use have MCONFIG files, and I'm
used to the name.

>> >  usr/lib/arch/arm/Makefile.inc                   |   31
>>
>> No extension is used for arch/arm/Makefile
>> Why does klibc differ in this respect?
>> [An answer that tell me that arch/arm/Makefile should
>> change is fine with me..]
>
> Ask Russell :)

Mine, actually: I don't like naming things Makefile unless it's OK to type
"make" in that directory.

>> >  usr/lib/makeerrlist.pl                          |   80
>> >  usr/lib/socketcalls.pl                          |   75
>>
>> This mixture of code and scripts to generate code hursts my eye. What
>> about usr/scripts/.
>
> But they are the scripts used to build the code in usr/lib.  I don't
> care where they go, that's just where they were in the klibc tarball.

Quite frankly, I think this is a bogus request.  The .pl extension flags
these, but if you think about it, there really is no difference between
"code" and "scripts that generate code" -- each is a form of source code,
just compiled by different programs.

>> I assume you do not want them in scripts/
>
> Yeah, I wouldn't think they should go their either.

No, that would completely suck.

usr/lib/tools would be semi-acceptable, but quite frankly I think it
really is just complexity for complexity's sake.  I also happen to believe
that when it comes to aestetic judgements (which *all* of these objections
are!) it should be primarily a choice of the people maintaining the code,
and perhaps Linus.

    -hpa



