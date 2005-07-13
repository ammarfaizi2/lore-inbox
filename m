Return-Path: <linux-kernel-owner+willy=40w.ods.org-S262228AbVGMAwN@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262228AbVGMAwN (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 12 Jul 2005 20:52:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262538AbVGMAvy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 12 Jul 2005 20:51:54 -0400
Received: from out2.smtp.messagingengine.com ([66.111.4.26]:42139 "EHLO
	out2.smtp.messagingengine.com") by vger.kernel.org with ESMTP
	id S262512AbVGMAuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 12 Jul 2005 20:50:46 -0400
X-Sasl-enc: /DPuYHEYWCkd4+u1oD4tjpVxQ09whBbUthzQVcCRGHUD 1121215842
Message-ID: <03b601c58744$ee69e390$7c00a8c0@ROBMHP>
From: "Rob Mueller" <robm@fastmail.fm>
To: "Chris Mason" <mason@suse.com>, <akpm@osdl.org>
Cc: "Lars Roland" <lroland@gmail.com>, "Bron Gondwana" <brong@fastmail.fm>,
       <linux-kernel@vger.kernel.org>, "Vladimir Saveliev" <vs@namesys.com>,
       "Jeremy Howard" <jhoward@fastmail.fm>
References: <01dd01c586c3$cdd525d0$7c00a8c0@ROBMHP> <4ad99e0505071209372176f625@mail.gmail.com> <039301c58741$a4df9fb0$7c00a8c0@ROBMHP> <200507122042.11397.mason@suse.com>
Subject: Re: 2.6.12.2 dies after 24 hours
Date: Wed, 13 Jul 2005 10:50:51 +1000
MIME-Version: 1.0
Content-Type: text/plain;
	format=flowed;
	charset="iso-8859-1";
	reply-type=original
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2900.2527
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2900.2527
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


> There is a much less complex solution that I've just recently gotten 
> working
> in the SUSE kernel.  If reiser3/ext3 don't log the inode during atime
> updates, the problem goes away.
>
> You can solve this now by mounting with -o noatime (although that might 
> not
> play well with cyrus, not sure).  My current patch works around this in 
> ugly
> ways, what I plan on doing during OLS is finding out why ext3 is still
> logging the inode all the time.

Well we have always mounted our cyrus filesystems with:

noatime,nodiratime,notail

And the problem was occuring all the time with these mount options. We've 
since also added on your suggestion nolargeio=1 and used the patch Vladimir 
created. I'm not sure which of those fixed the problem, but it definitely 
has not occured since we did those last 2 things.

Are you saying that if you mount with noatime *and* use your new patch it 
will fix the problem?

What about the 2 threads linked to. Did those end up getting anywhere?

> http://www.ussg.iu.edu/hypermail/linux/kernel/0409.0/2056.html
> http://hulllug.principalhosting.net/archive/index.php/t-22774.html

Rob

