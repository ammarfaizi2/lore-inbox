Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750730AbVLTBsV@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750730AbVLTBsV (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 19 Dec 2005 20:48:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750731AbVLTBsV
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 19 Dec 2005 20:48:21 -0500
Received: from ishtar.tlinx.org ([64.81.245.74]:5308 "EHLO ishtar.tlinx.org")
	by vger.kernel.org with ESMTP id S1750730AbVLTBsU (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 19 Dec 2005 20:48:20 -0500
Message-ID: <43A762E0.5020608@tlinx.org>
Date: Mon, 19 Dec 2005 17:48:16 -0800
From: Linda Walsh <lkml@tlinx.org>
User-Agent: Mozilla Thunderbird 1.0.7 (Windows/20050923)
X-Accept-Language: en, en_US
MIME-Version: 1.0
To: Jan-Benedict Glaw <jbglaw@lug-owl.de>
CC: Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: Makefile targets: tar & rpm pkgs, while using O=<dir> as non-root
References: <43A5F058.1060102@tlinx.org> <20051219071959.GJ13985@lug-owl.de> <43A7304B.2070103@tlinx.org> <20051219223030.GM13985@lug-owl.de>
In-Reply-To: <20051219223030.GM13985@lug-owl.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Jan-Benedict Glaw wrote:

>That's how it is ment to be. Actually, for in-tree builds, you get the
>tarball without first becoming root.
>
---
    So I see.  Slight minor possible "nit".
I have a suffix (CONFIG_LOCALVERSION) set.
While the tar picks up the /lib/modules files in <ver>-suffix, the
map and vm files all have suffixes w/o the "localversion" appended.
This doesn't seem desirable, eh?:

ishtar:/usr/src/ast-26144> tar tf linux-2.6.14.4.tar |more   
./
./boot/
./boot/System.map-2.6.14.4
./boot/config-2.6.14.4
./boot/vmlinux-2.6.14.4
./boot/vmlinuz-2.6.14.4
./lib/
./lib/modules/
./lib/modules/2.6.14.4-ast/
./lib/modules/2.6.14.4-ast/kernel/
./lib/modules/2.6.14.4-ast/kernel/crypto/
....

> I'll fix that soon, as I find
>some spare minute to hack it :)
>
---
S'okey...I can at least use the above to xfer files over for now...

tnx,
Linda
