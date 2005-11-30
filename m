Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751104AbVK3Kbw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751104AbVK3Kbw (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 05:31:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751119AbVK3Kbw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 05:31:52 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:10442 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1751104AbVK3Kbw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 05:31:52 -0500
To: Kenneth Parrish <Kenneth.Parrish@familynet-international.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [2.6 patch] i386: always use 4k stacks
References: <203b12.713227@familynet-international.net>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: Wed, 30 Nov 2005 03:31:13 -0700
In-Reply-To: <203b12.713227@familynet-international.net> (Kenneth Parrish's
 message of "17 Nov 2005 12:17:14 GMT")
Message-ID: <m14q5ufmvi.fsf@ebiederm.dsl.xmission.com>
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kenneth Parrish <Kenneth.Parrish@familynet-international.net> writes:

> -=> In article 16 Nov 05  14:40:16, Adrian Bunk wrote to All <=-
>
>  AB> If one function calls another function you have to add the stack
>  AB> usages.
>
> these few may do that, i bet.
>  0xc02bb528 huft_build:                                  1432
>  0xc02bb954 huft_build:                                  1432
>  0xc02bc1c4 inflate_dynamic:                             1312
>  0xc02bc2ff inflate_dynamic:                             1312
>  0xc02bc082 inflate_fixed:                               1168
>  0xc02bc172 inflate_fixed:                               1168

Now what is interesting is these functions currently run with a 4KiB 
stack on every bootup.  So unless they have callers with a
significant stack footprint things are fine.

Eric
