Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267976AbUHPWSR@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267976AbUHPWSR (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Aug 2004 18:18:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267978AbUHPWSR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Aug 2004 18:18:17 -0400
Received: from [66.199.228.3] ([66.199.228.3]:38148 "EHLO xdr.com")
	by vger.kernel.org with ESMTP id S267976AbUHPWSQ (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Aug 2004 18:18:16 -0400
Date: Mon, 16 Aug 2004 15:18:15 -0700
From: David Ashley <dash@xdr.com>
Message-Id: <200408162218.i7GMIF9I024784@xdr.com>
To: linux-kernel@vger.kernel.org
Subject: Re: Possible 2.4.18 ipv4 memory leak? [SOLVED!]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Tim Schmielau wrote:
>There seem to be quite a few fixes for memory leaks since 2.4.18,
>some network/ethernet related:

>http://linux.bkbits.net:8080/linux-2.4/search/?expr=leak&search=ChangeSet+comments


I followed that link and the second and third lines seemed *very* interesting.
I looked at that patch:
http://linux.bkbits.net:8080/linux-2.4/patch@1.1447.1.19

and back ported it to our 2.4.18 tree (very easy) and that fixed the
problem.

The file was in arch/ppc/8260_io/fcc_enet.c, however the 8260_io directory
became cpm2_io in later versions.

Thanks very much, Tim!

-Dave

