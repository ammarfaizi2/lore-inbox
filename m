Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751464AbWJPGk6@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751464AbWJPGk6 (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 16 Oct 2006 02:40:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751467AbWJPGk6
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 16 Oct 2006 02:40:58 -0400
Received: from hera.cwi.nl ([192.16.191.8]:50640 "EHLO hera.cwi.nl")
	by vger.kernel.org with ESMTP id S1751464AbWJPGk5 (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 16 Oct 2006 02:40:57 -0400
Date: Mon, 16 Oct 2006 08:40:39 +0200
From: Andries Brouwer <Andries.Brouwer@cwi.nl>
To: Neil Brown <neilb@suse.de>
Cc: Alan Cox <alan@lxorguk.ukuu.org.uk>, linux-kernel@vger.kernel.org,
       Andries.Brouwer@cwi.nl, Jens Axboe <jens.axboe@oracle.com>
Subject: Re: Why aren't partitions limited to fit within the device?
Message-ID: <20061016064039.GB3090@apps.cwi.nl>
References: <17710.54489.486265.487078@cse.unsw.edu.au> <1160752047.25218.50.camel@localhost.localdomain> <17714.52626.667835.228747@cse.unsw.edu.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17714.52626.667835.228747@cse.unsw.edu.au>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 16, 2006 at 10:08:50AM +1000, Neil Brown wrote:

> Hmmm.. So Alan thinks a partially-outside-this-disk partition
> shouldn't show up at all, and Andries thinks it should.
> And both give reasonably believable justifications.
> 
> Maybe we need a kernel parameter?

If you introduce a kernel parameter, let it be one that tells the kernel
to stay away from partitions, so that partitions can be added later by
the partx ioctls.

Now setting up an initrd or so is kind of tricky, not something ordinary users
would want to do, so if it moreover is possible to specify the rootpttype
that would allow an ordinary boot and leave all other block devices untouched.

> Not enabling partitions does not affect partition numbering of
> subsequent partitions.

A funny effect might be that hda5 exists, hda6 does not, and hda7 exists again.
Maybe unexpected for some software.

Andries
