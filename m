Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161597AbWI2Toc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161597AbWI2Toc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Sep 2006 15:44:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161598AbWI2Toc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Sep 2006 15:44:32 -0400
Received: from gw.goop.org ([64.81.55.164]:14258 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1161597AbWI2Tob (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Sep 2006 15:44:31 -0400
Message-ID: <451D77A5.20103@goop.org>
Date: Fri, 29 Sep 2006 12:44:37 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20060913)
MIME-Version: 1.0
To: michael@ellerman.id.au
CC: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Andi Kleen <ak@muc.de>, Hugh Dickens <hugh@veritas.com>,
       Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH RFC 1/4] Generic BUG handling.
References: <20060928225444.439520197@goop.org> >	  <20060928225452.229936605@goop.org>> <1159506427.25820.20.camel@localhost.localdomain>
In-Reply-To: <1159506427.25820.20.camel@localhost.localdomain>
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michael Ellerman wrote:
> It needed a bit of work to get going on powerpc:
>
> Generic BUG handling, Powerpc fixups
>   

BTW, powerpc doesn't seem to be using BUG_OPCODE or 
BUG_ILLEGAL_INSTRUCTION for actual BUGs any more (I presume they were 
once used).  There are still a couple of uses of those macros elsewhere 
(kernel/prom_init.c and kernel/head_64.S); should be converted to "twi 
31,0,0" as well?

    J
