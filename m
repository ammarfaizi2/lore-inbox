Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261770AbVASQg2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261770AbVASQg2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 19 Jan 2005 11:36:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261771AbVASQg2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 19 Jan 2005 11:36:28 -0500
Received: from alog0265.analogic.com ([208.224.222.41]:12160 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S261770AbVASQg0
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 19 Jan 2005 11:36:26 -0500
Date: Wed, 19 Jan 2005 11:35:55 -0500 (EST)
From: linux-os <linux-os@analogic.com>
Reply-To: linux-os@analogic.com
To: Bodo Eggert <7eggert@gmx.de>
cc: Sam Ravnborg <sam@ravnborg.org>,
       Linux kernel <linux-kernel@vger.kernel.org>,
       "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: kbuild: Implicit dependence on the C compiler
In-Reply-To: <E1CrIPb-0000lS-Oz@be1.7eggert.dyndns.org>
Message-ID: <Pine.LNX.4.61.0501191128090.10869@chaos.analogic.com>
References: <fa.e2phu9o.1c30pig@ifi.uio.no> <fa.gakt9b5.1klcr9h@ifi.uio.no>
 <E1CrIPb-0000lS-Oz@be1.7eggert.dyndns.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII; format=flowed
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2005, Bodo Eggert wrote:

> Sam Ravnborg <sam@ravnborg.org> wrote:
>
>> 1) Unconditionally execute make install assuming vmlinux is up-to-date.
>>    make modules_install run unconditionally, so this is already know
>>    practice
>
> (o) Vote for this.
>
> IMO, a make install should NEVER run the compiler.
>
> The reason is: I'm deliberaely compiling as a user on the fastest system
> before I copy or mount the FS to/on some other box and do a make install.
> The other box will be _very_ slow while compiling or missing some of the
> needed components (e.g. gcc).
>

You must never execute `make install` or `make modules_install` without
the explicit action of the operator! To do so could (will) result
in an un-bootable system. I can't imagine what somebody would be
thinking to propose an automatic install. Whoever proposed this
must have lots of time and little knowledge. They are going to
be reinstalling everything from the distribution CD as a hobby.

Cheers,
Dick Johnson
Penguin : Linux version 2.6.10 on an i686 machine (5537.79 BogoMips).
  Notice : All mail here is now cached for review by Dictator Bush.
                  98.36% of all statistics are fiction.
