Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965000AbWFIKME@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965000AbWFIKME (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 9 Jun 2006 06:12:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965009AbWFIKME
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 9 Jun 2006 06:12:04 -0400
Received: from ozlabs.org ([203.10.76.45]:13002 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S965000AbWFIKMB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 9 Jun 2006 06:12:01 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <17545.16696.195276.334774@cargo.ozlabs.ibm.com>
Date: Fri, 9 Jun 2006 19:36:56 +1000
From: Paul Mackerras <paulus@samba.org>
To: mel@csn.ul.ie (Mel Gorman)
Cc: Segher Boessenkool <segher@kernel.crashing.org>,
       Andrew Morton <akpm@osdl.org>, linuxppc-dev@ozlabs.org,
       vgoyal@in.ibm.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Compile failure fix for ppc on 2.6.17-rc4-mm3 (2nd
	attempt)
In-Reply-To: <20060529190515.GA17608@skynet.ie>
References: <20060526151214.GA5190@skynet.ie>
	<20060526094924.10efc515.akpm@osdl.org>
	<20060529154923.GA9025@skynet.ie>
	<2ebd96e4a7ea753273b2c5f856ba8c7a@kernel.crashing.org>
	<Pine.LNX.4.64.0605291825500.11234@skynet.skynet.ie>
	<c6414fc4b2c627791a49085bf8eea7e8@kernel.crashing.org>
	<20060529190515.GA17608@skynet.ie>
X-Mailer: VM 7.19 under Emacs 21.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mel Gorman writes:

> +	res->end = -(-res->end & ~(unsigned long)mask); \
> +	res->end += mask; \

I think this is equivalent to

	res->end = (res->end + mask) | mask;

and I have to say the latter seems more understandable to me (and
doesn't need a cast) ...

Regards,
Paul.

