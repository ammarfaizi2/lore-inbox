Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263094AbVCJULn@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263094AbVCJULn (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 10 Mar 2005 15:11:43 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263106AbVCJUGP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 10 Mar 2005 15:06:15 -0500
Received: from willy.net1.nerim.net ([62.212.114.60]:51719 "EHLO
	willy.net1.nerim.net") by vger.kernel.org with ESMTP
	id S263081AbVCJUB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 10 Mar 2005 15:01:27 -0500
Date: Thu, 10 Mar 2005 21:01:13 +0100
From: Willy Tarreau <willy@w.ods.org>
To: Bodo Eggert <7eggert@gmx.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] make st seekable again
Message-ID: <20050310200113.GE30052@alpha.home.local>
References: <fa.i3f7d9s.30m8rg@ifi.uio.no> <fa.l4kuq52.e6001g@ifi.uio.no> <E1D9BmR-00026p-03@be1.7eggert.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <E1D9BmR-00026p-03@be1.7eggert.dyndns.org>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 10, 2005 at 01:43:57AM +0100, Bodo Eggert wrote:
 
> Can the lseek be restricted to seek from 0 to 0 (or even * to 0 aka rewind)?
> This would re-enable tar and probably other applications depending on this
> API while not giving them false positives.

This would be good only if we also agree to spit out warning messages every
time the trick is used, so that people know they are relying on a buggy
application. Just like tcpdump and AF_PACKET.

willy

