Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932354AbWBWRok@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932354AbWBWRok (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 12:44:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932356AbWBWRok
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 12:44:40 -0500
Received: from smtp.osdl.org ([65.172.181.4]:720 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932354AbWBWRoj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 12:44:39 -0500
Date: Thu, 23 Feb 2006 09:44:30 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Andi Kleen <ak@suse.de>
cc: Arjan van de Ven <arjan@linux.intel.com>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
In-Reply-To: <200602231820.50384.ak@suse.de>
Message-ID: <Pine.LNX.4.64.0602230939360.3771@g5.osdl.org>
References: <1140700758.4672.51.camel@laptopd505.fenrus.org>
 <1140713001.4672.73.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>
 <200602231820.50384.ak@suse.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Feb 2006, Andi Kleen wrote:
>
> I was to suggest the same thing originally, but on several boxes I checked
> there weren't any special MTRRs < 1MB, only in the PCI memory hole
> <4GB. I suspect there isn't just any interesting hardware in 640K anymore.

I wasn't talking about the regular MTRR's, but about the magic one: the 
"Fixed Range MTRRs" that only map the low 1MB.

I'm pretty sure that they are still used by the BIOS to set up the 
640k->1M window.

		Linus
