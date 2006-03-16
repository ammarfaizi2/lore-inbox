Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1752291AbWCPLUv@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752291AbWCPLUv (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 16 Mar 2006 06:20:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752285AbWCPLUv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 16 Mar 2006 06:20:51 -0500
Received: from ftp.linux-mips.org ([194.74.144.162]:53223 "EHLO
	ftp.linux-mips.org") by vger.kernel.org with ESMTP id S1751087AbWCPLUu
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 16 Mar 2006 06:20:50 -0500
Date: Thu, 16 Mar 2006 11:20:45 +0000
From: Ralf Baechle <ralf@linux-mips.org>
To: Eugene Teo <eugene.teo@eugeneteo.net>
Cc: linux-kernel@vger.kernel.org,
       Thomas Osterried DL9SAU <thomas@x-berg.in-berlin.de>,
       Hans Alblas PE1AYX <hans@esrac.ele.tue.nl>
Subject: Re: [PATCH] Hamradio: Fix a NULL pointer dereference in net/hamradio/mkiss.c
Message-ID: <20060316112045.GA4067@linux-mips.org>
References: <20060316064211.GA22681@eugeneteo.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060316064211.GA22681@eugeneteo.net>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 16, 2006 at 02:42:11PM +0800, Eugene Teo wrote:

> Pointer ax is dereferenced before NULL check.
> 
> Coverity bug #817

Coverity non-bug #817.  The line discipline's ioctl method can only be
called as long as sp_get(tty) is valid.  Same for mkiss.

Unless I'm wrong on the "locking rules" of the tty code that is and maybe
that unobviousness is the real reason why the patch should be applied.

  Ralf
