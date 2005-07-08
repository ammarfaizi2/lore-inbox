Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262631AbVGHFzc@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262631AbVGHFzc (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 01:55:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262624AbVGHFzb
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 01:55:31 -0400
Received: from courier.cs.helsinki.fi ([128.214.9.1]:61109 "EHLO
	mail.cs.helsinki.fi") by vger.kernel.org with ESMTP id S262632AbVGHFxv
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 01:53:51 -0400
References: <11206164393426@foobar.com>
            <11206164442712@foobar.com>
            <84144f0205070706326849b1e@mail.gmail.com>
            <1120770991.4860.1554.camel@localhost>
In-Reply-To: <1120770991.4860.1554.camel@localhost>
From: "Pekka J Enberg" <penberg@cs.helsinki.fi>
To: ncunningham@cyclades.com
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Suspend2 2.1.9.8 for 2.6.12: 622-swapwriter.patch
Date: Fri, 08 Jul 2005 08:53:49 +0300
Mime-Version: 1.0
Content-Type: text/plain; format=flowed; charset="utf-8,iso-8859-1"
Content-Transfer-Encoding: 7bit
Message-ID: <courier.42CE14ED.00003907@courier.cs.helsinki.fi>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 2005-07-07 at 23:32, Pekka Enberg wrote:
> > > @@ -0,0 +1,817 @@
> > > +struct io_info {
> > > +       struct bio * sys_struct;
> > > +       long block[PAGE_SIZE/512];

Nigel Cunningham writes:
> No...  it's the maximum number of blocks per page. Depending upon how
> the user has set the blocksize when they created the filesystem (in the
> case of filesystems), the number of blocks we use per page might be 1,
> 2, 4 or 8. 
> 
> It's long because a sector number is stored in it.

The field block wants a better name. block_sectors, perhaps? 

                Pekka 

