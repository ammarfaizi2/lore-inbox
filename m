Return-Path: <linux-kernel-owner@vger.kernel.org>
thread-index: AcQVpHw6vY/xE+xRQtSXNEKlTruR6g==
Envelope-to: paul@sumlocktest.fsnet.co.uk
Delivery-date: Sun, 04 Jan 2004 14:58:22 +0000
Message-ID: <01f601c415a4$7c3a9390$d100000a@sbs2003.local>
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft CDO for Exchange 2000
Date: Mon, 29 Mar 2004 16:42:47 +0100
From: "Pavel Machek" <pavel@ucw.cz>
Content-Class: urn:content-classes:message
To: <Administrator@smtp.paston.co.uk>
Importance: normal
Priority: normal
X-MimeOLE: Produced By Microsoft MimeOLE V6.00.3790.0
Cc: "Srivatsa Vaddagiri" <vatsa@in.ibm.com>,
        "Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        <manfred@colorfullife.com>, <rusty@au1.ibm.com>,
        "Andrew Morton" <akpm@osdl.org>
Subject: Re: BUG in x86 do_page_fault?  [was Re: in_atomic doesn't count local_irq_disable?]
References: <3FF044A2.3050503@colorfullife.com> <20031230185615.A9292@in.ibm.com> <20031231185959.A9041@in.ibm.com> <Pine.LNX.4.58.0312311104180.2065@home.osdl.org>
MIME-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.58.0312311104180.2065@home.osdl.org>
X-Warning: Reading this can be dangerous to your mental health.
User-Agent: Mutt/1.5.4i
Sender: <linux-kernel-owner@vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org
X-OriginalArrivalTime: 29 Mar 2004 15:42:48.0828 (UTC) FILETIME=[7CF223C0:01C415A4]

Hi!

> > 	in_atomic() doesn't seem to return true
> > in code sections where IRQ's have been disabled (using 
> > local_irq_disable).
> > 
> > As a result, I think do_page_fault() on x86 needs to 
> > be updated to note this fact:
> 
> NO. 
> 
> Please don't do this, it will result in some _really_ nasty problems with 
> X and other programs that potentially disable interrupts in user
> space.

If user program causes page fault with interrupts disabled, it is
certainly buggy, right?

Either the user program does not really need irq disabled or it does
need that but page fault just broke its guarantees (=> severe problems
ahead).

In both cases there's user program that needs fixing.
								Pavel
-- 
When do you have a heart between your knees?
[Johanka's followup: and *two* hearts?]
