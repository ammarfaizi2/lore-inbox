Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264586AbUAHOIj (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 8 Jan 2004 09:08:39 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264917AbUAHOIj
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 8 Jan 2004 09:08:39 -0500
Received: from ns.virtualhost.dk ([195.184.98.160]:20698 "EHLO virtualhost.dk")
	by vger.kernel.org with ESMTP id S264586AbUAHOIh (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 8 Jan 2004 09:08:37 -0500
Date: Thu, 8 Jan 2004 15:08:30 +0100
From: Jens Axboe <axboe@suse.de>
To: bert hubert <ahu@ds9a.nl>, linux-kernel@vger.kernel.org
Subject: Re: blockfile access patterns logging
Message-ID: <20040108140830.GR16720@suse.de>
References: <20040108120008.GA7415@outpost.ds9a.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20040108120008.GA7415@outpost.ds9a.nl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 08 2004, bert hubert wrote:
> Jens,
> 
> For some time I've wanted to log exactly what linux is reading and writing
> from my harddisk - for a variety of reasons. The current reason is that my
> very idle laptop writes to disk every once in a while (or reads, I don't
> know).
> 
> Now, conceptually this should not be very hard, but I'd like to ask your
> thoughts on where I might insert some crude logging? There are lots of
> places that might be better or worse for some reason.
> 
> I'd love to be as close to the physical block device as possible, short of
> rewriting actual IDE drivers.
> 
> Any tips? Or is this idea crazy?

If you have the laptop mode patch (it's in 2.4 current, and in 2.6-mm as
well), then you can enable block dump by echoing 1 to
/proc/sys/vm/block_dump - this will dump all reads/writes to any device
in the system. Sounds like this is what you want.

-- 
Jens Axboe

