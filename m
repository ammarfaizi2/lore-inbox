Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287629AbRLaTxJ>; Mon, 31 Dec 2001 14:53:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287627AbRLaTwu>; Mon, 31 Dec 2001 14:52:50 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:61714 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S287624AbRLaTwn>; Mon, 31 Dec 2001 14:52:43 -0500
Message-ID: <3C30C131.52584954@zip.com.au>
Date: Mon, 31 Dec 2001 11:49:05 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.17-pre8 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: alad@hss.hns.com, linux-kernel@vger.kernel.org
Subject: Re: locked page handling
In-Reply-To: <65256B33.0039476C.00@sandesh.hss.hns.com> <3C30BE70.6E5E95CE@zip.com.au>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

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

-
