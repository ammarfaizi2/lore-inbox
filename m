Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261551AbVBWUSX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261551AbVBWUSX (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 23 Feb 2005 15:18:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261558AbVBWUSX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 23 Feb 2005 15:18:23 -0500
Received: from fire.osdl.org ([65.172.181.4]:36502 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S261551AbVBWUSS (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 23 Feb 2005 15:18:18 -0500
Date: Wed, 23 Feb 2005 12:17:59 -0800
From: Andrew Morton <akpm@osdl.org>
To: Steven Cole <elenstev@mesatop.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.11-rc4-mm1 (VFS: Cannot open root device "301")
Message-Id: <20050223121759.5cb270ee.akpm@osdl.org>
In-Reply-To: <421CB161.7060900@mesatop.com>
References: <20050223014233.6710fd73.akpm@osdl.org>
	<421CB161.7060900@mesatop.com>
X-Mailer: Sylpheed version 0.9.7 (GTK+ 1.2.10; i386-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Steven Cole <elenstev@mesatop.com> wrote:
>
>  Andrew Morton wrote:
>  > ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.11-rc4/2.6.11-rc4-mm1/
>  > 
>  > 
>  > - Various fixes and updates all over the place.  Things seem to have slowed
>  >   down a bit.
>  > 
> 
>  I am having trouble getting recent -mm kernels to boot on my test box.
>  For 2.6.11-rc3-mm2 and 2.6.11-rc4-mm1 I get the following:
> 
>  VFS: Cannot open root device "301" or unknown-block(3,1)
>  Please append a correct "root=" boot option
>  Kernel panic - not syncing: VFS: Unable to mount root fs on unknown-block(3,1)
> 
>  2.6.11-rc2-mm1 boots fine, and so do plain -rc3 and -rc4.
> 
>  I copied a working .config from an earlier kernel(-rc3), and ran make oldconfig,
>  answering most of the new questions 'n'.
> 
>  I did try appending root=0301 (which worked last year after similar symptoms,
>  but that didn't help this time).
> 
>  The root fs is ext3, which is compiled in.
> ...
>  CONFIG_BASE_SMALL=1

Please set CONFIG_BASE_FULL=y.  Check that this causes CONFIG_BASE_SMALL=0,
then retest.

