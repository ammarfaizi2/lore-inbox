Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262758AbUKRMnA@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262758AbUKRMnA (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 18 Nov 2004 07:43:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262761AbUKRMm7
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 18 Nov 2004 07:42:59 -0500
Received: from holomorphy.com ([207.189.100.168]:15744 "EHLO holomorphy.com")
	by vger.kernel.org with ESMTP id S262758AbUKRMmY (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 18 Nov 2004 07:42:24 -0500
Date: Thu, 18 Nov 2004 04:42:20 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.6.10-rc2-mm2
Message-ID: <20041118124220.GB2268@holomorphy.com>
References: <20041118021538.5764d58c.akpm@osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041118021538.5764d58c.akpm@osdl.org>
Organization: The Domain of Holomorphy
User-Agent: Mutt/1.5.6+20040722i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 18, 2004 at 02:15:38AM -0800, Andrew Morton wrote:
> +oss-ac97-quirk-facility.patch
>  Add and use device quirk lists in this OSS driver

That patch may not actually be responsible for the warning. It's
trivially resolved regardless.

This patch adds a forward declaration of struct pci_dev to repair the
following warning:

In file included from sound/oss/emu10k1/hwaccess.h:38,
                 from sound/oss/emu10k1/cardmi.c:36:
include/linux/ac97_codec.h:337: warning: `struct pci_dev' declared inside parameter list
include/linux/ac97_codec.h:337: warning: its scope is only this definition or declaration, which is probably not what you want

Index: mm2-2.6.10-rc2/include/linux/ac97_codec.h
===================================================================
--- mm2-2.6.10-rc2.orig/include/linux/ac97_codec.h	2004-11-18 02:56:31.000000000 -0800
+++ mm2-2.6.10-rc2/include/linux/ac97_codec.h	2004-11-18 03:53:05.308878784 -0800
@@ -334,6 +334,7 @@
 	int type;               /* quirk type above */
 };
 
+struct pci_dev;
 extern int ac97_tune_hardware(struct pci_dev *pdev, struct ac97_quirk *quirk, int override);
 
 #endif /* _AC97_CODEC_H_ */
