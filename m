Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263953AbTLATzd (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Dec 2003 14:55:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264093AbTLATzd
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Dec 2003 14:55:33 -0500
Received: from gprs144-162.eurotel.cz ([160.218.144.162]:27521 "EHLO
	amd.ucw.cz") by vger.kernel.org with ESMTP id S263953AbTLATz3 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Dec 2003 14:55:29 -0500
Date: Mon, 1 Dec 2003 20:56:20 +0100
From: Pavel Machek <pavel@suse.cz>
To: IWAMOTO Toshihiro <iwamoto@valinux.co.jp>
Cc: linux-kernel@vger.kernel.org, linux-mm@kvack.org
Subject: Re: memory hotremove prototype, take 3
Message-ID: <20031201195620.GD255@elf.ucw.cz>
References: <20031201034155.11B387007A@sv1.valinux.co.jp>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20031201034155.11B387007A@sv1.valinux.co.jp>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> this is a new version of my memory hotplug prototype patch, against
> linux-2.6.0-test11.
> 
> Freeing 100% of a specified memory zone is non-trivial and necessary
> for memory hot removal.  This patch splits memory into 1GB zones, and
> implements complete zone memory freeing using kswapd or "remapping".
> 
> A bit more detailed explanation and some test scripts are at:
> 	http://people.valinux.co.jp/~iwamoto/mh.html

I scanned it...

hotunplug seems cool... How do you deal with kernel data structures in
memory "to be removed"? Or you simply don't allow kmalloc() to
allocate there?

During hotunplug, you copy pages to new locaion. Would it simplify
code if you forced them to be swapped out, instead? [Yep, it would be
slower...]
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
