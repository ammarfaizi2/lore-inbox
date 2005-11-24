Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932627AbVKXJ6H@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932627AbVKXJ6H (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 24 Nov 2005 04:58:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932628AbVKXJ6G
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 24 Nov 2005 04:58:06 -0500
Received: from mtagate2.de.ibm.com ([195.212.29.151]:48339 "EHLO
	mtagate2.de.ibm.com") by vger.kernel.org with ESMTP id S932627AbVKXJ6F
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 24 Nov 2005 04:58:05 -0500
In-Reply-To: <200511242041.00586.kernel@kolivas.org>
Subject: Re: Inconsistent timing results of multithreaded program on an SMP machine.
To: Con Kolivas <kernel@kolivas.org>
Cc: linux-kernel@vger.kernel.org, Muli Ben-Yehuda <mulix@mulix.org>
X-Mailer: Lotus Notes Release 6.5.1 January 21, 2004
Message-ID: <OF7B1C41C0.7F24B72C-ONC22570C3.003663BE-C22570C3.0036F687@il.ibm.com>
From: Marcel Zalmanovici <MARCEL@il.ibm.com>
Date: Thu, 24 Nov 2005 12:00:20 +0200
X-MIMETrack: Serialize by Router on D12ML102/12/M/IBM(Release 6.5.1| March 5, 2004) at
 24/11/2005 11:58:00
MIME-Version: 1.0
Content-type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

                                                                                                                                   
                      Con Kolivas                                                                                                  
                      <kernel@kolivas.o        To:       Marcel Zalmanovici/Haifa/IBM@IBMIL                                        
                      rg>                      cc:       linux-kernel@vger.kernel.org, Muli Ben-Yehuda <mulix@mulix.org>           
                                               Subject:  Re: Inconsistent timing results of multithreaded program on an SMP        
                      24/11/2005 11:40          machine.                                                                           
                                                                                                                                   
                                                                                                                                   
                                                                                                                                   










On Thu, 24 Nov 2005 19:33, Marcel Zalmanovici wrote:
> Hi Con,
>
> I've tried the pthread_join theory.
> pthread_join completes very fast, no evidence on it being the perpetrator
> here.
>
> I've ran your ps -... idea in a different term window every ms while the
> test was running. It created a large file so I won't mail it to you, but
> both me and Muli observed that once the thread ends it quickly disappears
> from the ps list.
>
> I've also ran Muli's idea and added gettimeofday calls.
> Here's the altered code and output:
>
> (See attached file: idle.log)(See attached file: sched_test.c)
>
> As you can see, if a thread already finished pthread_join returns in a
> split second.
>
> Any other ideas are welcome :-)

Profile the actual application?

Well, technically, this IS the actual application. Ultimately, I would like
to make some changes to the kernel in order to reduce the cache misses and
maybe improve run time as a consequence.
Having results spread out as much as I get, it would be very difficult, if
not impossible for me to estimate if my algorithm conveyed any real
results.

I have profiled (time ticks and L2 cache misses) the example I've posted
and a few other variations on the example, but haven't seen nothing out of
the ordinary.
Around 98-99% of time and misses are at the inner loop of the example.

Is there anything else I can check with profile that may help me understand
the phenomenon ?

> P.S. - I agree that Lotus isn't ideal for this kind of conversations, but
> that's what IBM is using.

It was tongue in cheek ;) Well that should still not stop you from replying

below the original thread.

Cheers,
Con


