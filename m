Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S131665AbRDCLeF>; Tue, 3 Apr 2001 07:34:05 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S131564AbRDCLdz>; Tue, 3 Apr 2001 07:33:55 -0400
Received: from quechua.inka.de ([212.227.14.2]:21050 "EHLO mail.inka.de")
	by vger.kernel.org with ESMTP id <S131638AbRDCLdx>;
	Tue, 3 Apr 2001 07:33:53 -0400
To: linux-kernel@vger.kernel.org
Subject: Re: /proc/config idea
In-Reply-To: <3AC91E05.F11BFF43@mandrakesoft.com> <Pine.LNX.4.33.0104021951450.30568-100000@dlang.diginsite.com>
Organization: private Linux site, southern Germany
Date: Tue, 03 Apr 2001 13:18:29 +0200
From: Olaf Titz <olaf@bigred.inka.de>
Message-Id: <E14kOpX-00044o-00@g212.hadiko.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> a module for 2.4.3 will work for any 2.4.3 kernel that supports modules
> at all (except for the SMP vs UP issue) so it's not the same thing as

No, no, no. This is absolutely and dangerously wrong.

A module depends on the kernel configuration, because it may access
internal data structures of the kernel which change with
configuration. It also depends on the compiler version and exact
options used, because certain structures in the kernel are compiler
dependent. Loading a module which doesn't fit the running kernel
_exactly_ is the easiest way to get a hard kernel crash.

SMP is only a special case of this general problem. CONFIG_MODVERSIONS
is designed to take care of this dependency, and it really ought to be
non-optional.

Olaf
