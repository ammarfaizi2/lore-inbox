Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S319270AbSHNTST>; Wed, 14 Aug 2002 15:18:19 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S319271AbSHNTST>; Wed, 14 Aug 2002 15:18:19 -0400
Received: from phoenix.infradead.org ([195.224.96.167]:13586 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S319270AbSHNTSS>; Wed, 14 Aug 2002 15:18:18 -0400
Date: Wed, 14 Aug 2002 20:22:11 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Arnd Bergmann <arnd@bergmann-dalldorf.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: S390 vs S390x, was Re: [kbuild-devel] Re: [patch] kernel config 3/N - move sound into drivers/media
Message-ID: <20020814202211.A23853@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Arnd Bergmann <arnd@bergmann-dalldorf.de>,
	linux-kernel@vger.kernel.org
References: <20020814043558.GN761@cadcamlab.org> <200208141921.58931.arnd@bergmann-dalldorf.de> <20020814191615.A22462@infradead.org> <200208142318.13667.arnd@bergmann-dalldorf.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <200208142318.13667.arnd@bergmann-dalldorf.de>; from arnd@bergmann-dalldorf.de on Wed, Aug 14, 2002 at 11:18:13PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 14, 2002 at 11:18:13PM +0200, Arnd Bergmann wrote:
> Ok. So what happens there if a user space program e.g. does #include
> <asm/page.h>? Where does that go instead of /usr/include/asm/page.h?

First:  Userspace including asm/* headers is BROKEN.  But as we have lots
of broken userspace we still to have to support that for some time.  The
solution is to have a wrapper that includes either asm-<b> or asm-<a>
depending on some cpp symbol.  Look at redhat's old kernel rpms for an
example.

