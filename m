Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751439AbWGXHhD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751439AbWGXHhD (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 03:37:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932076AbWGXHhD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 03:37:03 -0400
Received: from ug-out-1314.google.com ([66.249.92.175]:17142 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751439AbWGXHhA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 03:37:00 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:sender:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references:x-google-sender-auth;
        b=Wq2SMP4m8xB6Q9uxh+qrszWgmQufbefrkGSGzfqNyKI+0XwiZ5+JeSmHFo3d02aex1066P6GWYmIoxFlyXsSO+/gSEyTqNw5mLzSzc2Yjrpe3sbUrbZ4BuiNdUuv7aXPdbRcIfCyy5QsFXyazP3ALszOI+UwQ/nTN12PmfpQ/rw=
Message-ID: <84144f020607240036k4276a373i18d3490d9925344@mail.gmail.com>
Date: Mon, 24 Jul 2006 10:36:59 +0300
From: "Pekka Enberg" <penberg@cs.helsinki.fi>
To: "Greg Scott" <GregScott@infrasupportetc.com>
Subject: Re: 2.6.17.2 kernel bug?
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <925A849792280C4E80C5461017A4B8A206F83F@mail733.InfraSupportEtc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <925A849792280C4E80C5461017A4B8A206F83F@mail733.InfraSupportEtc.com>
X-Google-Sender-Auth: a3af9a3b5a92743b
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On 7/24/06, Greg Scott <GregScott@infrasupportetc.com> wrote:
> This may be a hardware problem but I thought I should tell somebody.
> It's running on a Dell Optiplex GX110, p3 733mhz, 256MB.

Have you ran memtest on this machine?

On 7/24/06, Greg Scott <GregScott@infrasupportetc.com> wrote:
> Jul 23 16:26:37 lakeville-fw kernel: ------------[ cut here
> ]------------
> Jul 23 16:26:37 lakeville-fw kernel: kernel BUG at mm/swapfile.c:352!
> Jul 23 16:26:37 lakeville-fw kernel: invalid opcode: 0000 [#1]

[snip]

> Jul 23 16:26:37 lakeville-fw kernel: EIP is at
> remove_exclusive_swap_page+0xb/0xe3

[snip]

> Jul 23 16:26:37 lakeville-fw kernel: Call Trace:
> Jul 23 16:26:37 lakeville-fw kernel:  <c0149109>
> free_page_and_swap_cache+0x1b/0x2a  <c0142645> unmap_vmas+0x297/0x490
> Jul 23 16:26:37 lakeville-fw kernel:  <c0144ddd> exit_mmap+0x50/0xbc
> <c011814e> mmput+0x1f/0x76
> Jul 23 16:26:37 lakeville-fw kernel:  <c011c5d7> do_exit+0x18a/0x6ca
> <c011cb84> sys_exit_group+0x0/0xd

The page was locked before entering remove_exclusive_swap_page() in
free_swap_cache() so fault RAM seems more likely.

                                               Pekka
