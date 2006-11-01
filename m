Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752530AbWKAWhY@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752530AbWKAWhY (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 1 Nov 2006 17:37:24 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752528AbWKAWhY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 1 Nov 2006 17:37:24 -0500
Received: from mail.tmr.com ([64.65.253.246]:64136 "EHLO pixels.tmr.com")
	by vger.kernel.org with ESMTP id S1752526AbWKAWhX (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 1 Nov 2006 17:37:23 -0500
Message-ID: <4549214B.1000103@tmr.com>
Date: Wed, 01 Nov 2006 17:35:55 -0500
From: Bill Davidsen <davidsen@tmr.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.0.7) Gecko/20060910 SeaMonkey/1.0.5
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Andrew Morton <akpm@osdl.org>, linux-pm@osdl.org,
       Ernst Herzberg <earny@net4u.de>, Andi Kleen <ak@suse.de>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       linux-acpi@vger.kernel.org, Hugh Dickins <hugh@veritas.com>,
       Adrian Bunk <bunk@stusta.de>, Martin Lorenz <martin@lorenz.eu.org>
Subject: Re: 2.6.19-rc <-> ThinkPads
References: <Pine.LNX.4.64.0610312123320.25218@g5.osdl.org>	<20061101055435.GB4933@mellanox.co.il> <Pine.LNX.4.64.0610312206390.25218@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0610312206390.25218@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> I wonder if the order matters more, though. Andi? We _used_ to write the 
> high word first, and I think the order matters. The low word contains the 
> enable bit, for example, so when enabling an interrupt, you should write 
> the low word last, when you disable it you should write the low word 
> first.
> 
Although you can argue that anyone coding here should be a guru, in 
practice things this subtle really would be helped by a comment in the 
initial code. I don't agree that "if it was hard to write it should be 
hard to understand." Clearly several competent people missed this 
dependency, or the patch would not have gone in.

-- 
Bill Davidsen <davidsen@tmr.com>
   Obscure bug of 2004: BASH BUFFER OVERFLOW - if bash is being run by a
normal user and is setuid root, with the "vi" line edit mode selected,
and the character set is "big5," an off-by-one errors occurs during
wildcard (glob) expansion.
