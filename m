Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262421AbVAVCDq@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262421AbVAVCDq (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 21 Jan 2005 21:03:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262436AbVAVCDq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 21 Jan 2005 21:03:46 -0500
Received: from ns.suse.de ([195.135.220.2]:57323 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S262421AbVAVCDp (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 21 Jan 2005 21:03:45 -0500
Date: Sat, 22 Jan 2005 03:03:35 +0100
From: Andi Kleen <ak@suse.de>
To: "Rafael J. Wysocki" <rjw@sisk.pl>
Cc: Pavel Machek <pavel@suse.cz>, Andi Kleen <ak@suse.de>,
       Andrew Morton <akpm@osdl.org>, hugang@soulinfo.com,
       LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH][RFC] swsusp: speed up image restoring on x86-64
Message-ID: <20050122020335.GB27060@wotan.suse.de>
References: <200501202032.31481.rjw@sisk.pl> <20050120205950.GF468@openzaurus.ucw.cz> <200501202246.38506.rjw@sisk.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200501202246.38506.rjw@sisk.pl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With this patch, at least 8 times less memory accesses are required to restore an image
> than without it, and in the original code cr3 is reloaded after copying each _byte_,
> let alone the SIB arithmetics.  I'd expect it to be 10 times faster or so.

Probably more. CR3 reload is a serializing operation and is really expensive.

-Andi
