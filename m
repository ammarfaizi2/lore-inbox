Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264396AbUJRIDa@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264396AbUJRIDa (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 04:03:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264503AbUJRIDa
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 04:03:30 -0400
Received: from cantor.suse.de ([195.135.220.2]:35019 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S264396AbUJRID0 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 04:03:26 -0400
Date: Mon, 18 Oct 2004 09:54:33 +0200
From: Olaf Hering <olh@suse.de>
To: Paul Mackerras <paulus@samba.org>
Cc: linuxppc64-dev@ozlabs.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow kernel compile with native ppc64 compiler
Message-ID: <20041018075433.GA24927@suse.de>
References: <20041017185557.GA9619@suse.de> <16754.59442.992185.715900@cargo.ozlabs.ibm.com> <20041018045603.GA8500@suse.de> <16755.23272.754150.209624@cargo.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <16755.23272.754150.209624@cargo.ozlabs.ibm.com>
X-DOS: I got your 640K Real Mode Right Here Buddy!
X-Homeland-Security: You are not supposed to read this line! You are a terrorist!
User-Agent: Mutt und vi sind doch schneller als Notes (und GroupWise)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

 On Mon, Oct 18, Paul Mackerras wrote:

> Olaf Hering writes:
> 
> > > ... and breaks the compile on older toolchains that don't understand
> > > -m32.  We need to make the -m32 conditional on HAS_BIARCH as defined
> > > in arch/ppc64/Makefile.
> > 
> > how old?
> 
> The gcc that comes with debian sid doesn't understand -m32.  That's a
> 32-bit gcc, which means that I set CROSS_COMPILE when doing a ppc64
> kernel compile.  With your patch I have to set CROSS32_COMPILE as
> well, which seems silly when I'm compiling on a ppc32 box already.

Makes sense, I confused a native powerpc64-linux gcc from last century
with a native/cross powerpc-linux gcc from last century.

> Ben H suggested making the default BOOTCC be $(CC) -m32, which makes
> sense to me.

That may break cross compile. I will provide a new patch.

-- 
USB is for mice, FireWire is for men!

sUse lINUX ag, nÜRNBERG
