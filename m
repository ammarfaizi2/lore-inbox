Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751750AbWBWTf0@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751750AbWBWTf0 (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 14:35:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751717AbWBWTf0
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 14:35:26 -0500
Received: from smtp.osdl.org ([65.172.181.4]:51341 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S1751348AbWBWTfZ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 14:35:25 -0500
Date: Thu, 23 Feb 2006 11:35:16 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rene Herman <rene.herman@keyaccess.nl>
cc: Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
In-Reply-To: <43FE0B9A.40209@keyaccess.nl>
Message-ID: <Pine.LNX.4.64.0602231133110.3771@g5.osdl.org>
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> 
 <1140707358.4672.67.camel@laptopd505.fenrus.org>  <200602231700.36333.ak@suse.de>
 <1140713001.4672.73.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>
 <43FE0B9A.40209@keyaccess.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Feb 2006, Rene Herman wrote:
> 
> Also, did the kernel still boot on a 4M machine, and would it still do so with
> the change to 4M as posted? 2.4 used to boot fine with 4M. Not certain anymore
> if I ever tested that with 2.6 (and can't right now).

If you want to boot a 4MB machine with the suggested patch, you'd have to 
enable CONFIG_EMBEDDED (something you'd likely want to do anyway, for a 4M 
machine), and turn the physical start address back down to 1MB.

That's one reason I didn't make it 16MB. A 4MB machine is pretty damn 
embedded these days (you'd want to enable EMBEDDED just to turn off some 
other things that make the kernel bigger), but I can imagine that real 
people run Linux/x86 in 16MB as long as they don't run X.

		Linus
