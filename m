Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132844AbRDIUqq>; Mon, 9 Apr 2001 16:46:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132845AbRDIUqh>; Mon, 9 Apr 2001 16:46:37 -0400
Received: from iris.mc.com ([192.233.16.119]:25320 "EHLO mc.com")
	by vger.kernel.org with ESMTP id <S132844AbRDIUqY>;
	Mon, 9 Apr 2001 16:46:24 -0400
From: Mark Salisbury <mbs@mc.com>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>, mbs@mc.com (Mark Salisbury)
Subject: Re: No 100 HZ timer !
Date: Mon, 9 Apr 2001 16:32:25 -0400
X-Mailer: KMail [version 1.0.29]
Content-Type: text/plain; charset=US-ASCII
Cc: jdike@karaya.com (Jeff Dike), schwidefsky@de.ibm.com,
        linux-kernel@vger.kernel.org
In-Reply-To: <E14mi1M-0002pU-00@the-village.bc.nu>
In-Reply-To: <E14mi1M-0002pU-00@the-village.bc.nu>
MIME-Version: 1.0
Message-Id: <01040916383615.01893@pc-eng24.mc.com>
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 09 Apr 2001, Alan Cox wrote:
> > this is one of linux biggest weaknesses.  the fixed interval timer is a
> > throwback.  it should be replaced with a variable interval timer with interrupts
> > on demand for any system with a cpu sane/modern enough to have an on-chip
> > interrupting decrementer.  (i.e just about any modern chip)
> 
> Its worth doing even on the ancient x86 boards with the PIT. It does require
> some driver changes since
> 
> 
> 	while(time_before(jiffies, we_explode))
> 		poll_things();
> 
> no longer works
> 

It would be great if this could be one of the 2.5 goals/projects.

it would make all sorts of fun and useful timed event services easier to
implement and provide (potentially) microsecond resolution as opposed to the
current 10Ms.

plus, we would only get one "sysclock" timer interrupt per process quantum
instead of 10.



-- 
/*------------------------------------------------**
**   Mark Salisbury | Mercury Computer Systems    **
**   mbs@mc.com     | System OS - Kernel Team     **
**------------------------------------------------**
**  I will be riding in the Multiple Sclerosis    **
**  Great Mass Getaway, a 150 mile bike ride from **
**  Boston to Provincetown.  Last year I raised   **
**  over $1200.  This year I would like to beat   **
**  that.  If you would like to contribute,       **
**  please contact me.                            **
**------------------------------------------------*/

