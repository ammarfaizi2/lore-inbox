Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262158AbULLWX1@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262158AbULLWX1 (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 12 Dec 2004 17:23:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262159AbULLWX1
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 12 Dec 2004 17:23:27 -0500
Received: from [213.146.154.40] ([213.146.154.40]:33246 "EHLO
	pentafluge.infradead.org") by vger.kernel.org with ESMTP
	id S262158AbULLWXX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 12 Dec 2004 17:23:23 -0500
Date: Sun, 12 Dec 2004 22:23:09 +0000
From: Christoph Hellwig <hch@infradead.org>
To: "Michael S. Tsirkin" <mst@mellanox.co.il>
Cc: Andi Kleen <ak@suse.de>, discuss@x86-64.org, linux-kernel@vger.kernel.org
Subject: Re: how to detect a 32 bit process on 64 bit kernel
Message-ID: <20041212222309.GA11045@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	"Michael S. Tsirkin" <mst@mellanox.co.il>, Andi Kleen <ak@suse.de>,
	discuss@x86-64.org, linux-kernel@vger.kernel.org
References: <20040901072245.GF13749@mellanox.co.il> <20040903080058.GB2402@wotan.suse.de> <20040907104017.GB10096@mellanox.co.il> <20040907121418.GC25051@wotan.suse.de> <20041212215110.GA11451@mellanox.co.il>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20041212215110.GA11451@mellanox.co.il>
User-Agent: Mutt/1.4.1i
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by pentafluge.infradead.org
	See http://www.infradead.org/rpr.html
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 12, 2004 at 11:51:10PM +0200, Michael S. Tsirkin wrote:
> Hello!
> Is there a reliable way e.g. on x86-64 (or ia64, or any other
> 64-bit system), from the char device driver,
> to find out that I am running an operation in the context of a 32-bit
> task?

There's no way that's both reliable and portable.

> If no - would not it make a sence to add e.g. a flag in the
> task struct, to make it possible?

The kernel code shouldn't know.  If your driver needs this information
something is seriously wrong with it. 

