Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268662AbUHLTLn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268662AbUHLTLn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 12 Aug 2004 15:11:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S268665AbUHLTLm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 12 Aug 2004 15:11:42 -0400
Received: from mx1.redhat.com ([66.187.233.31]:42413 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S268662AbUHLTLj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 12 Aug 2004 15:11:39 -0400
Date: Thu, 12 Aug 2004 15:10:11 -0400 (EDT)
From: James Morris <jmorris@redhat.com>
X-X-Sender: jmorris@dhcp83-76.boston.redhat.com
To: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
cc: linux-kernel@vger.kernel.org, Arjan van de Ven <arjanv@redhat.com>
Subject: Re: [PATCH] aes-i586-asm.S optimization
In-Reply-To: <200408122052.44738.vda@port.imtp.ilyichevsk.odessa.ua>
Message-ID: <Xine.LNX.4.44.0408121508130.18646-100000@dhcp83-76.boston.redhat.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 12 Aug 2004, Denis Vlasenko wrote:

> > However, 5% is too high. My hack eliminated a register move,
> > which is very fast operation. It shouldn't have such noticeable
> > effect. P4 is a strange beast.
> 
> Ok, here is two more patches. opt3.patch does optimisation (similar
> to one in opt.patch) to decrypt routine. Done on top of opt.patch.

This one decreases performance.

> opt4.patch is an experimental one which does register spills
> into stack not by mov's, but by push/pop. May be faster because
> push/pop pairs often get special treatment in hardware in todays
> processors, because it is such a typical operation.
> Also, each mov is four bytes of code, whereas push or pop
> is only one. Together with eliminated stack adjustment code
> this shortens object code by 348 bytes.

This one decreases performance again.

I'm using apachebench over loopback with IPSec to test this, so perhaps 
not the best 'raw' benchmark, but I think a reasonable macro benchmark.


- James
-- 
James Morris
<jmorris@redhat.com>


