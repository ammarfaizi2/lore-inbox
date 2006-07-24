Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751447AbWGXUy5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751447AbWGXUy5 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 24 Jul 2006 16:54:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751448AbWGXUy5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 24 Jul 2006 16:54:57 -0400
Received: from gw.goop.org ([64.81.55.164]:30424 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1751447AbWGXUy4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 24 Jul 2006 16:54:56 -0400
Message-ID: <44C5338D.4060805@goop.org>
Date: Mon, 24 Jul 2006 13:54:37 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060613)
MIME-Version: 1.0
To: Andi Kleen <ak@muc.de>
CC: Rusty Russell <rusty@rustcorp.com.au>,
       Chuck Ebbert <76306.1226@compuserve.com>,
       linux-kernel <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH 5/6] Begin abstraction of sensitive instructions: asm
 files
References: <200607212326_MC3-1-C5B8-F9ED@compuserve.com> <1153575288.13198.16.camel@localhost.localdomain> <20060724173629.GB50320@muc.de>
In-Reply-To: <20060724173629.GB50320@muc.de>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> I would rather pass the register to the macro? If you start to
> clobber registers you would need to pass in the tmp registers
> too I guess.
The intent is that these code sequences can be patched in place, so they 
need to have a specific abi at the machine-code level.  Some of the 
operations whose Xen implementation clobbers a register have that in 
their definition, on the assumption that 1 temp is enough, and that 
another interface which needs more can organize save/restoring registers 
for itself.

    J
