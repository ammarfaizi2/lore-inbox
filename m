Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932747AbWEXNtO@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932747AbWEXNtO (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 24 May 2006 09:49:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932748AbWEXNtO
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 24 May 2006 09:49:14 -0400
Received: from [198.99.130.12] ([198.99.130.12]:36267 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932747AbWEXNtN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 24 May 2006 09:49:13 -0400
Date: Wed, 24 May 2006 09:49:20 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Miklos Szeredi <miklos@szeredi.hu>
Cc: hpa@zytor.com, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net, akpm@osdl.org
Subject: Re: UML boot failure with kinit
Message-ID: <20060524134920.GA3747@ccure.user-mode-linux.org>
References: <E1FipyN-0004Hz-00@dorka.pomaz.szeredi.hu>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1FipyN-0004Hz-00@dorka.pomaz.szeredi.hu>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 24, 2006 at 11:48:11AM +0200, Miklos Szeredi wrote:
> UML now compiles on 2.6.17-rc4-mm3, but it fails to boot:
> 
> [...]
> kinit: do_mounts
> kinit: name_to_dev_t(98:0) = dev(0,0)
> kinit: root_dev = dev(0,0)
> kinit: trying to mount /dev/root on /root with type ext3
> kinit: Cannot open root device dev(0,0)
> [...]
> 
> Adding 'root=ubda' to the command line cures it.

hpa fixed this yesterday.  Something in klibc didn't support decimal
mm:nn device specifications.

				Jeff
