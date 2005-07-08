Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262667AbVGHNoP@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262667AbVGHNoP (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 8 Jul 2005 09:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262662AbVGHNly
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 8 Jul 2005 09:41:54 -0400
Received: from [203.171.93.254] ([203.171.93.254]:63411 "EHLO
	cunningham.myip.net.au") by vger.kernel.org with ESMTP
	id S262660AbVGHNk7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 8 Jul 2005 09:40:59 -0400
Subject: Re: [PATCH] [46/48] Suspend2 2.1.9.8 for 2.6.12:
	622-swapwriter.patch
From: Nigel Cunningham <ncunningham@cyclades.com>
Reply-To: ncunningham@cyclades.com
To: nickpiggin@yahoo.com.au
Cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
       Pekka Enberg <penberg@cs.helsinki.fi>
In-Reply-To: <200507080726.22102.nickpiggin@yahoo.com.au>
References: <11206164393426@foobar.com>
	 <84144f0205070706326849b1e@mail.gmail.com>
	 <1120770991.4860.1554.camel@localhost>
	 <200507080726.22102.nickpiggin@yahoo.com.au>
Content-Type: text/plain
Organization: Cycades
Message-Id: <1120830140.4860.3033.camel@localhost>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.4.6-1mdk 
Date: Fri, 08 Jul 2005 23:42:20 +1000
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi.

On Fri, 2005-07-08 at 07:26, nickpiggin@yahoo.com.au wrote:
> On Fri, 8 Jul 2005 07:16 am, Nigel Cunningham wrote:
> 
> Hi,
> 
> > > > +struct io_info {
> > > > +       struct bio * sys_struct;
> > > > +       long block[PAGE_SIZE/512];
> > >
> > > Aah, but for this you should use block_size(io_info->dev) instead. No
> > > need to mess with sector sizes. Why is this long by the way?
> > > PAGE_SIZE/512 is block size in bytes.
> >
> > No...  it's the maximum number of blocks per page. Depending upon how
> > the user has set the blocksize when they created the filesystem (in the
> > case of filesystems), the number of blocks we use per page might be 1,
> > 2, 4 or 8.
> >
> 
> MAX_BUF_PER_PAGE
> 
> > It's long because a sector number is stored in it.
> >
> 
> sector_t?

Fixed. Ta.

Nigel
-- 
Evolution.
Enumerate the requirements.
Consider the interdependencies.
Calculate the probabilities.
Be amazed that people believe it happened. 

