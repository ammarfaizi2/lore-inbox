Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932124AbWHLIyw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932124AbWHLIyw (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 12 Aug 2006 04:54:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932371AbWHLIyw
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 12 Aug 2006 04:54:52 -0400
Received: from nf-out-0910.google.com ([64.233.182.190]:25655 "EHLO
	nf-out-0910.google.com") by vger.kernel.org with ESMTP
	id S932124AbWHLIyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Sat, 12 Aug 2006 04:54:52 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=dNBOugIPfUp4Ipr/1owX9TUQqitcsDECpZyaY6EUqD2LEMr59243iEisuQYB/Adwmgut4ab3510mDeoowNBXwupt992+P/KmSQa0Gej31PZzwh5lTgsIaJi0+7Xz20Di4sCCAgfNNQye0Mx/caL2+nx3KqKvlv89WgjI/lEby5s=
Message-ID: <62b0912f0608120154s1b158732y5da52b17583fdfa0@mail.gmail.com>
Date: Sat, 12 Aug 2006 10:54:50 +0200
From: "Molle Bestefich" <molle.bestefich@gmail.com>
To: "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: ext3 corruption
In-Reply-To: <200608111326.k7BDQ7fp004102@laptop13.inf.utfsm.cl>
MIME-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
References: <17627.23159.236724.190546@stoffel.org>
	 <200608111326.k7BDQ7fp004102@laptop13.inf.utfsm.cl>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Horst H. von Brand wrote:
> The kernel people are certainly not infallible either. And there are cases
> where the right order is A B C, and others in which it is C B A, and still
> others where it doesn't matter.

In the quite unlikely situation where that happens, you've obviously
got a piece of software which is broken dependency-wise.  Many of the
current schemes will fail to accommodate that too.

For example, no amount of moving the /etc/rc.d/rc6.d/K35smb script
around will fix that situation on Red Hat.

A solution to your example is to fix two of the three broken pieces of
software by splitting B into B1 and B2, and either A or C into their
components likewise:

A1 --> B1 --> C --> B2 --> A2

 -or-

C1 --> B1 --> A --> B2 --> C2

> No way to get it right always.

Your example did in no way prove that, so thus far that statement is not true.

> In any case, this is wildly off-topic for a list on /kernel/ development.
> Better locate a Linux User Group near you, look for mailing lists on running
> Linux, trawl Usenet for a group with acceptable signal/noise ratio.

I did mention that:

> > Anyway, let's all forget about the init scripts forthwith, they're
> > not really relevant for LKML I think.

And:

> > Concentrate on the ext3 issue :-).

And my next posting was about ext3 again.
