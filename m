Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932189AbWFMUL7@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932189AbWFMUL7 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Jun 2006 16:11:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932205AbWFMUL7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Jun 2006 16:11:59 -0400
Received: from fmr18.intel.com ([134.134.136.17]:39624 "EHLO
	orsfmr003.jf.intel.com") by vger.kernel.org with ESMTP
	id S932189AbWFMUL6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Jun 2006 16:11:58 -0400
Message-ID: <448F1BCE.50708@linux.intel.com>
Date: Tue, 13 Jun 2006 13:10:54 -0700
From: Arjan van de Ven <arjan@linux.intel.com>
User-Agent: Thunderbird 1.5 (Windows/20051201)
MIME-Version: 1.0
To: Andreas Mohr <andi@rhlx01.fht-esslingen.de>
CC: Andrew Morton <akpm@osdl.org>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH -mm] i386 usercopy.c opcode reordering (pipelining)
References: <20060613195502.GE24167@rhlx01.fht-esslingen.de>
In-Reply-To: <20060613195502.GE24167@rhlx01.fht-esslingen.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andreas Mohr wrote:
> Hi all,
> 
> this one wrote to register %0 and immediately right-shifted it,
> so let's andl register %3 first for better parallelism (rrright?).

have you benchmarked this?
I would actually expect no difference since a reg-reg move is basically
a thing for the register rename engine which then... well it's supposed
to be near free like this.
