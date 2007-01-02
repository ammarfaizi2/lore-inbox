Return-Path: <linux-kernel-owner+w=401wt.eu-S1754911AbXABVod@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754911AbXABVod (ORCPT <rfc822;w@1wt.eu>);
	Tue, 2 Jan 2007 16:44:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754908AbXABVod
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 2 Jan 2007 16:44:33 -0500
Received: from palinux.external.hp.com ([192.25.206.14]:40280 "EHLO
	mail.parisc-linux.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754893AbXABVod (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 2 Jan 2007 16:44:33 -0500
Date: Tue, 2 Jan 2007 14:44:31 -0700
From: Matthew Wilcox <matthew@wil.cx>
To: Helge Deller <deller@gmx.de>
Cc: linux-kernel@vger.kernel.org, parisc-linux@lists.parisc-linux.org
Subject: Re: [parisc-linux] [RFC][PATCH] use cycle_t instead of u64 in struct time_interpolator
Message-ID: <20070102214431.GA7317@parisc-linux.org>
References: <200701022233.25697.deller@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <200701022233.25697.deller@gmx.de>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 02, 2007 at 10:33:25PM +0100, Helge Deller wrote:
> Ok, not Ok ?

Um, this is still doing cmpxchg() with insufficient locking.  So, not
OK.
