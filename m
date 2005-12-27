Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932276AbVL0JFs@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932276AbVL0JFs (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 27 Dec 2005 04:05:48 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932275AbVL0JFs
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 27 Dec 2005 04:05:48 -0500
Received: from mail28.syd.optusnet.com.au ([211.29.133.169]:34708 "EHLO
	mail28.syd.optusnet.com.au") by vger.kernel.org with ESMTP
	id S932276AbVL0JFr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 27 Dec 2005 04:05:47 -0500
From: Con Kolivas <kernel@kolivas.org>
To: "lk" <linux_kernel@patni.com>
Subject: Re: something about jiffies wraparound overflow
Date: Tue, 27 Dec 2005 20:05:21 +1100
User-Agent: KMail/1.9
Cc: "jeff shia" <tshxiayu@gmail.com>, linux-kernel@vger.kernel.org,
       "robert love" <rml@novell.com>
References: <7cd5d4b40512262046w6f7a8161jfaf1e618e5722b4@mail.gmail.com> <003201c60ac3$16692d90$5e91a8c0@patni.com>
In-Reply-To: <003201c60ac3$16692d90$5e91a8c0@patni.com>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200512272005.22440.kernel@kolivas.org>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday 27 December 2005 19:54, lk wrote:
> As you mentioned the code for comparison:
> > /* code 2*/
> > unsigned long timeout = jiffies + HZ/2;
>
> the code has no problem with jiffies wrapping around
> as long as the values are compared in a right way.
> For a 32 bit platform the counter wraps around only once every 50 day
> when the value of HZ 1000. so if your code is prepared to face this event
> it will work fine.

In 2.6 we actually roll over 5 minutes after starting (the jiffy counter is 
set to about 5 minutes from roll over); that was put in on purpose to pick up 
wraparound bugs easily.

Cheers,
Con
