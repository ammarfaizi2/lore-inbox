Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750981AbVKTHKD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750981AbVKTHKD (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 20 Nov 2005 02:10:03 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751060AbVKTHKD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 20 Nov 2005 02:10:03 -0500
Received: from mail.ocs.com.au ([202.147.117.210]:31172 "EHLO mail.ocs.com.au")
	by vger.kernel.org with ESMTP id S1750981AbVKTHKB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 20 Nov 2005 02:10:01 -0500
X-Mailer: exmh version 2.6.3_20040314 03/14/2004 with nmh-1.1
From: Keith Owens <kaos@ocs.com.au>
To: Hua Feijun <hua.feijun@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: a problem with ia64_fc 
In-reply-to: Your message of "Fri, 18 Nov 2005 15:06:00 +0800."
             <3fe1d240511172306ved25caam@mail.gmail.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 20 Nov 2005 18:09:41 +1100
Message-ID: <4869.1132470581@ocs3.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Nov 2005 15:06:00 +0800, 
Hua Feijun <hua.feijun@gmail.com> wrote:
>Who can tell me the function of ia64_fc

It flushes the cachelines that correspond to an address.  By design the
IA64 instruction cache does not detect self modifying code, so an
instruction can be changed in memory but the old instruction can still
be in cache.  ia64_fc is used to flush the changed cacheline to ensure
that you execute the modified instruction.

>and  what is  the different of
>system_call_table among ia64,x86_64t and i386?

You will have to be more specific about your question, what are you
trying to do with the syscall table?  Since you are also asking about
ia64_fc I guess that you are trying to patch the syscall table, and the
standard answer to that is "DO NOT PATCH THE SYSCALL TABLE!".  It is
not supported and will not be supported.

