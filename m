Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932186AbVHHSm3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932186AbVHHSm3 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 8 Aug 2005 14:42:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932187AbVHHSm3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 8 Aug 2005 14:42:29 -0400
Received: from smtp.osdl.org ([65.172.181.4]:7837 "EHLO smtp.osdl.org")
	by vger.kernel.org with ESMTP id S932186AbVHHSm2 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 8 Aug 2005 14:42:28 -0400
Date: Mon, 8 Aug 2005 11:42:03 -0700 (PDT)
From: Linus Torvalds <torvalds@osdl.org>
To: Arnd Bergmann <arnd@arndb.de>
cc: Olof Johansson <olof@lixom.net>, Stelian Pop <stelian@popies.net>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Export handle_mm_fault to modules.
In-Reply-To: <200508081044.10875.arnd@arndb.de>
Message-ID: <Pine.LNX.4.58.0508081141210.3258@g5.osdl.org>
References: <1123278912.8224.2.camel@localhost.localdomain>
 <20050805232530.GA8791@austin.ibm.com> <Pine.LNX.4.58.0508051642360.3258@g5.osdl.org>
 <200508081044.10875.arnd@arndb.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 8 Aug 2005, Arnd Bergmann wrote:
> 
> We will need the same export on ppc64 for managing SPEs on the
> Cell processor. My current patch removes the export on ppc
> and adds a global (*_GPL) one. Should I rather have another
> architecture specific export in ppc64?

I don't see any reason not to make it global if there are two
architectures that need it. Especially as long as it's marked GPL-only so 
that people don't start misusing it.

		Linus
