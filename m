Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265247AbUD3ULh@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265247AbUD3ULh (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 30 Apr 2004 16:11:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265252AbUD3ULh
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 30 Apr 2004 16:11:37 -0400
Received: from wirefire.bureaudepost.com ([66.38.187.209]:13223 "EHLO
	oasis.linuxant.com") by vger.kernel.org with ESMTP id S265247AbUD3ULc
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 30 Apr 2004 16:11:32 -0400
In-Reply-To: <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org>
References: <009701c42edf$25e47390$ca41cb3f@amer.cisco.com> <Pine.LNX.4.58.0404301212070.18014@ppc970.osdl.org>
Mime-Version: 1.0 (Apple Message framework v613)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <90DD8A88-9AE2-11D8-B83D-000A95BCAC26@linuxant.com>
Content-Transfer-Encoding: 7bit
Cc: "'Sean Estabrooks'" <seanlkml@rogers.com>,
       "'Paul Wagland'" <paul@wagland.net>, "'Rik van Riel'" <riel@redhat.com>,
       "'Bartlomiej Zolnierkiewicz'" <B.Zolnierkiewicz@elka.pw.edu.pl>,
       "'Peter Williams'" <peterw@aurema.com>, Hua Zhong <hzhong@cisco.com>,
       "'Timothy Miller'" <miller@techsource.com>,
       "'lkml - Kernel Mailing List'" <linux-kernel@vger.kernel.org>,
       koke@sindominio.net, "'Rusty Russell'" <rusty@rustcorp.com.au>,
       "'David Gibson'" <david@gibson.dropbear.id.au>
From: Marc Boucher <marc@linuxant.com>
Subject: Re: [PATCH] Blacklist binary-only modules lying about their license
Date: Fri, 30 Apr 2004 16:11:29 -0400
To: Linus Torvalds <torvalds@osdl.org>
X-Mailer: Apple Mail (2.613)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Like Hua said, this ought to be "my last email on this topic. If it 
weren't Linus I would have stopped. :-)"

On Apr 30, 2004, at 3:19 PM, Linus Torvalds wrote:
>
> On Fri, 30 Apr 2004, Hua Zhong wrote:
>>
>> I have not heard so much WINING about WINE. I even see kernel 
>> developers add
>> more support in the kernel to support WINE. Why do people like to 
>> pick on
>> closed-source drivers being run by a wrapper? I see nothing wrong 
>> with that.
>
> What is so hard to understand about the problem with bugs?
>
> All software has bugs. Binary modules just mean that those bugs are
>  - FATAL to the system, including possibly being a huge security hole.
>  - impossible to debug
>  - impossible to fix

All bugs are possibly fatal, or huge security holes, regardless of 
whether they are in binary-only code or open-source.
All bugs can be debugged or fixed, it's a matter of how hard it is to 
do (generally easier with open-source) and *who* is responsible for 
doing it (i.e. supporting the modules).

>
> In contrast, wine was _written_ to do this emulation, so by definition 
> any
> "bugs" are in wine itself (although I suspect that wine people 
> sometimes
> would prefer it if Office came with sources ;).

The same can be said about DriverLoader.

>
>> Linuxant did a wrong thing by working around the warning message, but 
>> I
>> don't think it's fair to accuse of their business because they allow 
>> binary
>> drivers run on Linux.
>
> Nobody has sued them over copyright infringement. What they are doing 
> is
> likely legal - APART from the fact that they lied about the license, 
> which
> is not only horribly immoral, it's also likely illegal under the DMCA.

The purpose of the workaround is not to circumvent any protection, but 
to fix a real usability issue for systems in the field, which, as an 
expert you perhaps do not see, but users definitely massively felt and 
complained about.

>
> Note: to me, the immoral part is the big one. If you want to flaunt the
> DMCA and take the risk of the feds coming after you as a matter of 
> civil
> disobedience, all the more power to you. Let's not be hypocritical and
> claim to like the DMCA.

I don't see our actions as being immoral at all. But in retrospect, I 
admit that the issue should have been differently handled (i.e. by 
sending patches, and perhaps starting a discussion on the lkml before 
implementing a workaround).

> But let's not kid about this: adding that '\0' thing to try to make the
> kernel believe it was GPL'd code is not ethical, and there is no way to
> claim that it's needed, since the _only_ thing it suppresses are a few
> messages saying that the kernel is tainted as a result. Which it IS.

Most kernels are already potentially "tainted" by the use of 
proprietary binary-only BIOS code, use of non-standard custom patches, 
reliance on untrusted external data, etc.. This illustrates that the 
MODULE_LICENSE tainting concept is flawed, and needlessly 
scary/confusing for users.

>
> So don't bother trying to stand up for Linuxant.

I can understand that you do not really like what we are doing to 
provide alternative options so that people can use otherwise 
unsupported hardware.

> What they did was WRONG,
> and there are no excuses for it.

But the main justification for the regrettable \0 trick remains that 
the tainted messages are redundant, confusing, and do not convey key 
information (i.e. who is responsible for supporting the third-party 
module) to ordinary users.

> And I hope that they have it fixed
> already and we can hereby just forget about this discussion.

We are working on a new release, which will be on the website shortly.

And I hope that you will agree to deal with the root problem by 
incorporating some of the suggestions (or equivalent ones) that people 
have made to fix the messages.

> 		Linus
>
>

Regards
Marc

