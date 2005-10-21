Return-Path: <linux-kernel-owner+willy=40w.ods.org-S965022AbVJUQ1B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965022AbVJUQ1B (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Oct 2005 12:27:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965024AbVJUQ1B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Oct 2005 12:27:01 -0400
Received: from [195.23.16.24] ([195.23.16.24]:41904 "EHLO
	linuxbipbip.grupopie.com") by vger.kernel.org with ESMTP
	id S965022AbVJUQ1A (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Oct 2005 12:27:00 -0400
Message-ID: <435916D1.6040604@grupopie.com>
Date: Fri, 21 Oct 2005 17:26:57 +0100
From: Paulo Marques <pmarques@grupopie.com>
Organization: Grupo PIE
User-Agent: Mozilla Thunderbird 1.0.6 (X11/20050716)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Vincent W. Freeh" <vin@csc.ncsu.edu>
CC: linux-kernel@vger.kernel.org
Subject: Re: Understanding Linux addr space, malloc, and heap
References: <4358F0E3.6050405@csc.ncsu.edu> <1129903396.2786.19.camel@laptopd505.fenrus.org> <4359051C.2070401@csc.ncsu.edu> <1129908179.2786.23.camel@laptopd505.fenrus.org> <43590B23.2090101@csc.ncsu.edu> <C6F7B216-66B3-4848-9423-05AB4D826320@mac.com> <43591307.5050507@csc.ncsu.edu>
In-Reply-To: <43591307.5050507@csc.ncsu.edu>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Vincent W. Freeh wrote:
> First, thanks for all the help and attention.  I am learning much.
> 
> I think the focus of this discussion should be on mprotect.  I 
> understand that spec says it only works on mmap'd memory.  So does 
> malloc use mmap?  If not why does it work at all?
> 
> Probably the most problematic issue, tho, is why does mprotect return 0 
> even though it failed to change permissions on the 66th page?

Do you have code that shows this?

I tried to change the example in the mprotect man page to loop N times 
(N given on the command line) malloc'ing and mprotect'ing N pages and 
then accessing the N'th page and it always gave SIGSEGV, for any N from 
1 to 100.

-- 
Paulo Marques - www.grupopie.com

The rule is perfect: in all matters of opinion our
adversaries are insane.
Mark Twain
