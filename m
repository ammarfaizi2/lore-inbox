Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S132167AbRDOCNo>; Sat, 14 Apr 2001 22:13:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S132556AbRDOCNe>; Sat, 14 Apr 2001 22:13:34 -0400
Received: from mailf.telia.com ([194.22.194.25]:63741 "EHLO mailf.telia.com")
	by vger.kernel.org with ESMTP id <S132167AbRDOCNT>;
	Sat, 14 Apr 2001 22:13:19 -0400
Content-Type: text/plain;
  charset="iso-8859-1"
From: Roger Larsson <roger.larsson@norran.net>
To: Andre Hedrick <andre@linux-ide.org>, schwidefsky@de.ibm.com,
        george anzinger <george@mvista.com>
Subject: Re: Linux-Kernel Archive: No 100 HZ timer !
Date: Sun, 15 Apr 2001 04:10:34 +0200
X-Mailer: KMail [version 1.2]
Cc: linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.10.10104121448520.4564-100000@master.linux-ide.org>
In-Reply-To: <Pine.LNX.4.10.10104121448520.4564-100000@master.linux-ide.org>
MIME-Version: 1.0
Message-Id: <01041504103400.02781@jeloin>
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 April 2001 23:52, Andre Hedrick wrote:
> Okay but what will be used for a base for hardware that has critical
> timing issues due to the rules of the hardware?
>
> I do not care but your drives/floppy/tapes/cdroms/cdrws do:
>
> /*
>  * Timeouts for various operations:
>  */
> #define WAIT_DRQ        (5*HZ/100)      /* 50msec - spec allows up to 20ms
> */ #ifdef CONFIG_APM
> #define WAIT_READY      (5*HZ)          /* 5sec - some laptops are very
> slow */ #else
> #define WAIT_READY      (3*HZ/100)      /* 30msec - should be instantaneous
> */ #endif /* CONFIG_APM */
> #define WAIT_PIDENTIFY  (10*HZ) /* 10sec  - should be less than 3ms (?), if
> all ATAPI CD is closed at boot */ #define WAIT_WORSTCASE  (30*HZ) /* 30sec 
> - worst case when spinning up */ #define WAIT_CMD        (10*HZ) /* 10sec 
> - maximum wait for an IRQ to happen */ #define WAIT_MIN_SLEEP  (2*HZ/100)  
>    /* 20msec - minimum sleep time */
>
> Give me something for HZ or a rule for getting a known base so I can have
> your storage work and not corrupt.
>

Wouldn't it make sense to define these in real world units?
And to use that to determine requested accuracy...

Those who wait for seconds will probably not have a problem with up to (half) 
a second longer wait - or...?
Those in range of the current jiffie should be able to handle up to one 
jiffie longer...

Requesting a wait in ms gives yo ms accuracy...

/RogerL

-- 
Roger Larsson
Skellefteå
Sweden
