Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265910AbUA0Uxd (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 15:53:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265919AbUA0Uxc
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 15:53:32 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:15621 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265910AbUA0Uxc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 15:53:32 -0500
Date: Tue, 27 Jan 2004 20:53:24 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Dave Kleikamp <shaggy@austin.ibm.com>
Cc: Florian Huber <florian.huber@mnet-online.de>,
       JFS Discussion <jfs-discussion@www-124.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Jfs-discussion] md raid + jfs + jfs_fsck
Message-ID: <20040127205324.A19913@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Dave Kleikamp <shaggy@austin.ibm.com>,
	Florian Huber <florian.huber@mnet-online.de>,
	JFS Discussion <jfs-discussion@oss.software.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <1075230933.11207.84.camel@suprafluid> <1075231718.21763.28.camel@shaggy.austin.ibm.com> <1075232395.11203.94.camel@suprafluid> <1075236185.21763.89.camel@shaggy.austin.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1075236185.21763.89.camel@shaggy.austin.ibm.com>; from shaggy@austin.ibm.com on Tue, Jan 27, 2004 at 02:43:05PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 02:43:05PM -0600, Dave Kleikamp wrote:
> My guess is that software raid is stealing a few blocks from the end of
> the partition,

Yes, it does.  But JFS should get the right size from the gendisk anyway.
Or did you create the raid with the filesystem already existant?  While that
appears to work for a non-full ext2/ext3 filesystem it's not something you
should do because it makes the filesystem internal bookkeeping wrong and
you'll run into trouble with any filesystem sooner or later.

