Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S275601AbRJBQ5l>; Tue, 2 Oct 2001 12:57:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S275682AbRJBQ5W>; Tue, 2 Oct 2001 12:57:22 -0400
Received: from vasquez.zip.com.au ([203.12.97.41]:31504 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S275601AbRJBQ5R>; Tue, 2 Oct 2001 12:57:17 -0400
Message-ID: <3BB9F1F2.B6873DFD@zip.com.au>
Date: Tue, 02 Oct 2001 09:57:22 -0700
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.9-ac12 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Lorenzo Allegrucci <lenstra@tiscalinet.it>
CC: linux-kernel@vger.kernel.org
Subject: Re: Huge console switching lags
In-Reply-To: <3.0.6.32.20011002111131.02693d90@pop.tiscalinet.it>
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Lorenzo Allegrucci wrote:
> 
> I've experienced huge (4/5 seconds) console switching lags with
> 2.4.10 running this [1], never seen before with any kernel.

In 2.4.10, the console switching code moved from interrupt context
into process context.  So if your system is taking a long time to
schedule processes (in this case, keventd) then yes, console
switching will take a long time.

> 2.4.10-ac2 is even worse, it can take up to 10/20 seconds and longer
> to switch from a console to another (CTRL+F1,F2 etc) while running
> the beast below:
> 
> [1]
> #!/bin/sh
> bomb(){bomb|bomb&};bomb
> 

The simple ones are always the best ones, aren't they?

-
