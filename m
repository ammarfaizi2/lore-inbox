Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264226AbUFNUuk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264226AbUFNUuk (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 14 Jun 2004 16:50:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264236AbUFNUuk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 14 Jun 2004 16:50:40 -0400
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59405 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S264226AbUFNUui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 14 Jun 2004 16:50:38 -0400
Date: Mon, 14 Jun 2004 21:50:34 +0100
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Andrew Morton <akpm@osdl.org>, linux-kernel@vger.kernel.org,
       Linus Torvalds <torvalds@osdl.org>
Subject: Re: [PATCH 4/5] kbuild: make clean improved
Message-ID: <20040614215034.K14403@flint.arm.linux.org.uk>
Mail-Followup-To: Andrew Morton <akpm@osdl.org>,
	linux-kernel@vger.kernel.org, Linus Torvalds <torvalds@osdl.org>
References: <20040614204029.GA15243@mars.ravnborg.org> <20040614204655.GE15243@mars.ravnborg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20040614204655.GE15243@mars.ravnborg.org>; from sam@ravnborg.org on Mon, Jun 14, 2004 at 10:46:55PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 14, 2004 at 10:46:55PM +0200, Sam Ravnborg wrote:
>  # Directories & files removed with 'make clean'
>  CLEAN_DIRS  += $(MODVERDIR)
> -CLEAN_FILES +=	vmlinux System.map \
> +CLEAN_FILES +=	vmlinux System.map .version .config.old \
>                  .tmp_kallsyms* .tmp_version .tmp_vmlinux*

Why should 'make clean' remove the build version?  Traditionally,
this has been preserved until 'make mrproper'.

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 PCMCIA      - http://pcmcia.arm.linux.org.uk/
                 2.6 Serial core
