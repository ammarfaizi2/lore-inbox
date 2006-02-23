Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932126AbWBWXUL@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932126AbWBWXUL (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 23 Feb 2006 18:20:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932125AbWBWXUL
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 23 Feb 2006 18:20:11 -0500
Received: from smtp.osdl.org ([65.172.181.4]:23009 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932124AbWBWXUJ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 23 Feb 2006 18:20:09 -0500
Date: Thu, 23 Feb 2006 15:19:54 -0800 (PST)
From: Linus Torvalds <torvalds@osdl.org>
To: Rene Herman <rene.herman@keyaccess.nl>
cc: Arjan van de Ven <arjan@linux.intel.com>, Andi Kleen <ak@suse.de>,
       linux-kernel@vger.kernel.org, akpm@osdl.org, mingo@elte.hu
Subject: Re: Patch to reorder functions in the vmlinux to a defined order
In-Reply-To: <43FE1764.6000300@keyaccess.nl>
Message-ID: <Pine.LNX.4.64.0602231517400.3771@g5.osdl.org>
References: <1140700758.4672.51.camel@laptopd505.fenrus.org> 
 <1140707358.4672.67.camel@laptopd505.fenrus.org>  <200602231700.36333.ak@suse.de>
 <1140713001.4672.73.camel@laptopd505.fenrus.org> <Pine.LNX.4.64.0602230902230.3771@g5.osdl.org>
 <43FE0B9A.40209@keyaccess.nl> <Pine.LNX.4.64.0602231133110.3771@g5.osdl.org>
 <43FE1764.6000300@keyaccess.nl>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Thu, 23 Feb 2006, Rene Herman wrote:
> 
> Okay. I suppose the only other option is to make "physical_start" a variable
> passed in by the bootloader so that it could make a runtime decision? Ie,
> place us at min(top_of_mem, 4G) if it cared to. I just grepped for
> PHYSICAL_START and this didn't look _too_ bad.

No can do. You'd have to make the kernel relocatable, and do load-time 
fixups. Very invasive.

It's certainly _possible_, but it's a whole new stage in the boot, one 
that we've never done before.

		Linus
