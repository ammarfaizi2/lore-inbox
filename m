Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261868AbSLPWhN>; Mon, 16 Dec 2002 17:37:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261874AbSLPWhN>; Mon, 16 Dec 2002 17:37:13 -0500
Received: from smtp09.iddeo.es ([62.81.186.19]:24502 "EHLO smtp09.retemail.es")
	by vger.kernel.org with ESMTP id <S261868AbSLPWhM>;
	Mon, 16 Dec 2002 17:37:12 -0500
Date: Mon, 16 Dec 2002 23:44:42 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Keith Owens <kaos@ocs.com.au>
Cc: Sam Ravnborg <sam@ravnborg.org>, linux-kernel@vger.kernel.org
Subject: Re: How to do -nostdinc?
Message-ID: <20021216224442.GC2994@werewolf.able.es>
References: <20218.1040073993@ocs3.intra.ocs.com.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20218.1040073993@ocs3.intra.ocs.com.au>; from kaos@ocs.com.au on Mon, Dec 16, 2002 at 22:26:33 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.12.16 Keith Owens wrote:
>On Mon, 16 Dec 2002 19:29:19 +0100, 
>Sam Ravnborg <sam@ravnborg.org> wrote:
>>On Sun, Dec 15, 2002 at 11:06:41PM +1100, Keith Owens wrote:
>>> There are two ways of setting the -nostdinc flag in the kernel Makefile :-
>>> 
>>> (1) -nostdinc $(shell $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
>>> (2) -nostdinc -iwithprefix include
>>> 
>>> The first format breaks with non-English locales, however the fix is trivial.
>>> 
>>> (1a) -nostdinc $(shell LANG=C $(CC) -print-search-dirs | sed -ne 's/install: \(.*\)/-I \1include/gp')
>>> 
>>Hi Keith.
>>
>>Based on the comments received, solution (2) seems to be OK.
>>Do you agree?
>
>Does gcc still mark -iwithprefix as deprecated?  If it does then do not
>rely on it and use (1a).  If gcc will support -iwithprefix then use (2).
>

gcc-3.2, info:

`-iwithprefix DIR'
`-iwithprefixbefore DIR'
     Append DIR to the prefix specified previously with `-iprefix', and
     add the resulting directory to the include search path.
     `-iwithprefixbefore' puts it in the same place `-I' would;
     `-iwithprefix' puts it where `-idirafter' would.

     Use of these options is discouraged.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-jam1 (gcc 3.2 (Mandrake Linux 9.1 3.2-4mdk))
