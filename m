Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290746AbSARQrL>; Fri, 18 Jan 2002 11:47:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290745AbSARQrC>; Fri, 18 Jan 2002 11:47:02 -0500
Received: from smtp1.vol.cz ([195.250.128.73]:11275 "EHLO smtp1.vol.cz")
	by vger.kernel.org with ESMTP id <S290741AbSARQqn>;
	Fri, 18 Jan 2002 11:46:43 -0500
Date: Fri, 11 Jan 2002 23:36:22 +0000
From: Pavel Machek <pavel@suse.cz>
To: Steve Whitehouse <Steve@ChyGwyn.com>
Cc: Luc Robalo Marques <robalomarquesl@yahoo.com>,
        linux-kernel@vger.kernel.org
Subject: Re: nbd request too big
Message-ID: <20020111233621.D260@toy.ucw.cz>
In-Reply-To: <20020107152423.78321.qmail@web14906.mail.yahoo.com> <200201071538.PAA28211@gw.chygwyn.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
X-Mailer: Mutt 1.0.1i
In-Reply-To: <200201071538.PAA28211@gw.chygwyn.com>; from steve@gw.chygwyn.com on Mon, Jan 07, 2002 at 03:38:29PM +0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi!

> I presume you are using Pavel's server from his web page ? You need to increase
> the buffer size that the server uses. This happens as a result of the change
> a little while ago of nbd to use the elevator to merge requests at the nbd
> client end. If memory serves the maximum size of request is sizeof(header) +
> 128 * block_size, so you need to alter the server to use that size.
> 
> You'll find the buffer size in the main loop of the mainloop() function
> char buf[20480]; needs increasing (to (131072 + 28) for 1k blocks for example)
> and also you'll need to increase the value here (to 131072 in this example):
> 
>                 if (len > 10240)
>                         err("Request too big!");

Thanx for explanation and would-be patch. I'll apply it into CVS.

Perhaps have acount on sourceforge and you want write access to the CVS?

								Pavel
-- 
Philips Velo 1: 1"x4"x8", 300gram, 60, 12MB, 40bogomips, linux, mutt,
details at http://atrey.karlin.mff.cuni.cz/~pavel/velo/index.html.

