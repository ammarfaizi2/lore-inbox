Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261225AbULECJz@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261225AbULECJz (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Dec 2004 21:09:55 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbULECJz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Dec 2004 21:09:55 -0500
Received: from smtpout03-04.mesa1.secureserver.net ([64.202.165.74]:38787 "HELO
	smtpout03-04.mesa1.secureserver.net") by vger.kernel.org with SMTP
	id S261225AbULECJy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Dec 2004 21:09:54 -0500
Message-ID: <41B26DFB.6060003@starnetworks.us>
Date: Sat, 04 Dec 2004 19:10:03 -0700
From: "Kevin P. Fleming" <kpfleming@starnetworks.us>
Organization: Star Networks, LLC
User-Agent: Mozilla Thunderbird 0.9 (Windows/20041103)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Paul Mackerras <paulus@samba.org>
CC: Robert Love <rml@novell.com>, Linus Torvalds <torvalds@osdl.org>,
       David Woodhouse <dwmw2@infradead.org>,
       David Howells <dhowells@redhat.com>, linux-kernel@vger.kernel.org,
       libc-alpha@sources.redhat.com
Subject: Re: Proposal for a userspace "architecture portability" library
References: <16818.23575.549824.733470@cargo.ozlabs.ibm.com>	<1102208924.6052.94.camel@localhost> <16818.26777.209451.685576@cargo.ozlabs.ibm.com>
In-Reply-To: <16818.26777.209451.685576@cargo.ozlabs.ibm.com>
X-Enigmail-Version: 0.89.0.0
X-Enigmail-Supports: pgp-inline, pgp-mime
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Paul Mackerras wrote:

> No, for semaphores and rwsems I was going to use futexes.  Or maybe we
> don't need the kernel's semaphores, rwsems and spinlocks in userspace
> at all.  I'm open to suggestions.

I think that _all_ of these items can find use in userspace, if they are 
usable with glibc's threading implementation and the other userspace 
issues that would be involved.

I for one would love to be able to use lightweight rwsems and spinlocks 
in an application I'm working on, but it's entirely userspace and it 
would be impossible for _me_ to pick out this code from the kernel tree 
and make it work on any architecture that I don't have here (which is 
all of them except x86 <G>).
