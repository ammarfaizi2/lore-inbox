Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262041AbTL1UJI (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 28 Dec 2003 15:09:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261965AbTL1UJH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 28 Dec 2003 15:09:07 -0500
Received: from phoenix.infradead.org ([213.86.99.234]:30217 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S262040AbTL1UI5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sun, 28 Dec 2003 15:08:57 -0500
Date: Sun, 28 Dec 2003 20:08:54 +0000
From: Christoph Hellwig <hch@infradead.org>
To: Matt Domsch <Matt_Domsch@dell.com>
Cc: linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Subject: Re: [RFC] 2.6.0 EDD enhancements
Message-ID: <20031228200854.B22668@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Matt Domsch <Matt_Domsch@dell.com>, linux-kernel@vger.kernel.org,
	linux-scsi@vger.kernel.org
References: <Pine.LNX.4.44.0312191254550.2465-100000@humbolt.us.dell.com> <20031219130129.B6530@lists.us.dell.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20031219130129.B6530@lists.us.dell.com>; from Matt_Domsch@dell.com on Fri, Dec 19, 2003 at 01:01:29PM -0600
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 19, 2003 at 01:01:29PM -0600, Matt Domsch wrote:
> ChangeSet@1.1532.1.2, 2003-12-18 16:35:16-06:00, Matt_Domsch@dell.com
>   EDD: enable symlinks to SCSI devices
>   
>   Symlinks from /sys/firmware/edd/int13_dev8x/disc to the appropriate
>   SCSI discs were added a year ago, but disabled because the
>   scsi_bus list contained non-'scsi_device's at that time, which
>   could have lead to an improper pointer following.    The SCSI
>   mid-layer has rectified this, so this code can be re-enabled
>   in edd.c once again.

As James already said you're poking far too deep into scsi internals.
In addition to his comment I'd suggest putting the symlink creating
into scsi_sysfs.c and exporting a procedural interface for the edd
code.  That way it'll get updated automatically if we change something.

