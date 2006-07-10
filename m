Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932405AbWGJJN6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932405AbWGJJN6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Jul 2006 05:13:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932398AbWGJJN6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Jul 2006 05:13:58 -0400
Received: from relay.2ka.mipt.ru ([194.85.82.65]:56449 "EHLO 2ka.mipt.ru")
	by vger.kernel.org with ESMTP id S932374AbWGJJN5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Jul 2006 05:13:57 -0400
Date: Mon, 10 Jul 2006 13:13:54 +0400
From: Evgeniy Polyakov <johnpol@2ka.mipt.ru>
To: linux-kernel@vger.kernel.org
Cc: linux-crypto@vger.kernel.org
Subject: [ACRYPTO] new release of asynchronous crrypto layer.
Message-ID: <20060710091353.GA19863@2ka.mipt.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset=koi8-r
Content-Disposition: inline
User-Agent: Mutt/1.5.9i
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-1.7.5 (2ka.mipt.ru [0.0.0.0]); Mon, 10 Jul 2006 13:13:54 +0400 (MSD)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

I'm pleased to announce new release of asynchronous crypto layer ACRYPTO
[1]. Acrypto allows to handle crypto requests asynchronously in
hardware.

This release has following major features:
 * OCF [2] to acrypto bridge. Work by Yakov Lerner <iler.ml@gmail.com>
   This module allows to use ixp4xx driver with acrypto IPsec and
   dm-crypt.
 * major name refactoring
 * crypto context abstractions (allows to notify hardware when keys 
   and/or some other crypto parameters are changed)
 * bugfixes and small feature extensions

With this release I decide to drop support for old tarball acrypto
releases. All new features and bugfixes will go directly into combined
patchsets against supported trees (currently 2.6.16 and 2.6.17, 2.6.15
is unsupported anymore). Releases with major changes will be announced
in linux-kernel@ and linux-crypto@ mail lists.

Combined patchsets include:
 * acrypto core
 * IPsec ESP4 port to acrypto
 * dm-crypt port to acrypto
 * OCF to acrypto bridge

Acrypto supports following crypto providers:
 * SW crypto provider
 * HIFN 795x adapters
 * VIA nehemiah CPU
 * SuperCrypt CE99C003B
 * devices supported by OCF (only IXP4xx was tested)

1. Acrypto homepage.
http://tservice.net.ru/~s0mbre/old/?section=projects&item=acrypto

2. OCF homepage.
http://ocf-linux.sourceforge.net

3. Acrypto archive with combined patchsets.
http://tservice.net.ru/~s0mbre/archive/acrypto/patchsets/

4. Acrypto archive with device drivers.
http://tservice.net.ru/~s0mbre/archive/acrypto/drivers/

Thank you.

-- 
	Evgeniy Polyakov
