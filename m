Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263167AbUDZR6h@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263167AbUDZR6h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 26 Apr 2004 13:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263366AbUDZR6h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 26 Apr 2004 13:58:37 -0400
Received: from uslink-66.173.43-129.uslink.net ([66.173.43.129]:32146 "EHLO
	dingdong.cryptoapps.com") by vger.kernel.org with ESMTP
	id S263167AbUDZR6f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 26 Apr 2004 13:58:35 -0400
Date: Mon, 26 Apr 2004 10:58:25 -0700
From: Chris Wedgwood <cw@f00f.org>
To: Jonathan Corbet <corbet@lwn.net>
Cc: linux-kernel@vger.kernel.org
Subject: Re: ext3 inode cache eats system, news at 11
Message-ID: <20040426175825.GA31202@dingdong.cryptoapps.com>
References: <20040426171856.22514.qmail@lwn.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040426171856.22514.qmail@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 26, 2004 at 11:18:56AM -0600, Jonathan Corbet wrote:

> Of my 800MB of slab use, those two are responsible for 755MB.

I see this too sometimes.  Basically slab grows insanely large and you
run out of lowmem and all turns crappy.  Even with 64-bit arch's like
yours the sab can still get out of hand, I've seen 5GB used on an 8GB
machine.

It's not ext3 specific, other filesystems can and will do this too.



  --cw



