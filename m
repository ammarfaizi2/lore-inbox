Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263607AbTKJOJ2 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 10 Nov 2003 09:09:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263624AbTKJOJ2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 10 Nov 2003 09:09:28 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:57048 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S263607AbTKJOJ1 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 10 Nov 2003 09:09:27 -0500
Date: Mon, 10 Nov 2003 15:09:27 +0100
From: Jens Axboe <axboe@suse.de>
To: Simon Haynes <simon@baydel.com>
Cc: linux-kernel@vger.kernel.org, linux-mtd@lists.infradead.org
Subject: Re: SFFDC and blksize_size
Message-ID: <20031110140927.GE32637@suse.de>
References: <37CC93E8710D@baydel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <37CC93E8710D@baydel.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 07 2003, Simon Haynes wrote:
> 
> I have been writing a block driver for SSFDC compliant SMC cards. This stuff 
> allocates 16k blocks.  When I get requests the transfers are split into the 
> size I specifty in the blksize_size{MAJOR] array. It sems that most things 

Sounds like a bad way to do it. It's much better to prevent builds of
bigger requests than you can handle in one go. You don't mention what
kernel you are using, but both 2.4 and 2.6 can do this for you.

-- 
Jens Axboe

