Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261189AbTENH5X (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 May 2003 03:57:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261190AbTENH5W
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 May 2003 03:57:22 -0400
Received: from carisma.slowglass.com ([195.224.96.167]:61455 "EHLO
	phoenix.infradead.org") by vger.kernel.org with ESMTP
	id S261189AbTENH5W (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 May 2003 03:57:22 -0400
Date: Wed, 14 May 2003 09:10:08 +0100
From: Christoph Hellwig <hch@infradead.org>
To: Christopher Hoover <ch@murgatroid.com>
Cc: Christoph Hellwig <hch@infradead.org>, linux-kernel@vger.kernel.org,
       torvalds@transmeta.com
Subject: Re: [PATCH] 2.5.68: Don't include SCSI block ioctls on non-scsi systems
Message-ID: <20030514091008.A7615@infradead.org>
Mail-Followup-To: Christoph Hellwig <hch@infradead.org>,
	Christopher Hoover <ch@murgatroid.com>,
	linux-kernel@vger.kernel.org, torvalds@transmeta.com
References: <20030513202710.A32666@heavens.murgatroid.com> <20030514065752.A647@infradead.org> <20030514010801.A4080@heavens.murgatroid.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <20030514010801.A4080@heavens.murgatroid.com>; from ch@murgatroid.com on Wed, May 14, 2003 at 01:08:02AM -0700
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 14, 2003 at 01:08:02AM -0700, Christopher Hoover wrote:
> On Wed, May 14, 2003 at 06:57:52AM +0100, Christoph Hellwig wrote:
> > On Tue, May 13, 2003 at 08:29:20PM -0700, Christopher Hoover wrote:
> > > Unless I'm missing something, there doesn't seem to be a good reason
> > > for the block system to include SCSI ioctls unless there's a SCSI
> > > block device (CONFIG_BLK_DEV_SD) in the system.
> > 
> > That's broken.  You can use them on ide, sd and sr currently.
> 
> OK, let's try that again.

Well, the idea of this code is that it is generic - I'd rather make it 
a standalone config option and add stubs so driver still compile with it disabled.
