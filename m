Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751256AbWHBFp0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751256AbWHBFp0 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 2 Aug 2006 01:45:26 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751262AbWHBFp0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 2 Aug 2006 01:45:26 -0400
Received: from ns2.suse.de ([195.135.220.15]:6808 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1751256AbWHBFpZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 2 Aug 2006 01:45:25 -0400
From: Andi Kleen <ak@suse.de>
To: "Eric W. Biederman" <ebiederm@xmission.com>
Subject: Re: [PATCH 9/33] i386 boot: Add serial output support to the decompressor
Date: Wed, 2 Aug 2006 07:44:40 +0200
User-Agent: KMail/1.9.3
Cc: linux-kernel@vger.kernel.org, Horms <horms@verge.net.au>,
       Jan Kratochvil <lace@jankratochvil.net>,
       "H. Peter Anvin" <hpa@zytor.com>, Magnus Damm <magnus.damm@gmail.com>,
       Vivek Goyal <vgoyal@in.ibm.com>, Linda Wang <lwang@redhat.com>
References: <m1d5bk2046.fsf@ebiederm.dsl.xmission.com> <200608020510.07569.ak@suse.de> <m1odv3vhaz.fsf@ebiederm.dsl.xmission.com>
In-Reply-To: <m1odv3vhaz.fsf@ebiederm.dsl.xmission.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200608020744.40888.ak@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 
> The function pointers in the console structure are also a problem.
> static struct console simnow_console = {
> 	.name =		"simnow",
> 	.write =	simnow_write,
> 	.flags =	CON_PRINTBUFFER,
> 	.index =	-1,
> };

Yes just patch them at runtime.


> Ideally the code would be setup so you can compile out consoles
> the user finds uninteresting.

Seems overkill for early_printk
 
> It is annoying to have to call strlen on all of the strings
> you want to print..

What strlen? 

-Andi
