Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750744AbWCOUQO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750744AbWCOUQO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 15 Mar 2006 15:16:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750782AbWCOUQO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 15 Mar 2006 15:16:14 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36566 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1750744AbWCOUQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 15 Mar 2006 15:16:13 -0500
To: Kumar Gala <galak@kernel.crashing.org>
Cc: Arjan van de Ven <arjan@infradead.org>, vgoyal@in.ibm.com,
       linux kernel mailing list <linux-kernel@vger.kernel.org>,
       Fastboot mailing list <fastboot@lists.osdl.org>,
       Morton Andrew Morton <akpm@osdl.org>, gregkh@suse.de
Subject: Re: [RFC][PATCH] Expanding the size of "start" and "end" field in
 "struct resource"
References: <20060315193114.GA7465@in.ibm.com>
	<1142452665.3021.43.camel@laptopd505.fenrus.org>
	<C6CFDF8E-CE60-4FCD-AC17-72DC83E8521C@kernel.crashing.org>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 15 Mar 2006 13:13:56 -0700
In-Reply-To: <C6CFDF8E-CE60-4FCD-AC17-72DC83E8521C@kernel.crashing.org> (Kumar
 Gala's message of "Wed, 15 Mar 2006 14:01:13 -0600")
Message-ID: <m1ek13h3ej.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kumar Gala <galak@kernel.crashing.org> writes:

> On Mar 15, 2006, at 1:57 PM, Arjan van de Ven wrote:
>
>>
>>> One of the possible solutions to this problem is that expand the size
>>> of "start" and "end" to "unsigned long long". But whole of the PCI  and
>>> driver code has been written assuming start and end to be unsigned  long
>>> and compiler starts throwing warnings.
>>
>>
>> please use dma_addr_t then instead of unsigned long long
>>
>> this is the right size on all platforms afaik (could a ppc64 person
>> verify this?> ;)
>
> Actually we really just want "start" and "end" to be u64 on all  platforms.
> Linus was ok with this change but no one has gone through  and fixed everything
> that would be required for it.

Since it is faster to ask :)

How is it that other pieces of code have problems?
Warnings or something nasty?

Eric

