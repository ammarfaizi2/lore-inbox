Return-Path: <linux-kernel-owner+willy=40w.ods.org-S265260AbUFMUEE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265260AbUFMUEE (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 13 Jun 2004 16:04:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265261AbUFMUED
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 13 Jun 2004 16:04:03 -0400
Received: from bristol.phunnypharm.org ([65.207.35.130]:16293 "EHLO
	bristol.phunnypharm.org") by vger.kernel.org with ESMTP
	id S265260AbUFMUEB convert rfc822-to-8bit (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 13 Jun 2004 16:04:01 -0400
Date: Sun, 13 Jun 2004 15:10:12 -0400
From: Ben Collins <bcollins@debian.org>
To: Simon Richard Grint <rgrint@compsoc.man.ac.uk>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Compile failure
Message-ID: <20040613191012.GE22588@phunnypharm.org>
References: <20040613171035.GA455@srg.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: 8BIT
In-Reply-To: <20040613171035.GA455@srg.demon.co.uk>
User-Agent: Mutt/1.5.6i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 13, 2004 at 06:10:35PM +0100, Simon Richard Grint wrote:
> Dear all
> 
> I have just downloaded the most recent bk snapshot of 2.6.7rc3 and
> it fails to compile, instead producing the error:
>   UPD     include/linux/compile.h
>   CC      init/version.o
>   LD      init/built-in.o
>   LD      .tmp_vmlinux1
> drivers/built-in.o(.text+0xa5c72): In function ci_initialize':
> : undefined reference to PSB_WARNING'
> make: *** [.tmp_vmlinux1] Error 1
> 
> The linking error seems to stem from a newly implemented
> packet size check in the ohci_initialize function of 
> drivers/ieee1394/ohci1394.c not having defined HPSB_WARNING
> before use.

Fixed. bk pull request sent to Linus/Andrew already.

-- 
Debian     - http://www.debian.org/
Linux 1394 - http://www.linux1394.org/
Subversion - http://subversion.tigris.org/
WatchGuard - http://www.watchguard.com/
