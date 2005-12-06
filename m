Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932550AbVLFNXj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932550AbVLFNXj (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 08:23:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932556AbVLFNXj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 08:23:39 -0500
Received: from zproxy.gmail.com ([64.233.162.197]:63570 "EHLO zproxy.gmail.com")
	by vger.kernel.org with ESMTP id S932550AbVLFNXh convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 08:23:37 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=KdFfaqk43H5qygT8CPU0qMzT+AJHAaLNUimK9IOLtFvAlvDA/NnCLSB6V5NbWp/Gl71bm6BvVKtaLiyS/BhDOdi56qHYvWNPT9SC5qz5jz94eBuxZriTBqfaguIY8iBySFgkQnnognRyWAnmTBwf3fYcW/UnxQBJ4Hni2dvNTJI=
Message-ID: <3aa654a40512060523w15610989l13950153f4f54c18@mail.gmail.com>
Date: Tue, 6 Dec 2005 05:23:35 -0800
From: Avuton Olrich <avuton@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: Kernel panic: Machine check exception
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, lkml <linux-kernel@vger.kernel.org>
In-Reply-To: <m1wtiicwbv.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <3aa654a40511190145v6f4df755wf16673050d077edb@mail.gmail.com>
	 <1132406652.5238.19.camel@localhost.localdomain>
	 <3aa654a40511191254x4bf50cc8l6a9b8786f1a5ebc8@mail.gmail.com>
	 <1132436886.19692.17.camel@localhost.localdomain>
	 <m1wtiicwbv.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/6/05, Eric W. Biederman <ebiederm@xmission.com> wrote:
> Although on the Opteron that is usually what it is (as memory
> errors can be reported through the machine check interface)
>
> In this case bank 4 is the appropriate bank.  Although the
> other bits don't look right for a memory error.  I wonder
> if it is that darn iommu fault again.
>
> To decode an Opteron machine_check you can look in
> the bios and kernel programmers guide.  (Possibly the
> architecture but I think that is too generic) to see
> what all of the bits mean.
>
> It is a pain but is faster than poking blindly in
> the dark.
>
> Eric

Wow, I'm glad you send a reply. I've been looking into RMA'ing this
board and that would mean 3-4 weeks without a mobo, and I'd especially
hate to think it's actually not a hardware problem after waiting that
long. Something I did notice you said was about the IOMMU, which I
guess i should have mentioned in the first place errors out in the
beginning of the dmesg.

I get this same dmesg message in all kernels I have tried so far
(vanilla and -mm) 2.6.13+

Maybe I should compile it out for now? Unfortunately this lockup isn't
predictable, so I'm forced to just tool around until things lockup
(usually happens between 15 minutes and 12 hours :))

Also, I am merely a layperson. I just took a quick look over
http://www.amd.com/us-en/assets/content_type/white_papers_and_tech_docs/26094.PDF
and it's unreadable by myself.

PCI-DMA: Disabling IOMMU.
    ACPI-0412: *** Error: Handler for [SystemMemory] returned AE_AML_ALIGNMENT
    ACPI-0508: *** Error: Method execution failed [\_SB_.MEM_._CRS]
(Node ffff81003ffb6f80), AE_AML_ALIGNMENT
    ACPI-0156: *** Error: Method execution failed [\_SB_.MEM_._CRS]
(Node ffff81003ffb6f80), AE_AML_ALIGNMENT
PCI: Bridge: 0000:00:04.0
  IO window: disabled.
  MEM window: f0000000-f7ffffff
  PREFETCH window: e0000000-efffffff
PCI: Bridge: 0000:00:10.0
  IO window: c000-cfff
  MEM window: disabled.
  PREFETCH window: disabled.


--
  Anyone who quotes me in their sig is an idiot. -- Rusty Russell.
