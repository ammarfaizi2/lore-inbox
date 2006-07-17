Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751186AbWGQWn4@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751186AbWGQWn4 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 17 Jul 2006 18:43:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751221AbWGQWnz
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 17 Jul 2006 18:43:55 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:61204 "EHLO
	ug-out-1314.google.com") by vger.kernel.org with ESMTP
	id S1751186AbWGQWny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 17 Jul 2006 18:43:54 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=X9MmHt2ckbYXn5GkuJj2PeMvI57rngax5WbvKVCIK9/HlVPnOeGNYXeK5F1ce3pff2GKPiKACRbUwo3vzareotXaRViWycZcrM5KUnIQgId4xqrOPbent6fOrF8Uv9CeSghftiSJeSYU182yFNEc8DxbLgd7if+3pzdqKuRavPQ=
Message-ID: <bda6d13a0607171543s26efde85q160b6b0df35aca40@mail.gmail.com>
Date: Mon, 17 Jul 2006 15:43:53 -0700
From: "Joshua Hudson" <joshudson@gmail.com>
To: linux-kernel@vger.kernel.org
Subject: make headers_install
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Just installed a new box, stock kernel didn't come up right. Installed
linux-2.6.18-rc2 (had one hard time at that one as keyboard acted
strange and network didn't work).

The real fun is this: to begin kernel build, I had to restore
toolchain to working order like so:
# ln -s /usr/src/linux-2.6.18-rc2/include/linux /usr/include/linux
# ln -s /usr/src/linux-2.6.18-rc2/include/asm-i386 /usr/include/asm
# ln -s /usr/src/linux-2.6.18-rc2/include/asm-generic /usr/include/asm-generic

Now the fun part: if I recall, I do make headers_install to install
the kernel headers
in the right place. Doing this before running those fix lines doesn't
work because the
build environment is broken. Doing this after looks like it would
clobber the kernel headers.

Solution?
