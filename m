Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1423493AbWJaPzg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1423493AbWJaPzg (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 31 Oct 2006 10:55:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1423505AbWJaPzg
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 31 Oct 2006 10:55:36 -0500
Received: from smtp.osdl.org ([65.172.181.4]:7346 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1423493AbWJaPzf (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 31 Oct 2006 10:55:35 -0500
Date: Tue, 31 Oct 2006 07:55:25 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andrew Morton <akpm@osdl.org>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       "Jun'ichi Nomura" <j-nomura@ce.jp.nec.com>
Subject: Re: Linux 2.6.19-rc4
In-Reply-To: <20061030213454.8266fcb6.akpm@osdl.org>
Message-ID: <Pine.LNX.4.64.0610310737000.25218@g5.osdl.org>
References: <Pine.LNX.4.64.0610302019560.25218@g5.osdl.org>
 <20061030213454.8266fcb6.akpm@osdl.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 30 Oct 2006, Andrew Morton wrote:
> 
> That didn't go so well.  I guess the below was intended, but I wonder if
> we actually merged the correct patch?

Gaah.

And I have SYSFS enabled, so I should have seen this warning.

But I've become innoculated against warnings, just because we have too 
many of the totally useless noise about deprecation and crud, and ppc has 
it's own set of bogus compiler-and-linker-generated warnings..

At some point we should get rid of all the "politeness" warnings, just 
because they can end up hiding the _real_ ones.

"pm_register is deprecated" etc - I get almost a hundred lines of warnings 
in my default build (and half of those are sadly due to powerpc binutils, 
that I can't do anythign about: "section .init.text exceeds stub group 
size" etc, which is harmless _other_ than the fact that it helped hide the 
real warnings just because I've grown too used to not looking too 
closely).

		Linus
