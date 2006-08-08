Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1030300AbWHHV0S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030300AbWHHV0S (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 8 Aug 2006 17:26:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030304AbWHHV0S
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 8 Aug 2006 17:26:18 -0400
Received: from nf-out-0910.google.com ([64.233.182.188]:32875 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S1030300AbWHHV0R (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 8 Aug 2006 17:26:17 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=LuX2MqbG/KYfKYZp/4hEV5QcYWvl8pTvpi+BceHVM0Hp4/jXVtEUdD0tSdWzP33jO4ua0GUjQ/FFXyiEO2ZQqJ9xCoq/VX9JecI4xLZopJzbbFfJk+4hev2DGUfdFwXUbUAGP5OqjKJEHTq1sg5Tzm3F1xV3iViKWcSEW11IJU8=
Message-ID: <a762e240608081426k58122a55pc4fe60150c01ed61@mail.gmail.com>
Date: Tue, 8 Aug 2006 14:26:15 -0700
From: "Keith Mannthey" <kmannth@gmail.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH] x86_64: Double the per cpu area size
Cc: "Andi Kleen" <ak@suse.de>, "Andrew Morton" <akpm@osdl.org>,
       "Protasevich, Natalie" <Natalie.Protasevich@unisys.com>,
       linux-kernel@vger.kernel.org
In-Reply-To: <m1u04n5405.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <m1mzagfu03.fsf@ebiederm.dsl.xmission.com>
	 <200608071730.47120.ak@suse.de>
	 <m1vep4ecd8.fsf@ebiederm.dsl.xmission.com>
	 <a762e240608081343r3816b906o7985bde9fbd9b463@mail.gmail.com>
	 <m1u04n5405.fsf@ebiederm.dsl.xmission.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/8/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> "Keith Mannthey" <kmannth@gmail.com> writes:
>
> > On 8/7/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> >> Andi Kleen <ak@suse.de> writes:
> >>
> >> >>
> >> >>  #include <asm/pda.h>
> >> >>
> >> >> +#define PERCPU_ENOUGH_ROOM 65536
> >
> > Is it possible to put this into -mm untill things are sorted?
> > 2.6.18-rc3-mm2 x86_64 is still without any per-cpu space for modules.
>
> I think we are sorted (see the later patch to auto size the per cpu
> area).  But you should be ok with current -mm if you compile for 64 or
> fewer cpus.

Yep it looks like the config file I tote around on this box has
CONFIG_NR_CPUS=128. I thought this this was the default NR_CPUS but it
is not.

Thanks,
  Keith
