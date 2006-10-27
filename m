Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752497AbWJ0Vbl@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752497AbWJ0Vbl (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Oct 2006 17:31:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752498AbWJ0Vbl
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Oct 2006 17:31:41 -0400
Received: from gw.goop.org ([64.81.55.164]:7902 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S1752497AbWJ0Vbk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Oct 2006 17:31:40 -0400
Message-ID: <45427ABD.6070407@goop.org>
Date: Fri, 27 Oct 2006 14:31:41 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.7 (X11/20061008)
MIME-Version: 1.0
To: Pavel Machek <pavel@ucw.cz>
CC: Rusty Russell <rusty@rustcorp.com.au>, Andrew Morton <akpm@osdl.org>,
       virtualization <virtualization@lists.osdl.org>,
       lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/4] Prep for paravirt: Be careful about touching BIOS
 address space
References: <1161920325.17807.29.camel@localhost.localdomain>	<1161920535.17807.33.camel@localhost.localdomain> <20061027113001.GB8095@elf.ucw.cz>
In-Reply-To: <20061027113001.GB8095@elf.ucw.cz>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Pavel Machek wrote:
> Indentation is b0rken here.
>   

Oops.  How strange.

> And... is get_user right primitive for accessing area that may not be
> there?

I'm pretty sure there's precedent for using __get_user in this way 
(get_user is a different matter, since it cares about whether the 
address is within the user part of the address space).  Certainly in 
arch/i386 code there shouldn't be a problem.  Is there some other way to 
achieve the same effect (without manually setting up an exception/fixup 
block)?

    J
