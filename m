Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290550AbSARAWC>; Thu, 17 Jan 2002 19:22:02 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290551AbSARAVx>; Thu, 17 Jan 2002 19:21:53 -0500
Received: from cpe-24-221-186-48.ca.sprintbbd.net ([24.221.186.48]:47372 "HELO
	jose.vato.org") by vger.kernel.org with SMTP id <S290550AbSARAVm>;
	Thu, 17 Jan 2002 19:21:42 -0500
From: "Tim Pepper" <tpepper@vato.org>
Date: Thu, 17 Jan 2002 16:21:40 -0800
To: Andries.Brouwer@cwi.nl
Cc: Matt_Domsch@dell.com, linux-kernel@vger.kernel.org
Subject: Re: BLKGETSIZE64 (bytes or sectors?)
Message-ID: <20020117162140.F11402@vato.org>
In-Reply-To: <UTC200201172348.XAA420548.aeb@cwi.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5.1i
In-Reply-To: <UTC200201172348.XAA420548.aeb@cwi.nl>; from Andries.Brouwer@cwi.nl on Thu, Jan 17, 2002 at 11:48:16PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 17 Jan at 23:48:16 +0000 Andries.Brouwer@cwi.nl done said:
> Matt_Domsch@dell.com wrote, and he is right:
> 
> Yes, in bytes. blkpg.c has to be fixed.
> Several people submitted patches. Sooner or later I suppose
> this will be fixed.
> 
>--8< snip-----------
>
> So, indeed, we have already multiplied by hardsect_size, struct gendisk
> uses sectors of size 512, independent of the hardware, and we must not
> again multiply by hardsect_size.

Doh.  It's obviously much cleaner and more efficient that way.

Have any of the other patch submitters added a comment to note this in
include/linux/genhd.h?  hd_struct doesn't have any mention of start_sect
and nr_sect being stored in sectors of 512bytes.  But maybe that's just
to weed out fools like me.

-- 
*********************************************************
*  tpepper@vato dot org             * Venimus, Vidimus, *
*  http://www.vato.org/~tpepper     * Dolavimus         *
*********************************************************
