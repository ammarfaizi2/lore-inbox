Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932448AbWDGPGQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932448AbWDGPGQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 7 Apr 2006 11:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932449AbWDGPGQ
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 7 Apr 2006 11:06:16 -0400
Received: from zeus1.kernel.org ([204.152.191.4]:42218 "EHLO zeus1.kernel.org")
	by vger.kernel.org with ESMTP id S932448AbWDGPGQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 7 Apr 2006 11:06:16 -0400
X-AuthUser: hirofumi@parknet.jp
To: "Randy.Dunlap" <rdunlap@xenotime.net>
Cc: lkml <linux-kernel@vger.kernel.org>, zippel@linux-m68k.org
Subject: Re: [RFC/POC] multiple CONFIG y/m/n
References: <20060406224134.0430e827.rdunlap@xenotime.net>
From: OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
Date: Sat, 08 Apr 2006 00:04:26 +0900
In-Reply-To: <20060406224134.0430e827.rdunlap@xenotime.net> (Randy Dunlap's message of "Thu, 6 Apr 2006 22:41:34 -0700")
Message-ID: <87odzdh1fp.fsf@duaron.myhome.or.jp>
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"Randy.Dunlap" <rdunlap@xenotime.net> writes:

> As it is here, PARPORT_ENABLE_ALL tracks PARPORT (y/m/n) when the former
> is enabled/configured.  The downside of this Kconfig usage is that almost
> all lines of "depends" are duplicated as "select" (and that it uses "select").
> It would be good if there was some way to automate this.
>
> Comments?

Umm... Oh, how about the following?  It seems work...

	$ perl -spi -e 's/CONFIG_SND.*//' .config
        $ KCONFIG_ALLCONFIG=.config make allmodconfig or allyesconfig

Thanks.
-- 
OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>
