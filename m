Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S261837AbSJ2MHN>; Tue, 29 Oct 2002 07:07:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S261842AbSJ2MHN>; Tue, 29 Oct 2002 07:07:13 -0500
Received: from phoenix.infradead.org ([195.224.96.167]:17420 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id <S261837AbSJ2MHM>; Tue, 29 Oct 2002 07:07:12 -0500
Date: Tue, 29 Oct 2002 12:13:19 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Randy.Dunlap" <rddunlap@osdl.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] use seq_file for /proc/swaps
Message-ID: <20021029121319.A19590@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Randy.Dunlap" <rddunlap@osdl.org>, linux-kernel@vger.kernel.org
References: <Pine.LNX.4.33L2.0210282132000.13581-100000@dragon.pdx.osdl.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.33L2.0210282132000.13581-100000@dragon.pdx.osdl.net>; from rddunlap@osdl.org on Mon, Oct 28, 2002 at 09:36:44PM -0800
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 28, 2002 at 09:36:44PM -0800, Randy.Dunlap wrote:
> 
> Hi,
> 
> This patch to 2.5.44 converts /proc/swaps to use seq_file.
> 
> It's basically the same patch that I posted a few days ago
> with locking added [using swap_list_lock() and
> swap_list_unlock(), as directed by Al].
> 
> Any comments on this version?

Looks fine.  Any chance you could move proc_swaps_operations and
the entry creating to swapfile.c so when uclinux makes this file
conditional on CONFIG_SWAP we don't need ifdefs in proc_misc.c?

