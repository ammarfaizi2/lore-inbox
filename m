Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S270319AbTHQPjj (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 17 Aug 2003 11:39:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S270322AbTHQPjj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 17 Aug 2003 11:39:39 -0400
Received: from amsfep11-int.chello.nl ([213.46.243.20]:41279 "EHLO
	amsfep11-int.chello.nl") by vger.kernel.org with ESMTP
	id S270319AbTHQPjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 17 Aug 2003 11:39:37 -0400
Subject: 2.4.22-rc2 unresolved symbols in drm/sis.o when CONFIG_AGP=m
From: Filip Sneppe <filip.sneppe@yucom.be>
To: faith@valinux.com, dri-devel@lists.sourceforge.net
Cc: linux-kernel@vger.kernel.org
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-Mailer: Ximian Evolution 1.0.5 
Date: 17 Aug 2003 17:39:40 +0200
Message-Id: <1061134780.670.150.camel@exile>
Mime-Version: 1.0
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

I get this on Debian Sarge at the end of a "make modules_install":

depmod: *** Unresolved symbols in
/lib/modules/2.4.22-rc2/kernel/drivers/char/drm/sis.o
depmod:         sis_malloc_Ra3329ed5
depmod:         sis_free_Rced25333

with these .config options:

CONFIG_AGP=m
CONFIG_AGP_SIS=y
CONFIG_DRM_SIS=m
CONFIG_FB=y
# CONFIG_FB_SIS is not set

>From my testing with some .configs, the combination that triggers 
this problem is modular /dev/agpgart + CONFIG_DRM_SIS=m + framebuffer
support (makes no difference if CONFIG_FB_SIS or CONFIG_AGP_SIS are
selected here AFAIK)

Hope this helps someone...

Regards,
Filip

