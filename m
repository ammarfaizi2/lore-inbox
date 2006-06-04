Return-Path: <linux-kernel-owner+akpm=40zip.com.au-S932264AbWFDVlE@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932264AbWFDVlE (ORCPT <rfc822;akpm@zip.com.au>);
	Sun, 4 Jun 2006 17:41:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932263AbWFDVlE
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 4 Jun 2006 17:41:04 -0400
Received: from pasmtp.tele.dk ([193.162.159.95]:49162 "EHLO pasmtp.tele.dk")
	by vger.kernel.org with ESMTP id S932264AbWFDVlD (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 4 Jun 2006 17:41:03 -0400
Date: Sun, 4 Jun 2006 23:41:02 +0200
From: Sam Ravnborg <sam@ravnborg.org>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: kbuild, kconfig and hrdinstall stuff
Message-ID: <20060604214102.GA18392@mars.ravnborg.org>
References: <20060604135011.decdc7c9.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060604135011.decdc7c9.akpm@osdl.org>
User-Agent: Mutt/1.5.11
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> git-hdrcleanup.patch
> git-hdrinstall.patch
> 
>  This is Dave Woodhouse's work cleaning up the kernel headers and adding a
>  `make headerinstall' target which automates the exporting of kernel
>  headers as a userspace-usable package.
> 
>  All I can say about this is that it doesn't appear to break anything and
>  is ready to merge from that point of view.  It's not an area in which I
>  have much interest or knowledge.

Dave Woodhouse asked me to review the hdrinstall part and I will do so.
At first glance only a fiw tid-bits needs fixing and then I like to
include unifdef in the kernel. It is rather unusual to have installed
(gentoo at least does not have it in Portage).

I just lacks a bit of time. Work and my newcomer (2 months old now)
takes a bit of time at the moment.

I you do not beat me hdrinstall will be part of kbuild-tree soon,
whereas the hrdcleanup part will not.

Following will be in kbuild-tree soon too.
> add-dependency-on-kernelrelease-to-the-package-targets.patch
> kconfig-improve-config-load-save-output.patch
> kconfig-fix-config-dependencies.patch
> kconfig-remove-symbol_yesmodno.patch
> kconfig-allow-multiple-default-values-per-symbol.patch
> kconfig-allow-loading-multiple-configurations.patch
> kconfig-integrate-split-config-into-silentoldconfig.patch
> kconfig-integrate-split-config-into-silentoldconfig-fix.patch
> kconfig-move-kernelrelease.patch
> kconfig-add-symbol-option-config-syntax.patch
> kconfig-add-defconfig_list-module-option.patch
> kconfig-add-search-option-for-xconfig.patch
> kconfig-finer-customization-via-popup-menus.patch
> kconfig-create-links-in-info-window.patch
> kconfig-jump-to-linked-menu-prompt.patch
> kconfig-warn-about-leading-whitespace-for-menu-prompts.patch
> kconfig-remove-leading-whitespace-in-menu-prompts.patch
> config-exit-if-no-beginning-filename.patch
> make-kernelrelease-speedup.patch
> kconfig-kconfig_overwriteconfig.patch
Not this one >>> sane-menuconfig-colours.patch
Randy Dunlap has a patch so it is configurable - but I like it
selectable in menuconfig - something I have not yet done.

> kbuild-export-type-enhancement-to-modpostc.patch
> kbuild-export-type-enhancement-to-modpostc-fix.patch
> kbuild-prevent-building-modules-that-wont-load.patch
> kbuild-export-symbol-usage-report-generator.patch
> kbuild-obj-dirs-is-calculated-incorrectly-if-hostprogs-y-is-defined.patch
> fix-make-rpm-for-powerpc.patch
If review is good => kbuild-tree.

> powerpc-kbuild-warning-fix.patch
I need to check up on this.


> kernel-doc-drop-leading-space-in-sections.patch
> kernel-doc-script-cleanups.patch
I thought we had a kernel-doc maintainer these days?

	Sam
