Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751253AbWEZB5Q@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751253AbWEZB5Q (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 25 May 2006 21:57:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751280AbWEZB5P
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 25 May 2006 21:57:15 -0400
Received: from wr-out-0506.google.com ([64.233.184.235]:2782 "EHLO
	wr-out-0506.google.com") by vger.kernel.org with ESMTP
	id S1751253AbWEZB5P convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 25 May 2006 21:57:15 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=ufoj05iP3HK2m4Vzu1mSEDqxPwwPXdlfddYztw2n1JNsqJPY8QjwP/qW0jzI5vsYXMcyOOOe8+g4Ckm7gr43PHC05KsU1yR1IfXLzvwVG5PmGa7zRjlzsofgIz9uVSXS3sh66Ee2H38r+SDPaCDe8yYTRnE52OnLc3UP3/dUg4k=
Message-ID: <aec7e5c30605251857l616ed588q44955b658ad0f62f@mail.gmail.com>
Date: Fri, 26 May 2006 10:57:14 +0900
From: "Magnus Damm" <magnus.damm@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [Fastboot] [PATCH 00/03] kexec: Avoid overwriting the current pgd (V2)
Cc: "Magnus Damm" <magnus@valinux.co.jp>, fastboot@lists.osdl.org,
       linux-kernel@vger.kernel.org
In-Reply-To: <m1psi2dpm7.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
	format=flowed
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <20060524044232.14219.68240.sendpatchset@cherry.local>
	 <20060524225631.GA23291@in.ibm.com>
	 <1148522948.5793.98.camel@localhost>
	 <m1k68astge.fsf@ebiederm.dsl.xmission.com>
	 <1148527837.5793.121.camel@localhost>
	 <m17j4aso43.fsf@ebiederm.dsl.xmission.com>
	 <aec7e5c30605250029jfab09e4y26556abf8f16628d@mail.gmail.com>
	 <m1psi2dpm7.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Magnus Damm" <magnus.damm@gmail.com> writes:
> >
> > Also, I feel that my approach with a valid idt and gdt is more robust.
>
> One of my biggest concerns with the current code is that it is not
> sufficiently robust, in the kdump case.  So I am all in favor things
> that improve that situation.  At the same time just moving code from C
> to assembly doesn't make it more robust, especially when the comments
> explaining what the code does don't come along.

I agree that just moving the code does not help. But my code actually
loads a new set of gdts and idts and I'm hoping that it will improve
the robustness.

Regarding more comments I totally agree with you.

> >> The big problem was you did several things with a single patch,
> >> and that made the review much more difficult than it had to be.
> >>
> >> Having to check if you correctly modified the page tables, while also
> >> having to check for segmentation, and the interrupt descriptor
> >> transformations was distracting.
> >
> > Let me know which parts you think are good and we will implement and
> > review them bit by bit instead then.
>
> Skip the infrastructure changes, and the rest looks like real
> possibilities.

But I need to store my page tables somewhere, and there is no good
place to store them now. With good reasoning I can be convinced that
storing things on the control page is a good thing, and I'd like to
agree on something, but without good reasoning I will continue to
think that the control page solution is overly complex.

Thanks,

/ magnus
