Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267261AbSLROgR>; Wed, 18 Dec 2002 09:36:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267263AbSLROgR>; Wed, 18 Dec 2002 09:36:17 -0500
Received: from fmr01.intel.com ([192.55.52.18]:27079 "EHLO hermes.fm.intel.com")
	by vger.kernel.org with ESMTP id <S267261AbSLROgQ>;
	Wed, 18 Dec 2002 09:36:16 -0500
To: linux-kernel@vger.kernel.org
Subject: _mmx_memcpy and module symbol versioning in 2.4.x
From: Roman Belenov <rbelenov@yandex.ru>
Date: Wed, 18 Dec 2002 17:44:09 +0300
Message-ID: <uof7jqtdy.fsf@yandex.ru>
User-Agent: Gnus/5.090007 (Oort Gnus v0.07) Emacs/21.2
 (i386-msvc-nt5.1.2600)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

It seems that _mmx_memcpy is exported incorrectly in 2.4.x kernels if
module symbol versioning is turned on - modules that use it fail to
load and tell that the function is undefined; /proc/ksyms shows the
versioned name as _mmx_memcpy_R__ver__mmx_memcpy (so that
__ver__mmx_memcpy remains undefined during kernel compilation).

It seems that the problem appeared in 2.4.0 - 

http://search.luky.org/linux-kernel.2000/msg00208.html

I experience it on 2.4.19 . Problem appears when kernel is compiled
with CONFIG_MODVERSIONS=y and CONFIG_MK7=y

-- 
 							With regards, Roman.

