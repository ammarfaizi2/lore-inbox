Return-Path: <linux-kernel-owner+willy=40w.ods.org-S264569AbUFXNUD@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264569AbUFXNUD (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Jun 2004 09:20:03 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264649AbUFXNUD
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Jun 2004 09:20:03 -0400
Received: from mailbox.surfeu.se ([213.173.154.11]:27807 "EHLO surfeu.fi")
	by vger.kernel.org with ESMTP id S264515AbUFXNTB (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Jun 2004 09:19:01 -0400
Message-ID: <40DAD511.A19CEFB7@users.sourceforge.net>
Date: Thu, 24 Jun 2004 16:20:17 +0300
From: Jari Ruusu <jariruusu@users.sourceforge.net>
X-Mailer: Mozilla 4.79 [en] (X11; U; Linux 2.4.22aa1r7 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Andrew Morton <akpm@osdl.org>
CC: linux-kernel@vger.kernel.org
Subject: Re: 2.6.7-mm2
References: <20040624014655.5d2a4bfb.akpm@osdl.org>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andrew Morton wrote:
> +kbuild-improve-kernel-build-with-separated-output.patch
> 
>  kbuild improvements for building in a separate object directory

This breaks existing recommended syntax for external modules, because the
mini Makefile in object directory always provides O= even in cases where
calling code specified its own object directory:

    make -C /lib/modules/`uname -r`/build modules M=`pwd` O=/foo

or

    export KBUILD_OUTPUT=/foo
    make -C /lib/modules/`uname -r`/build modules M=`pwd`

Andrew,
please drop this patch. Dropping this causes less breakage than applying it.

-- 
Jari Ruusu  1024R/3A220F51 5B 4B F9 BB D3 3F 52 E9  DB 1D EB E3 24 0E A9 DD
