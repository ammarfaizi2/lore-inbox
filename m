Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965003AbWEYEiH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965003AbWEYEiH (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 00:38:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965014AbWEYEiH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 00:38:07 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:7576 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S965003AbWEYEiG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 00:38:06 -0400
To: Magnus Damm <magnus@valinux.co.jp>
Cc: fastboot@lists.osdl.org, linux-kernel@vger.kernel.org,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [Fastboot] [PATCH 01/03] kexec: Avoid overwriting the current
 pgd (V2, stubs)
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	<20060524044237.14219.15615.sendpatchset@cherry.local>
	<m1wtcasu5b.fsf@ebiederm.dsl.xmission.com>
	<1148528742.5793.135.camel@localhost>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 24 May 2006 22:37:03 -0600
In-Reply-To: <1148528742.5793.135.camel@localhost> (Magnus Damm's message of
 "Thu, 25 May 2006 12:45:42 +0900")
Message-ID: <m1bqtmsosw.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Magnus Damm <magnus@valinux.co.jp> writes:

> On Wed, 2006-05-24 at 20:41 -0600, Eric W. Biederman wrote:
>> Magnus Damm <magnus@valinux.co.jp> writes:
>> 
>> > --===============059810052910035161==
>> >
>> > kexec: Avoid overwriting the current pgd (V2, stubs)
>> >
>> > This patch adds an architecture specific structure "struct kimage_arch" to 
>> > struct kimage. This structure is filled in with members by the architecture
>> > specific patches followed by this one.
>> 
>> You should be able to completely remove the need for this by simply
>> adding a single additional external variable to the control code
>> page.  Given that you abuse this information and store way more
>> than you need I am not persuaded that it is an interesting case.
>
> I'm sorry, but I do not understand. Care to explain a bit more, maybe
> with some examples?

I believe I gave a complete explanation the first round.

By having an extra extern variable you can export the offset of
a variable on the control code page, or what you need to compute
the offset.

> Also, I get the impression that you dislike my patches. I'd like to work
> with you and the community to merge my patches, but for that to happen
> I'd appreciate if we both kept the language on a professional level.

Yes. I dislike your patches, but I don't dislike what you are trying to do.

Part of the reason is you do more than one thing at a time, which makes
review much more difficult than it needs to be.

> Next time, please try to avoid strong words such as "abuse", "horrible"
> and "ridiculous".

I call them as I see them, and probably if I am a little frustrated I
may be a little more extreme.  Usually I find that I have too much
implied content and don't explain why I consider something abuse
for example.

In the above quoted section I figure it is abuse to place what only needs
to be an array of local variables in a global structure.

Eric
