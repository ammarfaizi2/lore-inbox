Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932476AbWAWUzM@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932476AbWAWUzM (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 23 Jan 2006 15:55:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932477AbWAWUzL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 23 Jan 2006 15:55:11 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:8077 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S932476AbWAWUzJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 23 Jan 2006 15:55:09 -0500
To: Linus Torvalds <torvalds@osdl.org>
Cc: Benoit Boissinot <bboissin@gmail.com>,
       Harald Welte <laforge@netfilter.org>, Jiri Slaby <xslaby@fi.muni.cz>,
       Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       "David S.Miller" <davem@davemloft.net>
Subject: Re: Iptables error [Was: 2.6.16-rc1-mm2]
References: <20060120031555.7b6d65b7.akpm@osdl.org>
	<20060120162317.5F70722B383@anxur.fi.muni.cz>
	<20060120163619.GK4603@sunbeam.de.gnumonks.org>
	<40f323d00601200843m32e8f5cbv5733209ce82b8a13@mail.gmail.com>
	<Pine.LNX.4.64.0601201148220.3672@evo.osdl.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Mon, 23 Jan 2006 13:53:22 -0700
In-Reply-To: <Pine.LNX.4.64.0601201148220.3672@evo.osdl.org> (Linus
 Torvalds's message of "Fri, 20 Jan 2006 11:49:46 -0500 (EST)")
Message-ID: <m1fynell8d.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds <torvalds@osdl.org> writes:

> On Fri, 20 Jan 2006, Benoit Boissinot wrote:
>> 
>> On x86 (32bits), i have the same i think:
>
> Interestingly, __alignof__(unsigned long long) is 8 these days, even 
> though I think historically on x86 it was 4. Is this perhaps different in 
> gcc-3 and gcc-4?
>
> Or do I just remember wrong?

Nope.  There are compilers where it is 4 byte aligned.
I believe this was actually a C abi change.

I actually had some code break because of it.  A 32bit binary generated
a structure and a 64bit binary couldn't read it.  I hadn't realized
they had changed recent versions of gcc.

Eric
