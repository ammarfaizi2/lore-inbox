Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261251AbVGGV2b@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261251AbVGGV2b (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 7 Jul 2005 17:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261486AbVGGV1A
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 7 Jul 2005 17:27:00 -0400
Received: from smtp107.mail.sc5.yahoo.com ([66.163.169.227]:21921 "HELO
	smtp107.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261251AbVGGV03 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 7 Jul 2005 17:26:29 -0400
From: nickpiggin@yahoo.com.au
To: linux-kernel@vger.kernel.org, ncunningham@cyclades.com
Subject: Re: [PATCH] [46/48] Suspend2 2.1.9.8 for 2.6.12: 622-swapwriter.patch
Date: Fri, 8 Jul 2005 07:26:21 +1000
User-Agent: KMail/1.8
Cc: Pekka Enberg <penberg@cs.helsinki.fi>
References: <11206164393426@foobar.com> <84144f0205070706326849b1e@mail.gmail.com> <1120770991.4860.1554.camel@localhost>
In-Reply-To: <1120770991.4860.1554.camel@localhost>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200507080726.22102.nickpiggin@yahoo.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 8 Jul 2005 07:16 am, Nigel Cunningham wrote:

Hi,

> > > +struct io_info {
> > > +       struct bio * sys_struct;
> > > +       long block[PAGE_SIZE/512];
> >
> > Aah, but for this you should use block_size(io_info->dev) instead. No
> > need to mess with sector sizes. Why is this long by the way?
> > PAGE_SIZE/512 is block size in bytes.
>
> No...  it's the maximum number of blocks per page. Depending upon how
> the user has set the blocksize when they created the filesystem (in the
> case of filesystems), the number of blocks we use per page might be 1,
> 2, 4 or 8.
>

MAX_BUF_PER_PAGE

> It's long because a sector number is stored in it.
>

sector_t?

Nick

Send instant messages to your online friends http://au.messenger.yahoo.com 
