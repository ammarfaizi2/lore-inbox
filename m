Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S271777AbRICSqj>; Mon, 3 Sep 2001 14:46:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S271780AbRICSq3>; Mon, 3 Sep 2001 14:46:29 -0400
Received: from ns.caldera.de ([212.34.180.1]:9641 "EHLO ns.caldera.de")
	by vger.kernel.org with ESMTP id <S271777AbRICSqK>;
	Mon, 3 Sep 2001 14:46:10 -0400
Date: Mon, 3 Sep 2001 20:45:47 +0200
From: Christoph Hellwig <hch@caldera.de>
To: Andries.Brouwer@cwi.nl
Cc: torvalds@transmeta.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] cleanup gendisk handling
Message-ID: <20010903204547.A820@caldera.de>
Mail-Followup-To: Christoph Hellwig <hch@caldera.de>,
	Andries.Brouwer@cwi.nl, torvalds@transmeta.com,
	linux-kernel@vger.kernel.org
In-Reply-To: <200109031835.SAA33971@vlet.cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <200109031835.SAA33971@vlet.cwi.nl>; from Andries.Brouwer@cwi.nl on Mon, Sep 03, 2001 at 06:35:25PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 03, 2001 at 06:35:25PM +0000, Andries.Brouwer@cwi.nl wrote:
> 
> Hmm - this looks almost identical to my patch 07.
> Yes, a nice patch :-)

Although this patch is obviously inspired by your patch, there is
a number of small differnces:

 * I do not have the major argument to add_gendisk/del_gendisk that
   you remove again in one of your later patches
 * I don't mess at all with the array of gendisks - that is a 2.5 issue.
 * I move all gendisk handling to drivers/block/genhd.c
 * I do not inline theseslow-path routines :)

	Christoph

-- 
Of course it doesn't work. We've performed a software upgrade.
