Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265882AbUA1JjM (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 28 Jan 2004 04:39:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265881AbUA1JjI
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 28 Jan 2004 04:39:08 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:45833 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S265882AbUA1JjF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 28 Jan 2004 04:39:05 -0500
Date: Wed, 28 Jan 2004 09:38:51 +0000
From: Christoph Hellwig <hch@infradead.org>
To: venom@sns.it
Cc: Dave Kleikamp <shaggy@austin.ibm.com>,
       Florian Huber <florian.huber@mnet-online.de>,
       JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [Jfs-discussion] md raid + jfs + jfs_fsck
Message-ID: <20040128093851.A26131@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>, venom@sns.it,
	Dave Kleikamp <shaggy@austin.ibm.com>,
	Florian Huber <florian.huber@mnet-online.de>,
	JFS Discussion <jfs-discussion@www-124.southbury.usf.ibm.com>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <20040127205324.A19913@infradead.org> <Pine.LNX.4.43.0401281021030.31225-100000@cibs9.sns.it>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <Pine.LNX.4.43.0401281021030.31225-100000@cibs9.sns.it>; from venom@sns.it on Wed, Jan 28, 2004 at 10:24:14AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 28, 2004 at 10:24:14AM +0100, venom@sns.it wrote:
> In most situation to create a new FS on a RAID1 MD is not an option.
> It happens that you have to mirror a partition, maybe alarge one, and it
> already had a filesystem on top of it. Then what should you do?
> backup, mirror and then restore? Sometimes it is not possible this too.
> Then you accept to deal with the possible problems...

Then you need to shrink the filesystem.  As long as the space isn't used
yet it's rather trivial for most ondisk formats, but you absolutely need
to do it to be safe.

