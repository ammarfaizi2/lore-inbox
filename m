Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261403AbVARTfs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261403AbVARTfs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 18 Jan 2005 14:35:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261405AbVARTfs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 18 Jan 2005 14:35:48 -0500
Received: from news.suse.de ([195.135.220.2]:57994 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S261403AbVARTfe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 18 Jan 2005 14:35:34 -0500
Message-Id: <20050118184123.729034000.suse.de>
Date: Tue, 18 Jan 2005 19:41:23 +0100
From: Andreas Gruenbacher <agruen@suse.de>
To: linux-kernel@vger.kernel.org, Sam Ravnborg <sam@ravnborg.org>
Cc: Rusty Russell <rusty@rustcorp.com.au>
Subject: [kbuild 0/5] Some of our patches
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

here are some of our current patches that I consider appropriate for
mainline:

patches/check-symvers.diff
  Warn when building external modules without modversions

  Users often try to build additional external modules without compiling
  the whole kernel first, and without the Module.synvers dump file.
  This results in modules without modversions, which can be dangerous.

patches/default-configuration.diff
  Don't use the running kernel's config file by default

  Targets such as menuconfig fetch their default configuration from the
  running kernel if .config doesn't exist. This often is the wrong
  thing. Don't look at the running kernel for the usual configure
  commands. Instead, add a new cloneconfig target (see next patch).

patches/cloneconfig.diff
  Add cloneconfig target

  This fetches the configuration from the running kernel, and configures
  the kernel source tree based on that.

patches/mod_param-typeinfo.diff
  Include type information as module info where possible

  This patch was on the LKML before; it should have been merged but got
  lost.
  
patches/remove-buildenv-paths-from-binaries.diff
  Don't include absolute filenames in binaries

  When building RPMs, we don't want build environment specific path names
  to appear in binaries.

Regards,
--
Andreas Gruenbacher <agruen@suse.de>
SUSE Labs, SUSE LINUX PRODUCTS GMBH

