Return-Path: <linux-kernel-owner+willy=40w.ods.org-S964981AbWDNOyX@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964981AbWDNOyX (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 14 Apr 2006 10:54:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964984AbWDNOyX
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 14 Apr 2006 10:54:23 -0400
Received: from pproxy.gmail.com ([64.233.166.180]:59347 "EHLO pproxy.gmail.com")
	by vger.kernel.org with ESMTP id S964981AbWDNOyW convert rfc822-to-8bit
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 14 Apr 2006 10:54:22 -0400
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=JUNlDTCo7yC9SazRUuScK8R+gi3A+IK+Q1CNiPWJfQCQ5u1DUEg911gJyBmqqOLq4g4btlrhD2t+w++RBuzHTREDTO3NDAE7tBM4VDfzEFzkzggfnohWFxTEuqciIjC22aZlfENFlR1wr6Ma5krleSJnA39hGPHdkFYPi2pZv1c=
Message-ID: <728201270604140754g7bf955d6y5e06bc5ce4f86c7b@mail.gmail.com>
Date: Fri, 14 Apr 2006 09:54:21 -0500
From: "Ram Gupta" <ram.gupta5@gmail.com>
To: "Michal Schmidt" <xschmi00@stud.feec.vutbr.cz>
Subject: Re: select takes too much time
Cc: "linux-os (Dick Johnson)" <linux-os@analogic.com>,
       "linux mailing-list" <linux-kernel@vger.kernel.org>
In-Reply-To: <443EC09C.2050409@stud.feec.vutbr.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Content-Disposition: inline
References: <728201270604130801l377d7285y531133ee9ee56e8c@mail.gmail.com>
	 <443E9A17.4070805@stud.feec.vutbr.cz>
	 <728201270604131251h5296dd41o7d0e0dd8f2f1ac63@mail.gmail.com>
	 <Pine.LNX.4.61.0604131701030.7732@chaos.analogic.com>
	 <443EC09C.2050409@stud.feec.vutbr.cz>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Of course you can't get lower resolution than 1/HZ, unless you're using
> a kernel with high-res timers. It's always been like that.
> But it's not Ram's problem, because he's requesting a timeout of 90ms,
> which is much longer than one tick even with HZ=100.
>
> Michal
>

So it seems that the only solution to return back right away after
timeout is to play around with the scheduler or put the process doing
select at the front of the queue so it get a chance to run first.
Is there any other better way to do it?
