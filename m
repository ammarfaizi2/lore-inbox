Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263144AbUKTE4x@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263144AbUKTE4x (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 19 Nov 2004 23:56:53 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263146AbUKTE4H
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 19 Nov 2004 23:56:07 -0500
Received: from viper.oldcity.dca.net ([216.158.38.4]:55445 "HELO
	viper.oldcity.dca.net") by vger.kernel.org with SMTP
	id S263144AbUKTEvu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 19 Nov 2004 23:51:50 -0500
Subject: Re: 2.6.10-rc2-mm2
From: Lee Revell <rlrevell@joe-job.com>
To: Andrew Morton <akpm@osdl.org>
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <20041118021538.5764d58c.akpm@osdl.org>
References: <20041118021538.5764d58c.akpm@osdl.org>
Content-Type: text/plain
Date: Fri, 19 Nov 2004 21:40:13 -0500
Message-Id: <1100918414.26068.12.camel@krustophenia.net>
Mime-Version: 1.0
X-Mailer: Evolution 2.0.2 
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2004-11-18 at 02:15 -0800, Andrew Morton wrote:
> ftp://ftp.kernel.org/pub/linux/kernel/people/akpm/patches/2.6/2.6.10-rc2/2.6.10-rc2-mm2/

New warnings:

In file included from sound/oss/emu10k1/hwaccess.h:38,
                 from sound/oss/emu10k1/recmgr.h:35,
                 from sound/oss/emu10k1/recmgr.c:34:
include/linux/ac97_codec.h:337: warning: `struct pci_dev' declared inside parameter list
include/linux/ac97_codec.h:337: warning: its scope is only this definition or declaration, which is probably not what you want

Looks like the OSS AC97 quirk facility is to blame, here is line 337:

extern int ac97_tune_hardware(struct pci_dev *pdev, struct ac97_quirk *quirk, int override);

Lee








