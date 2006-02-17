Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751475AbWBQPV5@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751475AbWBQPV5 (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 17 Feb 2006 10:21:57 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751484AbWBQPV5
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 17 Feb 2006 10:21:57 -0500
Received: from mx1.redhat.com ([66.187.233.31]:50359 "EHLO mx1.redhat.com")
	by vger.kernel.org with ESMTP id S1751475AbWBQPV4 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 17 Feb 2006 10:21:56 -0500
Date: Fri, 17 Feb 2006 15:21:47 +0000
From: Alasdair G Kergon <agk@redhat.com>
To: "Darrick J. Wong" <djwong@us.ibm.com>
Cc: dm-devel@redhat.com, Chris McDermott <lcm@us.ibm.com>,
       linux-kernel@vger.kernel.org
Subject: Re: [dm-devel] Re: [PATCH] User-configurable HDIO_GETGEO for dm volumes
Message-ID: <20060217152147.GF12169@agk.surrey.redhat.com>
Mail-Followup-To: "Darrick J. Wong" <djwong@us.ibm.com>,
	dm-devel@redhat.com, Chris McDermott <lcm@us.ibm.com>,
	linux-kernel@vger.kernel.org
References: <43F38D83.3040702@us.ibm.com> <20060217151650.GC12173@agk.surrey.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060217151650.GC12173@agk.surrey.redhat.com>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 17, 2006 at 03:16:50PM +0000, Alasdair G Kergon wrote:
> +static int dm_blk_getgeo(struct block_device *bdev, struct hd_geometry *geo)
> +{
> +	struct mapped_device *md = bdev->bd_disk->private_data;
> +
> +	return dm_table_get_geometry(md->map, geo);
> +}
> 
> And if md->map is NULL?

See also:

  /*
   * Everyone (including functions in this file), should use this
   * function to access the md->map field, and make sure they call
   * dm_table_put() when finished.
   */
  struct dm_table *dm_get_table(struct mapped_device *md)


Alasdair
-- 
agk@redhat.com
