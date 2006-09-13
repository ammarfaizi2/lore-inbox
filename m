Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750713AbWIMQbj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750713AbWIMQbj (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 13 Sep 2006 12:31:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750719AbWIMQbj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 13 Sep 2006 12:31:39 -0400
Received: from palinux.external.hp.com ([192.25.206.14]:43905 "EHLO
	mail.parisc-linux.org") by vger.kernel.org with ESMTP
	id S1750713AbWIMQbi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 13 Sep 2006 12:31:38 -0400
Date: Wed, 13 Sep 2006 10:31:36 -0600
From: Matthew Wilcox <matthew@wil.cx>
To: Adrian Bunk <bunk@stusta.de>
Cc: David Howells <dhowells@redhat.com>, torvalds@osdl.org, akpm@osdl.org,
       linux-kernel@vger.kernel.org, linux-arch@vger.kernel.org
Subject: Re: [PATCH 4/6] Implement a general log2 facility in the kernel
Message-ID: <20060913163136.GA2585@parisc-linux.org>
References: <20060913130253.32022.69230.stgit@warthog.cambridge.redhat.com> <20060913130300.32022.69743.stgit@warthog.cambridge.redhat.com> <20060913161734.GE3564@stusta.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060913161734.GE3564@stusta.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 13, 2006 at 06:17:34PM +0200, Adrian Bunk wrote:
> On Wed, Sep 13, 2006 at 02:03:00PM +0100, David Howells wrote:
> > From: David Howells <dhowells@redhat.com>
> > 
> > This facility provides three entry points:
> > 
> > 	log2()		Log base 2 of u32
> >...
> 
> Considering that several arch maintainers have vetoed my patch to revert 
> the -ffreestanding removal Andi sneaked in with his usual trick to hide 
> generic patches as "x86_64 patch", such a usage of a libc function name 
> with a signature different from the one defined in ISO/IEC 9899:1999 is 
> a namespace violation that mustn't happen.

log2 is only defined if math.h gets included.  If we're including math.h
at any point in the kernel itself (excluding the bootloader and similar),
we're already screwed six ways from sunday.
