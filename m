Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261709AbVDYTxy@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261709AbVDYTxy (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 25 Apr 2005 15:53:54 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261754AbVDYTxy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 25 Apr 2005 15:53:54 -0400
Received: from scrub.xs4all.nl ([194.109.195.176]:19384 "EHLO scrub.xs4all.nl")
	by vger.kernel.org with ESMTP id S261709AbVDYTxx (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 25 Apr 2005 15:53:53 -0400
Date: Mon, 25 Apr 2005 21:53:47 +0200 (CEST)
From: Roman Zippel <zippel@linux-m68k.org>
X-X-Sender: roman@scrub.home
To: Colin Leroy <colin@colino.net>
cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       Andrew Morton <akpm@osdl.org>
Subject: Re: [PATCH] hfsplus: don't oops on bad FS
In-Reply-To: <20050425211915.126ddab5@jack.colino.net>
Message-ID: <Pine.LNX.4.61.0504252145220.25129@scrub.home>
References: <20050425211915.126ddab5@jack.colino.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, 25 Apr 2005, Colin Leroy wrote:

> currently trying to mount a non-hfsplus filesystem as hfsplus results
> in an oops, as seen on http://colino.net/tmp/hfsplus_oops.txt
> 
> This patch fixes it; while at it, it frees sbi on error instead of
> leaking it.

Actually it looks like we are always leaking it, so actually 
hfsplus_put_super() needs fixing, could you add the check and kfree 
there and do the same fix for hfs?

bye, Roman
