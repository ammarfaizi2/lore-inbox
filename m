Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262198AbTLIBDK (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Dec 2003 20:03:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262228AbTLIBDK
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Dec 2003 20:03:10 -0500
Received: from e33.co.us.ibm.com ([32.97.110.131]:25820 "EHLO
	e33.co.us.ibm.com") by vger.kernel.org with ESMTP id S262198AbTLIBDG
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Dec 2003 20:03:06 -0500
Date: Mon, 8 Dec 2003 17:02:55 -0800
From: Patrick Mansfield <patmans@us.ibm.com>
To: Lee <weifeil@usc.edu>
Cc: linux-kernel@vger.kernel.org
Subject: Re: PROBLEM: Use too large hard disk space when compiling the 2.6.0-testx
Message-ID: <20031208170255.A6425@beaverton.ibm.com>
References: <00a501c3bcfb$200b71e0$0300a8c0@tiger>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <00a501c3bcfb$200b71e0$0300a8c0@tiger>; from weifeil@usc.edu on Sun, Dec 07, 2003 at 11:48:44AM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 07, 2003 at 11:48:44AM -0800, Lee wrote:
> 1. Under kernel 2.6.0-testx,  the compiling process always uses huge disk
> space.

Do you have CONFIG_DEBUG_INFO enabled? Try turning it off.

I have not tried to compile with it on but there were other complaints
about larger *kernel* images, and the config help (arch/i386/Kconfig)
says:

config DEBUG_INFO
        bool "Compile the kernel with debug info"
        depends on DEBUG_KERNEL
        help
          If you say Y here the resulting kernel image will include
          debugging info resulting in a larger kernel image.
          Say Y here only if you plan to use gdb to debug the kernel.
          If you don't debug the kernel, you can say N.

-- Patrick Mansfield
