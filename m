Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261501AbVDDXb5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261501AbVDDXb5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 4 Apr 2005 19:31:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261506AbVDDXam
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 4 Apr 2005 19:30:42 -0400
Received: from e32.co.us.ibm.com ([32.97.110.130]:36301 "EHLO
	e32.co.us.ibm.com") by vger.kernel.org with ESMTP id S261501AbVDDX3L
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 4 Apr 2005 19:29:11 -0400
Subject: Re: [PATCH 1/4] create mm/Kconfig for arch-independent memory
	options
From: Dave Hansen <haveblue@us.ibm.com>
To: Mike Kravetz <kravetz@us.ibm.com>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-mm <linux-mm@kvack.org>, Andy Whitcroft <apw@shadowen.org>
In-Reply-To: <20050404232254.GC6500@w-mikek2.ibm.com>
References: <E1DIViE-0006Kf-00@kernel.beaverton.ibm.com>
	 <20050404232254.GC6500@w-mikek2.ibm.com>
Content-Type: text/plain
Date: Mon, 04 Apr 2005 16:29:02 -0700
Message-Id: <1112657342.27328.64.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 2005-04-04 at 16:22 -0700, Mike Kravetz wrote:
> Do you need to set ARCH_DISCONTIGMEM_DEFAULT instead of just
> CONFIG_ARCH_DISCONTIGMEM_ENABLE to have DISCONTIGMEM be the
> default? or am I missing something?  I don't see
> ARCH_DISCONTIGMEM_DEFAULT turned on by default in any of these
> patches.

It's a wee bit confusing, but I think it all works out.

Doing ARCH_DISCONTIGMEM_ENABLE=y turns off the FLATMEM option in the
mm/Kconfig prompt because FLATMEM depends on !ARCH_DISCONTIGMEM_ENABLE.
So, if you enable it, it will end up being the default because there's
no other choice.

For configs that *need* both options, you can re-enable FLATMEM with
ARCH_FLATMEM_ENABLE

-- Dave

