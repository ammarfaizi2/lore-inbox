Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262288AbTFBMz1 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 2 Jun 2003 08:55:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262290AbTFBMz1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 2 Jun 2003 08:55:27 -0400
Received: from holomorphy.com ([66.224.33.161]:50846 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id S262288AbTFBMz0 (ORCPT
	<rfc822;Linux-Kernel@vger.kernel.org>);
	Mon, 2 Jun 2003 08:55:26 -0400
Date: Mon, 2 Jun 2003 06:08:46 -0700
From: William Lee Irwin III <wli@holomorphy.com>
To: Nikita Danilov <Nikita@Namesys.COM>
Cc: Gianni Tedesco <gianni@scaramanga.co.uk>,
       Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
       Linus Torvalds <Torvalds@Transmeta.COM>, Andrew Morton <AKPM@Digeo.COM>,
       Russell King <RMK@Arm.Linux.ORG.UK>
Subject: Re: const from include/asm-i386/byteorder.h
Message-ID: <20030602130846.GQ8978@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	Nikita Danilov <Nikita@Namesys.COM>,
	Gianni Tedesco <gianni@scaramanga.co.uk>,
	Linux Kernel Mailing List <Linux-Kernel@Vger.Kernel.ORG>,
	Linus Torvalds <Torvalds@Transmeta.COM>,
	Andrew Morton <AKPM@Digeo.COM>, Russell King <RMK@Arm.Linux.ORG.UK>
References: <16088.47088.814881.791196@laputa.namesys.com> <1054406992.4837.0.camel@sherbert> <20030531185709.GK8978@holomorphy.com> <16091.14923.815819.792026@laputa.namesys.com> <20030602121457.GO8978@holomorphy.com> <16091.17602.257293.364468@laputa.namesys.com> <20030602124016.GP8978@holomorphy.com> <16091.18977.642080.798274@laputa.namesys.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16091.18977.642080.798274@laputa.namesys.com>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

William Lee Irwin III writes:
>> Sounds good. If you could doublecheck the assembly to make sure it's
>> doing the right thing, that would be good, too.

On Mon, Jun 02, 2003 at 04:59:13PM +0400, Nikita Danilov wrote:
> I have neither ARM hardware nor knowledge of their assembly. Maybe
> someone from ARM development team will help.

I'd say that i386 is the only one needing direct auditing, the others
can differ if they discover it's problematic. But I think your stress
testing should be enough; if there's a problem it should come up rather
quickly, as context switching is very fundamental and the only thing
that could violate the assumptions given to the compiler, and when
broken it's very obvious _something_ is broken.

As I had heard it, this broke rather blatantly. If it's passing tests
then the issues I had heard of are not happening.


-- wli
