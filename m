Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161008AbWA0U0w@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161008AbWA0U0w (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 27 Jan 2006 15:26:52 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161010AbWA0U0w
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 27 Jan 2006 15:26:52 -0500
Received: from caramon.arm.linux.org.uk ([212.18.232.186]:59409 "EHLO
	caramon.arm.linux.org.uk") by vger.kernel.org with ESMTP
	id S1161008AbWA0U0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 27 Jan 2006 15:26:52 -0500
Date: Fri, 27 Jan 2006 20:26:46 +0000
From: Russell King <rmk+lkml@arm.linux.org.uk>
To: Jens Axboe <axboe@suse.de>
Cc: Pierre Ossman <drzeus-list@drzeus.cx>, LKML <linux-kernel@vger.kernel.org>
Subject: Re: How to map high memory for block io
Message-ID: <20060127202646.GC2767@flint.arm.linux.org.uk>
Mail-Followup-To: Jens Axboe <axboe@suse.de>,
	Pierre Ossman <drzeus-list@drzeus.cx>,
	LKML <linux-kernel@vger.kernel.org>
References: <43D9C19F.7090707@drzeus.cx> <20060127102611.GC4311@suse.de> <43D9F705.5000403@drzeus.cx> <20060127104321.GE4311@suse.de> <43DA0E97.5030504@drzeus.cx> <20060127194318.GA1433@flint.arm.linux.org.uk> <43DA7CD1.4040301@drzeus.cx> <20060127201458.GA2767@flint.arm.linux.org.uk> <20060127202206.GH9068@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20060127202206.GH9068@suse.de>
User-Agent: Mutt/1.4.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 27, 2006 at 09:22:06PM +0100, Jens Axboe wrote:
> That is definitely valid, same goes for the bio_vec structure. They map
> _a_ page, after all :-)

Okay.  Pierre - are you saying that you have an sg entry where
sg->offset + sg->length > PAGE_SIZE, and hence is causing you to
cross a page boundary?

(Sorry, your initial mail got lost because I've tend to be over-eager
these days with the D key with lkml over the last week or so - I've
not been around much.)

-- 
Russell King
 Linux kernel    2.6 ARM Linux   - http://www.arm.linux.org.uk/
 maintainer of:  2.6 Serial core
