Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315536AbSHGW3t>; Wed, 7 Aug 2002 18:29:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315690AbSHGW3t>; Wed, 7 Aug 2002 18:29:49 -0400
Received: from verein.lst.de ([212.34.181.86]:59917 "EHLO verein.lst.de")
	by vger.kernel.org with ESMTP id <S315536AbSHGW3s>;
	Wed, 7 Aug 2002 18:29:48 -0400
Date: Thu, 8 Aug 2002 00:33:25 +0200
From: Christoph Hellwig <hch@lst.de>
To: Andries Brouwer <aebr@win.tue.nl>
Cc: Kurt Garloff <kurt@garloff.de>, Christoph Hellwig <hch@lst.de>,
       Linux kernel list <linux-kernel@vger.kernel.org>,
       Marcelo Tosatti <marcelo@conectiva.com.br>
Subject: Re: [PATCH] conditionally re-enable per-disk stats, convert to seq_file
Message-ID: <20020808003325.A14578@lst.de>
Mail-Followup-To: Christoph Hellwig <hch@lst.de>,
	Andries Brouwer <aebr@win.tue.nl>, Kurt Garloff <kurt@garloff.de>,
	Linux kernel list <linux-kernel@vger.kernel.org>,
	Marcelo Tosatti <marcelo@conectiva.com.br>
References: <20020806160848.A2413@lst.de> <20020807210225.GD31622@nbkurt.etpnet.phys.tue.nl> <20020807211856.GB322@win.tue.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20020807211856.GB322@win.tue.nl>; from aebr@win.tue.nl on Wed, Aug 07, 2002 at 11:18:56PM +0200
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 07, 2002 at 11:18:56PM +0200, Andries Brouwer wrote:
> But why in /proc/partitions ?
> Maybe /proc/partitions can go away eventually with all info available
> under driverfs or so. But for the time being, /proc/partitions is used,
> and some changes are planned to make identification of the devices
> involved easier.
> It is really ugly to stuff a lot of garbage into a file just because
> it happens to exist already. If you want disk statistics, why not
> put it in /proc/diskstatistics?

Because it's where existing tools expect it.  I agree with you that we
want a nicer interface for 2.6, but give the userbase some time to
prepare for a new interface.

