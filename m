Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1946783AbWKJXjP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946783AbWKJXjP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 10 Nov 2006 18:39:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1946824AbWKJXjP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 10 Nov 2006 18:39:15 -0500
Received: from gw.goop.org ([64.81.55.164]:6355 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1946783AbWKJXjO (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 10 Nov 2006 18:39:14 -0500
Message-ID: <45550D9F.5000108@goop.org>
Date: Fri, 10 Nov 2006 15:39:11 -0800
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.8 (X11/20061107)
MIME-Version: 1.0
To: "Eric W. Biederman" <ebiederm@xmission.com>
CC: Magnus Damm <magnus.damm@gmail.com>, Magnus Damm <magnus@valinux.co.jp>,
       linux-kernel@vger.kernel.org, Vivek Goyal <vgoyal@in.ibm.com>,
       Andi Kleen <ak@muc.de>, fastboot@lists.osdl.org,
       Horms <horms@verge.net.au>, Dave Anderson <anderson@redhat.com>
Subject: Re: [PATCH 02/02] Elf: Align elf notes properly
References: <20061102101942.452.73192.sendpatchset@localhost>	<20061102101949.452.23441.sendpatchset@localhost>	<m1psbwzpmx.fsf@ebiederm.dsl.xmission.com>	<aec7e5c30611091952j6cd7988akc1671d269925bba9@mail.gmail.com> <m1irhnnb09.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1irhnnb09.fsf@ebiederm.dsl.xmission.com>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Eric W. Biederman wrote:
> To verify your claim that 8 byte alignment is correct I checked the
> core dump code in fs/binfmt_elf.c in the linux kernel.  That always
> uses 4 byte alignment.  Therefore it appears clear that only doing
> 4 byte alignment is not a local misreading of the spec, and is used in
> other implementations.  If you can find an implementation that uses
> 8 byte alignment I am willing to consider it.
>   

I wrote the Elf core code, so I may be carrying the same misreading into
multiple places.  In my defence, I think I wrote that before there were
any 64-bit Linux ports (hm, Alpha might have been around).

    J
