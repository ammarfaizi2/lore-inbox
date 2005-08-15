Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964796AbVHOPCo@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964796AbVHOPCo (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 15 Aug 2005 11:02:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964799AbVHOPCo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 15 Aug 2005 11:02:44 -0400
Received: from cantor2.suse.de ([195.135.220.15]:38113 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S964796AbVHOPCn (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 15 Aug 2005 11:02:43 -0400
To: Arjan van de Ven <arjan@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux@horizon.com, lkml.hyoshiok@gmail.com
Subject: Re: [RFC] [PATCH] cache pollution aware __copy_from_user_ll()
References: <20050815121555.29159.qmail@science.horizon.com.suse.lists.linux.kernel>
	<1124108702.3228.33.camel@laptopd505.fenrus.org.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 15 Aug 2005 17:02:27 +0200
In-Reply-To: <1124108702.3228.33.camel@laptopd505.fenrus.org.suse.lists.linux.kernel>
Message-ID: <p73u0hr1bwc.fsf@verdi.suse.de>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Arjan van de Ven <arjan@infradead.org> writes:

> On Mon, 2005-08-15 at 08:15 -0400, linux@horizon.com wrote:
> > Actually, is there any place *other* than write() to the page cache that
> > warrants a non-temporal store?  Network sockets with scatter/gather and
> > hardware checksum, maybe?
> 
> afaik those use zero copy already, eg straight pagecache copy.

Only if you use sendfile(). And the normal write path uses csum_copy_* 

-Andi
