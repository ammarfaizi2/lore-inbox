Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932648AbWF2VNj@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932648AbWF2VNj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 29 Jun 2006 17:13:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932652AbWF2VNi
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 29 Jun 2006 17:13:38 -0400
Received: from [198.99.130.12] ([198.99.130.12]:55775 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932648AbWF2VNh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 29 Jun 2006 17:13:37 -0400
Date: Thu, 29 Jun 2006 17:13:15 -0400
From: Jeff Dike <jdike@addtoit.com>
To: Roman Zippel <zippel@linux-m68k.org>
Cc: Andrew Morton <akpm@osdl.org>, Theodore Tso <tytso@mit.edu>,
       linux-kernel@vger.kernel.org
Subject: Re: 2.6.17-mm1: UML failing w/o SKAS enabled
Message-ID: <20060629211315.GD10711@ccure.user-mode-linux.org>
References: <20060621034857.35cfe36f.akpm@osdl.org> <20060622213443.GA22303@thunk.org> <20060622145743.2accfeaf.akpm@osdl.org> <20060623025418.GC8316@ccure.user-mode-linux.org> <Pine.LNX.4.64.0606231209000.17704@scrub.home> <20060623142829.GA4333@ccure.user-mode-linux.org> <Pine.LNX.4.64.0606261347370.12900@scrub.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0606261347370.12900@scrub.home>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 26, 2006 at 01:52:54PM +0200, Roman Zippel wrote:
> That would work too, but what I had in mind was to customize the entry in 
> init/Kconfig, e.g.
> 
> config DEFCONFIG_LIST
> 	string
> 	option defconfig_list
> 	default "/lib/modules/$UNAME_RELEASE/.config"
> 	default "/etc/kernel-config"
> 	default "/boot/config-$UNAME_RELEASE"
> 	depends on !UML
> 
> config DEFCONFIG_LIST
> 	default "arch/$ARCH/defconfig"
> 
> This way the last entry is always the same for all archs and the rest can 
> be customized.

Fine by me, are you going to send that in, or should I?

				Jeff
