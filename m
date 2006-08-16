Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1750974AbWHPROg@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750974AbWHPROg (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 16 Aug 2006 13:14:36 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750972AbWHPROf
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 16 Aug 2006 13:14:35 -0400
Received: from cantor2.suse.de ([195.135.220.15]:51079 "EHLO mx2.suse.de")
	by vger.kernel.org with ESMTP id S1750773AbWHPROe (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 16 Aug 2006 13:14:34 -0400
Date: Wed, 16 Aug 2006 10:13:28 -0700
From: Greg KH <greg@kroah.com>
To: Kirill Korotaev <dev@sw.ru>
Cc: Andrew Morton <akpm@osdl.org>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Alan Cox <alan@lxorguk.ukuu.org.uk>, Ingo Molnar <mingo@elte.hu>,
       Christoph Hellwig <hch@infradead.org>,
       Pavel Emelianov <xemul@openvz.org>, Andrey Savochkin <saw@sw.ru>,
       devel@openvz.org, Rik van Riel <riel@redhat.com>, hugh@veritas.com,
       ckrm-tech@lists.sourceforge.net, Andi Kleen <ak@suse.de>
Subject: Re: [RFC][PATCH 7/7] UBC: proc interface
Message-ID: <20060816171328.GA27898@kroah.com>
References: <44E33893.6020700@sw.ru> <44E33D5E.7000205@sw.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <44E33D5E.7000205@sw.ru>
User-Agent: Mutt/1.5.12-2006-07-14
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 16, 2006 at 07:44:30PM +0400, Kirill Korotaev wrote:
> Add proc interface (/proc/user_beancounters) allowing to see current
> state (usage/limits/fails for each UB). Implemented via seq files.

Ugh, why /proc?  This doesn't have anything to do with processes, just
users, right?  What's wrong with /sys/kernel/ instead?

Or /sys/kernel/debug/user_beancounters/ in debugfs as this is just a
debugging thing, right?

thanks,

greg k-h
