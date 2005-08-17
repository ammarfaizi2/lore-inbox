Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751196AbVHQST3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751196AbVHQST3 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 17 Aug 2005 14:19:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751198AbVHQST3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 17 Aug 2005 14:19:29 -0400
Received: from e6.ny.us.ibm.com ([32.97.182.146]:60868 "EHLO e6.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id S1751196AbVHQST2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 17 Aug 2005 14:19:28 -0400
Subject: Re: [RFC] Cleanup line-wrapping in pgtable.h
From: Dave Hansen <haveblue@us.ibm.com>
To: Adam Litke <agl@us.ibm.com>
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
In-Reply-To: <1124300739.3139.16.camel@localhost.localdomain>
References: <1124300739.3139.16.camel@localhost.localdomain>
Content-Type: text/plain
Date: Wed, 17 Aug 2005 11:19:13 -0700
Message-Id: <1124302753.5879.11.camel@localhost>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.4 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2005-08-17 at 12:45 -0500, Adam Litke wrote:
> The line-wrapping in most of the include/asm/pgtable.h pte test/set
> macros looks horrible in my 80 column terminal.  The following "test the
> waters" patch is how I would like to see them laid out.  I realize that
> the braces don't adhere to CodingStyle but the advantage is (when taking
> wrapping into account) that the code takes up no additional space.  How
> do people feel about making this change?  Any better suggestions?  I
> personally wouldn't like a lone closing brace like normal functions
> because of the extra lines eaten.  I volunteer to patch up the other
> architectures if we reach a consensus.

I'd probably just leave it alone.  Those are things that are virtually
never touched, and are quite unlikely to have any bugs in them.

But, if you do decide to change them, it might also be a nice idea to
consolidate some of the ones that are duplicated across architectures.
They could probably even go into the existing
include/asm-generic/pgtable.h.  Please use full, proper CodingStyle if
you do decide to split them across several lines.

-- Dave

