Return-Path: <linux-kernel-owner+willy=40w.ods.org-S263062AbUDTQB3@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263062AbUDTQB3 (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 20 Apr 2004 12:01:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263093AbUDTQB3
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 20 Apr 2004 12:01:29 -0400
Received: from bay-bridge.veritas.com ([143.127.3.10]:18859 "EHLO
	MTVMIME01.enterprise.veritas.com") by vger.kernel.org with ESMTP
	id S263062AbUDTQB1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 20 Apr 2004 12:01:27 -0400
Date: Tue, 20 Apr 2004 17:01:17 +0100 (BST)
From: Hugh Dickins <hugh@veritas.com>
X-X-Sender: hugh@localhost.localdomain
To: Paul Mundt <lethal@linux-sh.org>
cc: Russell King <rmk+lkml@arm.linux.org.uk>,
       Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Clean up asm/pgalloc.h include (sh)
In-Reply-To: <20040420144659.GE12390@linux-sh.org>
Message-ID: <Pine.LNX.4.44.0404201647020.4724-100000@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 20 Apr 2004, Paul Mundt wrote:
> Failed to compile. sh has ptep_get_and_clear in asm/pgalloc.h.
> This moves it out of the way, and your patch builds fine.

Paul, the patch you show reflects how ptep_get_and_clear looked in
2.6.5, but not how it now looks in 2.6.6-rc1-bk - should be using
page_mapping(page) and mapping_writably_mapped(mapping).

I dare say you're referring to a master tree into which the recent
mainline changes need to be ported (I CC'ed gniibe@m17n.org when
sending those changes to akpm): I'm not saying your version is
wrong, just trying to make sure that two sets of changes in the
same area don't end up with one set getting lost.

Hugh

