Return-Path: <linux-kernel-owner+willy=40w.ods.org-S266319AbUJRF4J@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266319AbUJRF4J (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 01:56:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266512AbUJRF4J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 01:56:09 -0400
Received: from ozlabs.org ([203.10.76.45]:17626 "EHLO ozlabs.org")
	by vger.kernel.org with ESMTP id S266319AbUJRF4G (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 01:56:06 -0400
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Message-ID: <16755.23272.754150.209624@cargo.ozlabs.ibm.com>
Date: Mon, 18 Oct 2004 15:55:52 +1000
From: Paul Mackerras <paulus@samba.org>
To: Olaf Hering <olh@suse.de>
Cc: linuxppc64-dev@ozlabs.org, Andrew Morton <akpm@osdl.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] allow kernel compile with native ppc64 compiler
In-Reply-To: <20041018045603.GA8500@suse.de>
References: <20041017185557.GA9619@suse.de>
	<16754.59442.992185.715900@cargo.ozlabs.ibm.com>
	<20041018045603.GA8500@suse.de>
X-Mailer: VM 7.18 under Emacs 21.3.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Olaf Hering writes:

> > ... and breaks the compile on older toolchains that don't understand
> > -m32.  We need to make the -m32 conditional on HAS_BIARCH as defined
> > in arch/ppc64/Makefile.
> 
> how old?

The gcc that comes with debian sid doesn't understand -m32.  That's a
32-bit gcc, which means that I set CROSS_COMPILE when doing a ppc64
kernel compile.  With your patch I have to set CROSS32_COMPILE as
well, which seems silly when I'm compiling on a ppc32 box already.

Ben H suggested making the default BOOTCC be $(CC) -m32, which makes
sense to me.

Paul.
