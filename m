Return-Path: <linux-kernel-owner+willy=40w.ods.org-S267585AbUJRTMS@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S267585AbUJRTMS (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 18 Oct 2004 15:12:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S267576AbUJRTMI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 18 Oct 2004 15:12:08 -0400
Received: from cantor.suse.de ([195.135.220.2]:35221 "EHLO Cantor.suse.de")
	by vger.kernel.org with ESMTP id S267535AbUJRTJj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 18 Oct 2004 15:09:39 -0400
Date: Mon, 18 Oct 2004 21:06:51 +0200
From: Andi Kleen <ak@suse.de>
To: Matthew Wilcox <matthew@wil.cx>
Cc: mkp@wildopensource.com, linux-kernel@vger.kernel.org,
       linux-ia64@vger.kernel.org, akpm@osdl.org, tony.luck@intel.com
Subject: Re: [PATCH] General purpose zeroed page slab
Message-Id: <20041018210651.66c3ab44.ak@suse.de>
In-Reply-To: <20041018184210.GI16153@parcelfarce.linux.theplanet.co.uk>
References: <yq1oej5s0po.fsf@wilson.mkp.net>
	<20041014180427.GA7973@wotan.suse.de>
	<yq1ekjvrjd6.fsf@wilson.mkp.net>
	<20041018184210.GI16153@parcelfarce.linux.theplanet.co.uk>
X-Mailer: Sylpheed version 0.9.11 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 18 Oct 2004 19:42:10 +0100
Matthew Wilcox <matthew@wil.cx> wrote:

> I disagree with Andi over the dumbness
> of zeroing the whole page.  That makes it cache-hot, which is what you
> want from a page you allocate from slab.

Not for a page table, which tends to be not fully used.
It would be true for a user page, but that doesn't use this mechanism anyways.

-Andi
