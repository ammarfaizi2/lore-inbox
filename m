Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S286744AbSABFHo>; Wed, 2 Jan 2002 00:07:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S286735AbSABFHe>; Wed, 2 Jan 2002 00:07:34 -0500
Received: from [202.54.26.202] ([202.54.26.202]:34003 "EHLO hindon.hss.co.in")
	by vger.kernel.org with ESMTP id <S286744AbSABFHT>;
	Wed, 2 Jan 2002 00:07:19 -0500
X-Lotus-FromDomain: HSS
From: alad@hss.hns.com
To: Andrew Morton <akpm@zip.com.au>
cc: linux-kernel@vger.kernel.org
Message-ID: <65256B35.001BC3C0.00@sandesh.hss.hns.com>
Date: Wed, 2 Jan 2002 10:28:29 +0530
Subject: Re: locked page handling
Mime-Version: 1.0
Content-type: text/plain; charset=us-ascii
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org








Andrew Morton <akpm@zip.com.au> on 01/01/2002 01:19:05 AM

To:   Amol Lad/HSS@HSS, linux-kernel@vger.kernel.org
cc:

Subject:  Re: locked page handling




Andrew Morton wrote:
>
> alad@hss.hns.com wrote:
> >
> > ...
> > 1) Who is moving the page the back of list ?
>
> Nobody.  The comment is wrong.
>

Sorry. The page has *already* at the back of the list. It's the very
first thing that happens:

                list_del(entry);
                list_add(entry, &inactive_list);

So the comment should read "Leave it at the back of the inactive list".

>>>>> well....list_add() moves the page to the beginning of list......

-




