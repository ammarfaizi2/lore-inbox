Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261651AbVGKM1S@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261651AbVGKM1S (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 11 Jul 2005 08:27:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261656AbVGKM1R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 11 Jul 2005 08:27:17 -0400
Received: from [210.76.108.236] ([210.76.108.236]:51656 "EHLO ccoss.com.cn")
	by vger.kernel.org with ESMTP id S261651AbVGKM1Q (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Mon, 11 Jul 2005 08:27:16 -0400
Message-ID: <42D268F7.2060108@ccoss.com.cn>
Date: Mon, 11 Jul 2005 20:41:27 +0800
From: "liyu@WAN" <liyu@ccoss.com.cn>
User-Agent: Mozilla Thunderbird 1.0.2 (X11/20050317)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: LKML <linux-kernel@vger.kernel.org>
Subject: I have one doubt about detail of page reclaim.
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, everyone on LKML.

    This is my fourth or fifth send mail to this list. Of course, almost 
all mail are submit question.
and lucky, can get answers soon. thank that every man that reply my 
question.
   
    I understand some kernel skills while I resolved one question. this 
process is so fun.

    OK, the question at this time:

    I am reading code of function balabce_pgdat(pg_data_t *pgdat, int 
nr_pages, int order).

    As the comment said, the argument 'nr_free' is how many pages to 
free when software suspending .
In that function, define a int variable 'to_free' first, and it is 
assigned to value of 'nr_pages'.
but I found both two variables (to_free and nr_pages) didn't change in 
this function at all, then,
Why define variable to_free? And, in middle of this function, there have 
one if condtion statement
as follow:

        if (nr_pages && to_free > total_reclaimed)
            continue;    /* swsusp: need to do more work */

    It's look like to guaruatee release enough pages to satisfy reqire 
of software suspend. but as
my view, 'nr_pages' and 'to_free' must have same value in this function.
   
    Do here have secret too?

    Waiting for magical answer.




                                                                         
      liyu/NOW~

   
   

   

