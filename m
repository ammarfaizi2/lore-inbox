Return-Path: <linux-kernel-owner+willy=40w.ods.org-S268345AbUIDE66@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S268345AbUIDE66 (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 4 Sep 2004 00:58:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S269691AbUIDE66
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 4 Sep 2004 00:58:58 -0400
Received: from holly.csn.ul.ie ([136.201.105.4]:43747 "EHLO holly.csn.ul.ie")
	by vger.kernel.org with ESMTP id S268345AbUIDE6z (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 4 Sep 2004 00:58:55 -0400
Date: Sat, 4 Sep 2004 05:58:55 +0100 (IST)
From: Dave Airlie <airlied@linux.ie>
X-X-Sender: airlied@skynet
To: Jon Smirl <jonsmirl@yahoo.com>
Cc: dri-devel@lists.sf.net, linux-kernel@vger.kernel.org
Subject: Re: New proposed DRM interface design
In-Reply-To: <20040904012008.81382.qmail@web14927.mail.yahoo.com>
Message-ID: <Pine.LNX.4.58.0409040552590.25475@skynet>
References: <20040904012008.81382.qmail@web14927.mail.yahoo.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>
> If you're Nvidia you ship the library source (since it is GPL) and a

is it GPL though.. we are X licensed at the moment and all my changes are
under the original license...

> binary driver. You compile the library on your kernel so that kernel
> API IFDEF's get executed and then link to the binary driver. This model
> won't work with IFDEF'd inline functions that are used in a binary
> driver. They will have to be real functions in the library.

there shouldn't be many ifdefs left, AGP and MTRR, if you re building a
binary driver for x86 you can assume the platform has AGP and MTRR and the
kernel should sort it all out, the remaining macros are mainly for
building on Alpha and Sparc...

 >
> How big is the library that is going to get duplicated? Note that it
> only gets duplicated for different cards not multiple instances of the
> same card family.

it'll be big but that's the same as we have now as I said, I believe the
balance between having a common library with an extensive new binary
interface, vs the un-common use case of using two different graphics card
in one PC is worth having the library in eeach driver, the binary
interface needs to be avoided at all costs, and I believe Keith's opinion
is worth listening to on binary interfaces :-)

> Are you going to hide the exported symbols so that we don't need the
> DRM() macros?
>

Again that is a bit of a separate project, my thinking on all these
projects is that I can feed them into the kernel is small obvious changes
this change will probably just fall out at the end as obvious it isn't so
for me yet...

I'm willing to spend the time doing an initial implementation (as we all
know, code talks, I'm not sure what talking does :-)

Dave.


-- 
David Airlie, Software Engineer
http://www.skynet.ie/~airlied / airlied at skynet.ie
pam_smb / Linux DECstation / Linux VAX / ILUG person

