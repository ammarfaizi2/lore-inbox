Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263468AbUJ3Dgu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263468AbUJ3Dgu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 29 Oct 2004 23:36:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263470AbUJ3Dgu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 29 Oct 2004 23:36:50 -0400
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:23258 "EHLO
	www.linux.org.uk") by vger.kernel.org with ESMTP id S263466AbUJ3Dfl
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 29 Oct 2004 23:35:41 -0400
Message-ID: <41830BFD.9030003@pobox.com>
Date: Fri, 29 Oct 2004 23:35:25 -0400
From: Jeff Garzik <jgarzik@pobox.com>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.3) Gecko/20040922
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: linux-os@analogic.com, Richard Henderson <rth@redhat.com>,
       Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Andi Kleen <ak@muc.de>, Andrew Morton <akpm@osdl.org>,
       Jan Hubicka <jh@suse.cz>
Subject: Re: Semaphore assembly-code bug
References: <417550FB.8020404@drdos.com> <1098218286.8675.82.camel@mentorng.gurulabs.com> <41757478.4090402@drdos.com> <20041020034524.GD10638@michonline.com> <1098245904.23628.84.camel@krustophenia.net> <1098247307.23628.91.camel@krustophenia.net> <Pine.LNX.4.61.0410200744310.10521@chaos.analogic.com> <Pine.LNX.4.61.0410290805570.11823@chaos.analogic.com> <Pine.LNX.4.58.0410290740120.28839@ppc970.osdl.org> <Pine.LNX.4.61.0410291316470.3945@chaos.analogic.com> <20041029175527.GB25764@redhat.com> <Pine.LNX.4.61.0410291416040.4844@chaos.analogic.com> <Pine.LNX.4.58.0410291133220.28839@ppc970.osdl.org>
In-Reply-To: <Pine.LNX.4.58.0410291133220.28839@ppc970.osdl.org>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:
> Anyway, it's quite likely that for several CPU's the fastest sequence ends 
> up actually being 
> 
> 	movl 4(%esp),%ecx
> 	movl 8(%esp),%edx
> 	movl 12(%esp),%eax
> 	addl $16,%esp
> 
> which is also one of the biggest alternatives.


That's how I'm coding the sparse "compiler backend"...  the mov's and 
add's tend to be tiny instructions (i-cache friendly), and you can often 
issue a bunch of them through multiple pipes/ports.

	Jeff


