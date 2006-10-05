Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932228AbWJEVjm@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932228AbWJEVjm (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Oct 2006 17:39:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932243AbWJEVjm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Oct 2006 17:39:42 -0400
Received: from [198.99.130.12] ([198.99.130.12]:45747 "EHLO
	saraswathi.solana.com") by vger.kernel.org with ESMTP
	id S932228AbWJEVjl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Oct 2006 17:39:41 -0400
Date: Thu, 5 Oct 2006 17:37:54 -0400
From: Jeff Dike <jdike@addtoit.com>
To: "Paolo 'Blaisorblade' Giarrusso" <blaisorblade@yahoo.it>
Cc: stable@kernel.org, linux-kernel@vger.kernel.org,
       user-mode-linux-devel@lists.sourceforge.net
Subject: Re: uml: use DEFCONFIG_LIST to avoid reading host's config
Message-ID: <20061005213754.GC6790@ccure.user-mode-linux.org>
References: <11600785071661-git-send-email-blaisorblade@yahoo.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <11600785071661-git-send-email-blaisorblade@yahoo.it>
User-Agent: Mutt/1.4.2.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 05, 2006 at 10:01:47PM +0200, Paolo 'Blaisorblade' Giarrusso wrote:
> From: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>
> 
> This should make sure that, for UML, host's configuration files are not
> considered, which avoids various pains to the user. Our dependency are such that
> the obtained Kconfig will be valid and will lead to successful compilation -
> however they cannot prevent an user from disabling any boot device, and if an
> option is not set in the read .config (say /boot/config-XXX), with make
> menuconfig ARCH=um, it is not set. This always disables UBD and all console I/O
> channels, which leads to non-working UML kernels, so this bothers users -
> especially now, since it will happen on almost every machine
> (/boot/config-`uname -r` exists almost on every machine). It can be workarounded
> with make defconfig ARCH=um, but it is non-obvious and can be avoided, so please
> _do_ merge this patch.
> 
> Signed-off-by: Paolo 'Blaisorblade' Giarrusso <blaisorblade@yahoo.it>

Acked-by: Jeff Dike <jdike@addtoit.com>

Paolo - send this to Andrew as well so it doesn't get lost.

				Jeff
