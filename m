Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261399AbVFNCUe@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261399AbVFNCUe (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 13 Jun 2005 22:20:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261407AbVFNCUe
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 13 Jun 2005 22:20:34 -0400
Received: from smtp208.mail.sc5.yahoo.com ([216.136.130.116]:12464 "HELO
	smtp208.mail.sc5.yahoo.com") by vger.kernel.org with SMTP
	id S261399AbVFNCU1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 13 Jun 2005 22:20:27 -0400
Message-ID: <42AE3EE2.9020002@yahoo.com.au>
Date: Tue, 14 Jun 2005 12:20:18 +1000
From: Nick Piggin <nickpiggin@yahoo.com.au>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.7.6) Gecko/20050324 Debian/1.7.6-1
X-Accept-Language: en
MIME-Version: 1.0
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
CC: Ondrej Zary <linux@rainbow-software.org>,
       Grant Coady <grant_lkml@dodo.com.au>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Odd IDE performance drop 2.4 vs 2.6?
References: <ac0qa19omlt7bsh8mcfsfr2uhshk338f0c@4ax.com>	 <42AD6362.1000109@rainbow-software.org>	 <1118669975.13260.23.camel@localhost.localdomain>	 <42AD92F2.7080108@yahoo.com.au> <1118675343.13773.1.camel@localhost.localdomain>
In-Reply-To: <1118675343.13773.1.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Alan Cox wrote:

>On Llu, 2005-06-13 at 15:06, Nick Piggin wrote:
>
>>>Make sure you have pre-empt disabled and the antcipatory I/O scheduler
>>>disabled. 
>>>
>>>
>>I don't think that those could explain it.
>>
>
>Try it and see. The anticipatory I/O scheduler does horrible things to
>my IDE streaming performance numbers and to swap performance. It tries
>to merge I/O by delaying it which is deeply ungood when it comes to IDE
>streaming even if its good for general I/O.
>
>
Sure it has regression cases here and there, as you would expect.
But I'm fairly sure this won't be one of them. If there is just a
single process submitting the IO the anticipatory scheduler should
completely turn of any delays, and degenerate basically to the
deadline scheduler.


Send instant messages to your online friends http://au.messenger.yahoo.com 
