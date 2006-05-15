Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964890AbWEOLgj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964890AbWEOLgj (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 May 2006 07:36:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964891AbWEOLgj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 May 2006 07:36:39 -0400
Received: from mailhost.tue.nl ([131.155.2.19]:29687 "EHLO mailhost.tue.nl")
	by vger.kernel.org with ESMTP id S964890AbWEOLgi (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 May 2006 07:36:38 -0400
Message-ID: <446867C4.3070108@etpmod.phys.tue.nl>
Date: Mon, 15 May 2006 13:36:36 +0200
From: Bart Hartgers <bart@etpmod.phys.tue.nl>
User-Agent: Thunderbird 1.5 (X11/20060111)
MIME-Version: 1.0
To: Tomasz Malesinski <tmal@mimuw.edu.pl>
Cc: Andi Kleen <ak@suse.de>, linux-kernel@vger.kernel.org
Subject: Re: Segfault on the i386 enter instruction
References: <20060512131654.GB2994@duch.mimuw.edu.pl> <p734pzv73oj.fsf@bragg.suse.de> <20060512153139.GA4852@duch.mimuw.edu.pl>
In-Reply-To: <20060512153139.GA4852@duch.mimuw.edu.pl>
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tomasz Malesinski wrote:
> On Fri, May 12, 2006 at 03:50:20PM +0200, Andi Kleen wrote:
>> Handling it like you expect would require to disassemble 
>> the function in the page fault handler and it's probably not 
>> worth doing that for this weird case.
> 
> Does it mean that the ENTER instruction should not be used to create
> stack frames in Linux programs?
> 

Basically, yes. Here is a link to a relevant discussion in the 2.2.7 era:

http://groups.google.co.nz/groups?selm=7i86ni%24b7n%241%40palladium.transmeta.com

And perhaps x86-64 is handled different because of the red zone (some
memory below the stack-pointer that can be accessed legally)?

Groeten,
Bart

-- 
Bart Hartgers - TUE Eindhoven - http://plasimo.phys.tue.nl/bart/contact/
