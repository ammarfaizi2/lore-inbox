Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262862AbVA2Fsb@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262862AbVA2Fsb (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 29 Jan 2005 00:48:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262861AbVA2Fsb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 29 Jan 2005 00:48:31 -0500
Received: from parcelfarce.linux.theplanet.co.uk ([195.92.249.252]:46541 "EHLO
	parcelfarce.linux.theplanet.co.uk") by vger.kernel.org with ESMTP
	id S262862AbVA2Fro (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 29 Jan 2005 00:47:44 -0500
Date: Sat, 29 Jan 2005 05:47:42 +0000
From: Al Viro <viro@parcelfarce.linux.theplanet.co.uk>
To: Christopher Li <chrisl@vmware.com>
Cc: Gianni Tedesco <gianni@scaramanga.co.uk>,
       linux kernel mail list <linux-kernel@vger.kernel.org>
Subject: Re: compat ioctl for submiting URB
Message-ID: <20050129054742.GT8859@parcelfarce.linux.theplanet.co.uk>
References: <20050128212304.GA11024@64m.dyndns.org> <1106972991.3972.57.camel@sherbert> <20050129013305.GA7792@64m.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20050129013305.GA7792@64m.dyndns.org>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2005 at 08:33:05PM -0500, Christopher Li wrote:
> This patch is for the case that running 32 bit application on
> a 64 bit kernel. So far only x86_64 allow you to do that.
> 
> I am not aware of other 64bit architecture need the 32bit
> emulation.

Huh???
	a) ppc64 runs ppc32 userland
	b) sparc64 runs sparc32 userland (as the matter of fact, very
few userland programs are normally built 64bit there - no benefits in
doing that for most applications, it only bloats the memory footprint)
	c) mips64 runs mips32 userland
	d) itanic, IIRC, runs i386 userland
	e) s390x runs s390 userland
	f) parisc64 runs parisc32 userland

It's normal situation, not an exception.  The only pair I'm not sure about
is sh64/sh.  AFAICS, the only other supported 64bit platform without 32bit
emulation is alpha - and in that case there's no corresponding 32bit
processor to emulate.
