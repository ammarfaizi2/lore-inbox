Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263986AbTDNV5Y (for <rfc822;willy@w.ods.org>); Mon, 14 Apr 2003 17:57:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263996AbTDNV5Y (for <rfc822;linux-kernel-outgoing>);
	Mon, 14 Apr 2003 17:57:24 -0400
Received: from neon-gw-l3.transmeta.com ([63.209.4.196]:50443 "EHLO
	neon-gw.transmeta.com") by vger.kernel.org with ESMTP
	id S263986AbTDNV5U (for <rfc822;linux-kernel@vger.kernel.org>); Mon, 14 Apr 2003 17:57:20 -0400
To: linux-kernel@vger.kernel.org
From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Re: Memory mapped files question
Date: 14 Apr 2003 15:08:48 -0700
Organization: Transmeta Corporation, Santa Clara CA
Message-ID: <b7fbhg$sq4$1@cesium.transmeta.com>
References: <A46BBDB345A7D5118EC90002A5072C780BEBAD8D@orsmsx116.jf.intel.com> <004301c302bd$ed548680$fe64a8c0@webserver>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Disclaimer: Not speaking for Transmeta in any way, shape, or form.
Copyright: Copyright 2003 H. Peter Anvin - All Rights Reserved
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Followup to:  <004301c302bd$ed548680$fe64a8c0@webserver>
By author:    "Bryan Shumsky" <bzs@via.com>
In newsgroup: linux.dev.kernel
>
> Hi, everyone.  Thanks for all your responses.  Our confusion is that in Unix
> environments, when we modify memory in memory-mapped files the underlying
> system flusher manages to flush the files for us before the files are
> munmap'ed or msysnc'ed.
> 

Bullshit.  It might work on one particular Unix implementation, but
the definition of Unix, the Single Unix Standard, does explicitly
*not* require this behavior.

> Rewriting all of our code to manually handle the flushing is a MAJOR
> undertaking, so I was hoping there might be some sneaky solution you could
> come up with.  Any ideas?

Your code is fundamentally broken.  You need to fix it.

	-hpa

-- 
<hpa@transmeta.com> at work, <hpa@zytor.com> in private!
"Unix gives you enough rope to shoot yourself in the foot."
Architectures needed: ia64 m68k mips64 ppc ppc64 s390 s390x sh v850 x86-64
