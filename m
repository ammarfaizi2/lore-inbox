Return-Path: <linux-kernel-owner+w=401wt.eu-S932651AbWLMKJK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932651AbWLMKJK (ORCPT <rfc822;w@1wt.eu>);
	Wed, 13 Dec 2006 05:09:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932649AbWLMKJK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Dec 2006 05:09:10 -0500
Received: from ug-out-1314.google.com ([66.249.92.168]:36328 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932641AbWLMKJI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Dec 2006 05:09:08 -0500
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=aZENZygr6FBU5bbu3q2h74ZmZDXZcQaZuXkSKLWKLJG7i39Fbx3nd3AE6NZSrKULsU3tLbK8EzxHfXL82UV5zYdilFug8vKz584/NyEDgCgXZz/P7q4PvuHMkg2XqObFh4KjiEpBh+yUMnoWpv5FkOqpPEPPtiblecGJFP9PKZY=
Message-ID: <86802c440612130209r5fab0de7q5dcda00c6c01cd13@mail.gmail.com>
Date: Wed, 13 Dec 2006 02:09:06 -0800
From: "Yinghai Lu" <yinghai.lu@amd.com>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [LinuxBIOS] [linux-usb-devel] [RFC][PATCH 0/2] x86_64 Early usb debug port support.
Cc: "Greg KH" <gregkh@suse.de>, "Peter Stuge" <stuge-linuxbios@cdy.org>,
       linux-usb-devel@lists.sourceforge.net,
       "Stefan Reinauer" <stepan@coresystems.de>, linux-kernel@vger.kernel.org,
       linuxbios@linuxbios.org, "Andi Kleen" <ak@suse.de>,
       "David Brownell" <david-b@pacbell.net>
In-Reply-To: <m164cgqmmq.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <5986589C150B2F49A46483AC44C7BCA49072A5@ssvlexmb2.amd.com>
	 <m17ix24ywj.fsf@ebiederm.dsl.xmission.com>
	 <86802c440612080053s13e5318eq7ae83aff4c7eb21c@mail.gmail.com>
	 <m1zm9y3gd2.fsf@ebiederm.dsl.xmission.com>
	 <86802c440612122300k36e84f96x85ef25ebbf27077d@mail.gmail.com>
	 <m164cgqmmq.fsf@ebiederm.dsl.xmission.com>
X-Google-Sender-Auth: 068624279d239d51
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/12/06, Eric W. Biederman <ebiederm@xmission.com> wrote:
> diff --git a/arch/x86_64/kernel/head.S b/arch/x86_64/kernel/head.S
> index 1e6f808..2f65469 100644
> --- a/arch/x86_64/kernel/head.S
> +++ b/arch/x86_64/kernel/head.S
> @@ -328,9 +328,9 @@ ENTRY(wakeup_level4_pgt)
>         .align PAGE_SIZE
>  ENTRY(boot_level4_pgt)
>         .quad   phys_level3_ident_pgt | 0x007
> -       .fill   255,8,0
> +       .fill   257,8,0
>         .quad   phys_level3_physmem_pgt | 0x007
> -       .fill   254,8,0
> +       .fill   252,8,0
>         /* (2^48-(2*1024*1024*1024))/(2^39) = 511 */
>         .quad   phys_level3_kernel_pgt | 0x007
>

Good, it seems __PAGE_OFFSET used to be 0xfff800000000000
and then 1<<40, and then 0xfff810000000000

YH
