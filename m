Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263533AbTDMPHw (for <rfc822;willy@w.ods.org>); Sun, 13 Apr 2003 11:07:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S263538AbTDMPHw (for <rfc822;linux-kernel-outgoing>);
	Sun, 13 Apr 2003 11:07:52 -0400
Received: from ms-smtp-01.tampabay.rr.com ([65.32.1.43]:7051 "EHLO
	ms-smtp-01.tampabay.rr.com") by vger.kernel.org with ESMTP
	id S263533AbTDMPHv (for <rfc822;linux-kernel@vger.kernel.org>); Sun, 13 Apr 2003 11:07:51 -0400
Message-ID: <000901c301d0$e3223100$6801a8c0@epimetheus>
From: "Timothy Miller" <tmiller10@cfl.rr.com>
To: "Nick Piggin" <piggin@cyberone.com.au>
Cc: <linux-kernel@vger.kernel.org>
References: <001301c30145$5ff85fb0$6801a8c0@epimetheus> <3E994F06.2000402@cyberone.com.au>
Subject: Re: Benefits from computing physical IDE disk geometry?
Date: Sun, 13 Apr 2003 11:25:15 -0400
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
X-Priority: 3
X-MSMail-Priority: Normal
X-Mailer: Microsoft Outlook Express 6.00.2720.3000
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.2600.0000
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


From: "Nick Piggin" <piggin@cyberone.com.au>


> The benefit I see is knowing the seek time itself (not geometry), which
> can be used to tune the IO scheduler. This is something that I'll
> probably need to do (in kernel) in order to get my IO scheduler in 2.6,
> as it probably (not tested yet) has bad failure cases on high seek time
> devices like CDROMs.

Well, that IS the heart of the matter, really.  Detecting geometry was only
a means to the end of predicting seek time and rotational latency.  If you
could magically predict the seek time between any two accesses, then you
could sort your queue optimally.  What would be able to do that?  A neural
net?  :)  What would be able to do that without a lot of training time?

Personally, I've been excited about AS, and I would hate to see it not get
in.



