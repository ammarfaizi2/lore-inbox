Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268382AbUHLAN2@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268382AbUHLAN2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 11 Aug 2004 20:13:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268389AbUHLANG
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 11 Aug 2004 20:13:06 -0400
Received: from mx1.redhat.com ([66.187.233.31]:62147 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268382AbUHKXj0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 11 Aug 2004 19:39:26 -0400
Date: Wed, 11 Aug 2004 19:39:04 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH] aes-i586-asm.S optimization
In-Reply-To: <200408120056.03939.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Xine.LNX.4.44.0408111933510.15190-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004, Denis Vlasenko wrote:

> formatting.patch:
> renames macro parameters to more understandable ones
> fixes wrong comment (code does not use MMX)

This looks good, thanks.

> 
> opt.patch:
> convert fwd_rnd into pair of fwd_rnd1,fwd_rnd2 which use
> r0,r2 in mirror-image fashion, thus eliminating the need
> to do "mov r0,r2". After testing, same can be done
> to inv_rnd.

This bumped performance on a P4 Xeon by about 5%, which is pretty good.  
How much more would you expect again with inv_rnd?

> Both patches are only compile tested. First one produces bit-identical
> object file. Second one, understandably, not.
> 
> PS: why aes-i586-asm.S? it is valid _386_ code (no Pentium ops used AFAICS).

My understanding is that the code is generally optimized for Pentium, 
although that could be wrong.  I'll check with the original author.

> PPS: your code is very easy to understand. It was a joy hacking on it :)

It's Brian Gladman's code (converted to gas format by Linus).


- James
-- 
James Morris
<jmorris@redhat.com>


