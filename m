Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263917AbRFJN57>; Sun, 10 Jun 2001 09:57:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S263926AbRFJN5t>; Sun, 10 Jun 2001 09:57:49 -0400
Received: from [32.97.182.102] ([32.97.182.102]:55792 "EHLO e2.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S263917AbRFJN5j>;
	Sun, 10 Jun 2001 09:57:39 -0400
Importance: Normal
Subject: Re: Please test: workaround to help swapoff behaviour
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Marcelo Tosatti <marcelo@conectiva.com.br>,
        Mike Galbraith <mikeg@wen-online.de>,
        Derek Glidden <dglidden@illusionary.com>,
        lkml <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        Stephen Tweedie <sct@redhat.com>
X-Mailer: Lotus Notes Release 5.0.3 (Intl) 21 March 2000
Message-ID: <OF083B7070.89B5A2B7-ON85256A67.004AD50A@pok.ibm.com>
From: "Bulent Abali" <abali@us.ibm.com>
Date: Sun, 10 Jun 2001 09:56:04 -0400
X-MIMETrack: Serialize by Router on D01ML233/01/M/IBM(Build V508_06042001 |June 4, 2001) at
 06/10/2001 09:55:06 AM
MIME-Version: 1.0
Content-type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org



>The fix is to kill the dead/orphaned swap pages before we get to
>swapoff.  At shutdown time there is practically nothing active in
> ...
>Once the dead swap pages problem is fixed it is time to optimize
>swapoff.

I think fixing the orphaned swap pages problem will eliminate the
problem all together.  Probably there is no need to optimize
swapoff.

Because as the system is shutting down all the processes will be
killed and their pages in swap will be orphaned. If those pages
were to be reaped in a timely manner there wouldn't be any work
left for swapoff.

Bulent


