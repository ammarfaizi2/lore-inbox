Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S313317AbSDEUOE>; Fri, 5 Apr 2002 15:14:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S313479AbSDEUNy>; Fri, 5 Apr 2002 15:13:54 -0500
Received: from line106-150.adsl.actcom.co.il ([192.117.106.150]:18058 "HELO
	mail.bard.org.il") by vger.kernel.org with SMTP id <S313317AbSDEUNg>;
	Fri, 5 Apr 2002 15:13:36 -0500
Date: Fri, 5 Apr 2002 23:13:27 +0300
From: "Marc A. Volovic" <marc@bard.org.il>
To: Albert Max Lai <amlai@bitsorcery.com>
Cc: "Marc A. Volovic" <marc@bard.org.il>, linux-kernel@vger.kernel.org
Subject: Re: 2.4.x and DAC960 issues
Message-ID: <20020405201327.GA20807@glamis.bard.org.il>
In-Reply-To: <15533.14286.502083.225297@bitsorcery.com> <20020405182731.GA20224@glamis.bard.org.il> <15533.61664.984655.18344@bitsorcery.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.3.28i
X-Operating-System: Linux glamis.bard.org.il 2.4.19-pre5
X-message-flag: 'Oi! Muy Importante! Get yourself a real email client. http://www.mutt.org/'
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Albert Max Lai said:

> On Friday, 5 April 2002, Marc A. Volovic wrote:
> > What is your interrupt breakdown? Could your machine be doing something
> > naughty with the interrupts?
> 
>            CPU0       CPU1       
>   9:     128424          0          XT-PIC  aic7xxx, aic7xxx
>  10:      52035          0          XT-PIC  Mylex DAC1164P
[snips]

Ouch, this does not look healthy. You're at 'noapic'? Seems so.

Mine is:
           CPU0       CPU1       
 17:         22         17   IO-APIC-level  BusLogic BT-958
 18:      83988      84319   IO-APIC-level  Mylex AcceleRAID 160

However, I can see no indication for misbehaviour. Let's take it off 
the list. Can you send me a driver startup dmesg?


---MAV
                       Linguists Do It Cunningly
Marc A. Volovic                                          marc@bard.org.il
