Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261221AbTIKOPk (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 11 Sep 2003 10:15:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261226AbTIKOPk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 11 Sep 2003 10:15:40 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:38321 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S261221AbTIKOPi
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 11 Sep 2003 10:15:38 -0400
Message-ID: <3F60837D.7000209@pobox.com>
Date: Thu, 11 Sep 2003 10:15:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
Organization: none
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.2.1) Gecko/20021213 Debian/1.2.1-2.bunk
X-Accept-Language: en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Andrew Morton <akpm@osdl.org>, richard.brunner@amd.com,
       linux-kernel@vger.kernel.org, torvalds@osdl.org
Subject: Re: [PATCH] 2.6 workaround for Athlon/Opteron prefetch errata
References: <99F2150714F93F448942F9A9F112634C0638B196@txexmtae.amd.com> <20030911012708.GD3134@wotan.suse.de> <20030910184414.7850be57.akpm@osdl.org> <20030911014716.GG3134@wotan.suse.de>
In-Reply-To: <20030911014716.GG3134@wotan.suse.de>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> It could be done but ... we are moving more and more to generic kernels
> (e.g. see the alternative patch code which is enabled unconditionally)
> So that when you have a kernel it will boot on near all modern CPUs.


Only with CONFIG_X86_GENERIC.  That's precisely why CONFIG_X86_GENERIC 
was created.

If I disabled CONFIG_X86_GENERIC and select CONFIG_MPENTIUM4, I darned 
well better not get any Athlon code.  The cpu setup code in particular I 
want to conditionalize, and there are other bits that need work... but 
for the most part it works as intended.

	Jeff



