Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965440AbWH2WaB@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965440AbWH2WaB (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 29 Aug 2006 18:30:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965441AbWH2WaA
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 29 Aug 2006 18:30:00 -0400
Received: from gw.goop.org ([64.81.55.164]:51663 "EHLO mail.goop.org")
	by vger.kernel.org with ESMTP id S965440AbWH2WaA (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 29 Aug 2006 18:30:00 -0400
Message-ID: <44F4BFE6.9090202@goop.org>
Date: Tue, 29 Aug 2006 15:29:58 -0700
From: Jeremy Fitzhardinge <jeremy@goop.org>
User-Agent: Thunderbird 1.5.0.5 (X11/20060803)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@suse.de>, Zachary Amsden <zach@vmware.com>,
       Chuck Ebbert <76306.1226@compuserve.com>
Subject: Re: Why set ORIG_EAX(%esp) to -1 in arch/i386/kernel/entry.S:error_code?
References: <44F48F7D.4050908@goop.org> <Pine.LNX.4.64.0608291455120.27779@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0608291455120.27779@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> No. It's important that ORIG_EAX be set to some value that is _not_ a 
> valid system call number, so that the system call restart logic (see the 
> signal handling code) doesn't trigger.
>   

Ah, yes, I see.  I'll add a comment in my i386-pda patch to entry.S.

    J
