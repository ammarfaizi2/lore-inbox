Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265684AbUA0VWq (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Jan 2004 16:22:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265698AbUA0VWq
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Jan 2004 16:22:46 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:37125 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265684AbUA0VWp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Jan 2004 16:22:45 -0500
Date: Tue, 27 Jan 2004 21:22:43 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Florian Huber <florian.huber@mnet-online.de>
Cc: JFS-Discussion <jfs-discussion@www-124.ibm.com>,
       Linux-Kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Jfs-discussion] md raid + jfs + jfs_fsck
Message-ID: <20040127212243.A20349@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Florian Huber <florian.huber@mnet-online.de>,
	JFS-Discussion <jfs-discussion@oss.software.ibm.com>,
	Linux-Kernel <linux-kernel@vger.kernel.org>
References: <1075230933.11207.84.camel@suprafluid> <1075231718.21763.28.camel@shaggy.austin.ibm.com> <1075232395.11203.94.camel@suprafluid> <1075236185.21763.89.camel@shaggy.austin.ibm.com> <20040127205324.A19913@infradead.org> <1075238385.14214.3.camel@suprafluid>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <1075238385.14214.3.camel@suprafluid>; from florian.huber@mnet-online.de on Tue, Jan 27, 2004 at 10:19:45PM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 27, 2004 at 10:19:45PM +0100, Florian Huber wrote:
> So, remove the raid, create a new raid "1" with one partiton and create
> a jfs fs on top of it, copy all files and add the other disk to the
> raid?

You can't partition md devices (yet), but otherwise yes.  I think you can
also create md device without the persistant superblock still, but it
always was a pain to maintain those.
