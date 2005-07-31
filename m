Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261624AbVGaIp4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261624AbVGaIp4 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 31 Jul 2005 04:45:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261854AbVGaIp4
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 31 Jul 2005 04:45:56 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:41119 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S261624AbVGaIpx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 31 Jul 2005 04:45:53 -0400
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: vmlinux.lds.S Distinguish absolute symbols
References: <m1u0id1k47.fsf@ebiederm.dsl.xmission.com>
	<20050729211954.GA8263@mars.ravnborg.org>
	<m13bpxgmw9.fsf@ebiederm.dsl.xmission.com>
	<20050731082924.GA8409@mars.ravnborg.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Sun, 31 Jul 2005 02:45:27 -0600
In-Reply-To: <20050731082924.GA8409@mars.ravnborg.org> (Sam Ravnborg's
 message of "Sun, 31 Jul 2005 10:29:24 +0200")
Message-ID: <m14qab1hzs.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

>  >
>> > I recall that when Kai Germaschewski long time ago started the
>> > unification of the vmlinux.lds files some people had boot problems
>> > exactly because the label was defined inside the section and therefore
>> > ld caused it to have another value as if it was placed outside the
>> > section.
>> 
>> I remember seeing something like that.  I don't know if those problems
>> apply to a modern ld, but it is certainly worth looking into.
> I was googling a bit with no luck.
> But apperantly looking at include/asm-generic/vmlinux.lds.h
> I'm utterly wrong. It was the other way around that caused problems.

Thanks for doing the research.

> Placing the labels outside {} sometimes gave an unaligned start address,
> whereas placing the label inside {} gave the correct address.
> At his also makes sense. If ld decide to align a section then it will do
> so after a label defined outside the section.

This also gives a solid argument for why doing this will be safe
as vmlinux.lds.h already does we can't be making things worse. :)

Eric
