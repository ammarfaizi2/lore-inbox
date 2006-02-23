Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932071AbWBWUM5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932071AbWBWUM5 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 15:12:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751784AbWBWUM5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 15:12:57 -0500
Received: from smtpq2.groni1.gr.home.nl ([213.51.130.201]:40120 "EHLO
	smtpq2.groni1.gr.home.nl") by vger.kernel.org with ESMTP
	id S1751780AbWBWUM4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 15:12:56 -0500
Message-ID: <43FE1764.6000300@keyaccess.nl>
Date: Thu, 23 Feb 2006 21:13:24 +0100
From: Rene Herman <rene.herman@keyaccess.nl>
User-Agent: Thunderbird 1.5 (X11/20051201)
MIME-Version: 1.0
To: Linus Torvalds <torvalds@osdl.org>
CC: Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>  <1140707358.4672.67.camel@laptopd505.fenrus.org>  <200602231700.36333.ak@suse.de> <1140713001.4672.73.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org> <43FE0B9A.40209@keyaccess.nl> <Pine.LNX.4.64.0602231133110.3771@g5.osdl.org>
In-Reply-To: <Pine.LNX.4.64.0602231133110.3771@g5.osdl.org>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
X-AtHome-MailScanner-Information: Neem contact op met support@home.nl voor meer informatie
X-AtHome-MailScanner: Found to be clean
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Linus Torvalds wrote:

> If you want to boot a 4MB machine with the suggested patch, you'd 
> have to enable CONFIG_EMBEDDED (something you'd likely want to do 
> anyway, for 4M machine), and turn the physical start address back
> down to 1MB.

Okay. I suppose the only other option is to make "physical_start" a 
variable passed in by the bootloader so that it could make a runtime 
decision? Ie, place us at min(top_of_mem, 4G) if it cared to. I just 
grepped for PHYSICAL_START and this didn't look _too_ bad.

I'm out of my league here though -- if I remember correctly from some 
reading of the early bootcode I once did, the kernel set up some 
temporary tables first to only cover the first few MB? If so, then I 
guess it would be a significant change.

Seems a bit cleaner though than just hardcoding the address.

> That's one reason I didn't make it 16MB. A 4MB machine is pretty damn
> embedded these days (you'd want to enable EMBEDDED just to turn off
> some other things that make the kernel bigger), but I can imagine
> that real people run Linux/x86 in 16MB as long as they don't run X.

My 386 is happy with its current 16M (it can't cache all of the 32M I 
can physically put in), used to be happy with 8M, and used to boot with 
4M... ofcourse, although it's not very embedded (you should see it) it's 
also not very "real" in that sense ;-)

Love the machine to death, though...

Rene.
