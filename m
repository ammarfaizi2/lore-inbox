Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261176AbULZW2B@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261176AbULZW2B (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 26 Dec 2004 17:28:01 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261177AbULZW2B
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 26 Dec 2004 17:28:01 -0500
Received: from pimout1-ext.prodigy.net ([207.115.63.77]:58614 "EHLO
	pimout1-ext.prodigy.net") by vger.kernel.org with ESMTP
	id S261176AbULZW17 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 26 Dec 2004 17:27:59 -0500
Date: Sun, 26 Dec 2004 14:26:53 -0800
From: Chris Wedgwood <cw@f00f.org>
To: Andi Kleen <ak@suse.de>
Cc: "Michael S. Tsirkin" <mst@mellanox.co.il>, Arnd Bergmann <arnd@arndb.de>,
       linux-kernel@vger.kernel.org, pavel@suse.cz, discuss@x86-64.org,
       gordon.jin@intel.com
Subject: Re: unregister_ioctl32_conversion and modules. ioctl32 revisited.
Message-ID: <20041226222653.GB29474@taniwha.stupidest.org>
References: <200412151847.09598.arnd@arndb.de> <20041215182109.GA13539@mellanox.co.il> <20041216040608.GB32718@wotan.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041216040608.GB32718@wotan.suse.de>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2004 at 05:06:08AM +0100, Andi Kleen wrote:

> > But what if you really wanted to return -ENOIOCTLCMD?
>
> It's an internal error code as Arnd pointed out.

can we be sure this will never escape to userspace?  i can think of
somewhere else we already do this (EFSCORRUPTED) and it does (somewhat
deliberately escape to userspace) and this causes confusion from time
to time when applications see 'errno == 990'

