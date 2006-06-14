Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751241AbWFNIHZ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751241AbWFNIHZ (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 14 Jun 2006 04:07:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751180AbWFNIHY
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 14 Jun 2006 04:07:24 -0400
Received: from mta09-winn.ispmail.ntl.com ([81.103.221.49]:17763 "EHLO
	mtaout03-winn.ispmail.ntl.com") by vger.kernel.org with ESMTP
	id S1751091AbWFNIHX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 14 Jun 2006 04:07:23 -0400
Message-ID: <448FC429.4060004@gentoo.org>
Date: Wed, 14 Jun 2006 09:09:13 +0100
From: Daniel Drake <dsd@gentoo.org>
User-Agent: Thunderbird 1.5.0.4 (X11/20060603)
MIME-Version: 1.0
To: Mark Lord <lkml@rtr.ca>
CC: John Heffner <jheffner@psc.edu>, Linus Torvalds <torvalds@osdl.org>,
       Linux Kernel <linux-kernel@vger.kernel.org>, netdev@vger.kernel.org,
       davem@davemloft.net
Subject: Re: 2.6.17: networking bug??
References: <448EC6F3.3060002@rtr.ca> <448ECB09.3010308@rtr.ca> <448ED2FC.2040704@rtr.ca> <448ED9B3.8050506@rtr.ca> <448EEE9D.10105@rtr.ca> <448EF45B.2080601@rtr.ca> <448EF85E.50405@psc.edu> <Pine.LNX.4.64.0606131048550.5498@g5.osdl.org> <448F0344.9000008@rtr.ca> <448F0D4B.30201@rtr.ca>
In-Reply-To: <448F0D4B.30201@rtr.ca>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mark Lord wrote:
> Further to this, the current behaviour is badly unpredictable.
> 
> A machine could be working perfectly, not (noticeably) affected
> by this bug.  And then the user adds another stick of RAM to it.

This "bug" already existed in 2.6.16 to a certain extent: you were 
losing out on a lot of TCP performance. Go back to 2.6.7, measure TCP 
performance, and you'll probably find it was significantly better.

Also, there aren't that many broken end-points out there. 
www.everymac.com loads fine for me and does not ignore the window scale 
factor.

The problem in your case is a broken router in the middle. I had the 
same problem: certain sites would not load, but there is absolutely 
nothing wrong with the servers that run these sites:

http://marc.theaimsgroup.com/?l=linux-netdev&m=114478312100641&w=2

I contacted my ISP and informed them of the issue. They fixed it 
nationwide within a few weeks. You might try confirming that your 
problem only applies to HTTP like mine did (ISP runs some lame 
transparent webcaches), and it was a bug in the software there (NetApp).

We already had the "some routers are broken, should we do anything" 
discussion back at the time of 2.6.8:

http://lwn.net/Articles/92727/

Daniel

