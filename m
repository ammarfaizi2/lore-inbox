Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262833AbVG3A2z@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262833AbVG3A2z (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Jul 2005 20:28:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262794AbVG3A0s
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Jul 2005 20:26:48 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:63372 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S262761AbVG3A0M (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Jul 2005 20:26:12 -0400
To: Sam Ravnborg <sam@ravnborg.org>
Cc: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: vmlinux.lds.S Distinguish absolute symbols
References: <m1u0id1k47.fsf@ebiederm.dsl.xmission.com>
	<20050729211954.GA8263@mars.ravnborg.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Fri, 29 Jul 2005 18:25:58 -0600
In-Reply-To: <20050729211954.GA8263@mars.ravnborg.org> (Sam Ravnborg's
 message of "Fri, 29 Jul 2005 23:19:54 +0200")
Message-ID: <m13bpxgmw9.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Sam Ravnborg <sam@ravnborg.org> writes:

> On Fri, Jul 29, 2005 at 01:35:04PM -0600, Eric W. Biederman wrote:
>> Currently in the linker script we have several labels
>> marking the beginning and ending of sections that
>> are outside of sections, making them absolute symbols.
>
> They are outside the sections for a very specific reason.
> If moved inside the section they sometimes got unexpected values due to
> the alignment that ld impose on the section itself.
>
> I recall that when Kai Germaschewski long time ago started the
> unification of the vmlinux.lds files some people had boot problems
> exactly because the label was defined inside the section and therefore
> ld caused it to have another value as if it was placed outside the
> section.

I remember seeing something like that.  I don't know if those problems
apply to a modern ld, but it is certainly worth looking into.

> I no longer recall the precise details of what happened.
> Google may help you...

Thanks.

Eric
