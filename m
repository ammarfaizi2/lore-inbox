Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289878AbSAKFFH>; Fri, 11 Jan 2002 00:05:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289879AbSAKFE5>; Fri, 11 Jan 2002 00:04:57 -0500
Received: from gear.torque.net ([204.138.244.1]:12294 "EHLO gear.torque.net")
	by vger.kernel.org with ESMTP id <S289878AbSAKFEk>;
	Fri, 11 Jan 2002 00:04:40 -0500
Message-ID: <3C3E721F.5E453DC2@torque.net>
Date: Fri, 11 Jan 2002 00:03:27 -0500
From: Douglas Gilbert <dougg@torque.net>
X-Mailer: Mozilla 4.78 [en] (X11; U; Linux 2.5.2-pre10 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Dima Brodsky <dima@cs.ubc.ca>
CC: linux-kernel@vger.kernel.org
Subject: Re: Unable to burn CDs on 2.4.17
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Dima Brodsky <dima@cs.ubc.ca> wrote:

> Since about 2.4.9 I have not been able to burn CDs. 
> I get the following message in the logs.

<snip/>

Since you are using an ATAPI cd writer, try turning off
(or lowering) DMA on that device.

Try either one of these (assuming you cd writer is on /dev/hdd):
    hdparm -d0 -c1 /dev/hdd 
    hdparm -d 1 -X 34 /dev/hdd

Doug Gilbert
