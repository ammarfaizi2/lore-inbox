Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932221AbWHGRA6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932221AbWHGRA6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 7 Aug 2006 13:00:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932226AbWHGRA6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 7 Aug 2006 13:00:58 -0400
Received: from terminus.zytor.com ([192.83.249.54]:62861 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S932221AbWHGRA5
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 7 Aug 2006 13:00:57 -0400
Message-ID: <44D771A7.7040605@zytor.com>
Date: Mon, 07 Aug 2006 10:00:23 -0700
From: "H. Peter Anvin" <hpa@zytor.com>
User-Agent: Thunderbird 1.5.0.4 (X11/20060614)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: "Randy.Dunlap" <rdunlap@xenotime.net>, Andrew Morton <akpm@osdl.org>,
       Andi Kleen <ak@suse.de>,
       "Protasevich, Natalie" <Natalie.Protasevich@UNISYS.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] x86_64: Make NR_IRQS configurable in Kconfig
References: <m1irl4ftya.fsf@ebiederm.dsl.xmission.com>	<20060807085924.72f832af.rdunlap@xenotime.net> <m1irl4ebsf.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1irl4ebsf.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> 
> a) Because I would like to flush out bugs.
> b) Because I want a default that works for everyone.
> c) Because with MSI we have a potential for large irq counts on most systems.
> d) Because anyone who disagrees with me can send a patch and fix
>    the default.
> e) Because with the default number of cpus we can very close to needing
>    this many irqs in the worst case.
> f) This is much better than previous to my patch and setting NR_CPUS=255
>    and getting 8K IRQS.
> g) Because I probably should have been more inventive than copying the
>    NR_IRQS text, but when I did the wording sounded ok to me.
> 

Why not simply reserve 224*NR_CPUS IRQs? If you have 256 CPUs allocating 
64K IRQs should hardly matter :)

	-hpa
