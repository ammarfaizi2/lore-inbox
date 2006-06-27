Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161325AbWF0VnK@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161325AbWF0VnK (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jun 2006 17:43:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161324AbWF0VnJ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jun 2006 17:43:09 -0400
Received: from pasmtpb.tele.dk ([80.160.77.98]:56993 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S1161325AbWF0VnI (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jun 2006 17:43:08 -0400
Date: Tue, 27 Jun 2006 23:43:06 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Jesse Brandeburg <jesse.brandeburg@gmail.com>
Cc: "Linux-Kernel," <linux-kernel@vger.kernel.org>
Subject: Re: git head x86_64 build breakage
Message-ID: <20060627214306.GB372@mars.ravnborg.org>
References: <4807377b0606271310h41134de8t8c5f60436d73a988@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4807377b0606271310h41134de8t8c5f60436d73a988@mail.gmail.com>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2006 at 01:10:02PM -0700, Jesse Brandeburg wrote:
> using a fresh pull of Linus' git, I can't build a kernel right now
> I get this:
> make O=../2.6.18.obj/ all -j5
>  GEN     /home/jbrandeb/2.6.18.obj/Makefile
> scripts/kconfig/conf -s arch/x86_64/Kconfig
> init/Kconfig:3: unknown option "option"
> make[3]: *** [silentoldconfig] Error 1
> make[2]: *** [silentoldconfig] Error 2
> make[1]: *** [include/config/auto.conf] Error 2
> make: *** [all] Error 2
> 
> reverting to the v2.6.17 init/Kconfig fixes it.
Look like you did not get kconfig rebuild.
Try to delete scripts/kconfig/* in your ../2.6.18.obj/ directory and let
me know if this fixes it.
It this is a proper fix I need to look into why kconfig binaries was not
rebuild.

	Sam
