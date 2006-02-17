Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964926AbWBQQMu@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964926AbWBQQMu (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 11:12:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964927AbWBQQMu
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 11:12:50 -0500
Received: from zeniv.linux.org.uk ([195.92.253.2]:24028 "EHLO
	ZenIV.linux.org.uk") by vger.kernel.org with ESMTP id S964926AbWBQQMt
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 11:12:49 -0500
Date: Fri, 17 Feb 2006 16:12:47 +0000
From: Al Viro <viro@ftp.linux.org.uk>
To: Atsushi Nemoto <anemo@mba.ocn.ne.jp>
Cc: linux-kernel@vger.kernel.org, adaplas@pol.net, ralf@linux-mips.org
Subject: Re: [PATCH] add __force tag to fb_readb, etc.
Message-ID: <20060217161247.GN27946@ftp.linux.org.uk>
References: <20060218.000408.07643246.anemo@mba.ocn.ne.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060218.000408.07643246.anemo@mba.ocn.ne.jp>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2006 at 12:04:08AM +0900, Atsushi Nemoto wrote:
> This patch fixes many sparse warnings on MIPS (and some other) platform.

ITYM "hides".  You've just lost anything resembling typechecking of
arguments; it might be wrong in the current form, but at least we
get a reminder of possible problems.

With __force you've lost _all_ warnings - anything goes.  NAK.  At the
very least, figure out what type should the argument be and add a
(non-force) cast to that before forcing it.
