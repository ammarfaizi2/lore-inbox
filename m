Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S136137AbRARWuc>; Thu, 18 Jan 2001 17:50:32 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S136157AbRARWuW>; Thu, 18 Jan 2001 17:50:22 -0500
Received: from monza.monza.org ([209.102.105.34]:25359 "EHLO monza.monza.org")
	by vger.kernel.org with ESMTP id <S136156AbRARWuS>;
	Thu, 18 Jan 2001 17:50:18 -0500
Date: Thu, 18 Jan 2001 14:50:01 -0800
From: Tim Wright <timw@splhi.com>
To: Matthias Schniedermeyer <ms@citd.de>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Mainboard with Serverworks HE Chipset
Message-ID: <20010118145001.B7612@scutter.sequent.com>
Reply-To: timw@splhi.com
Mail-Followup-To: Matthias Schniedermeyer <ms@citd.de>,
	linux-kernel@vger.kernel.org
In-Reply-To: <Pine.LNX.4.20.0101170020001.811-100000@citd.owl.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <Pine.LNX.4.20.0101170020001.811-100000@citd.owl.de>; from ms@citd.de on Wed, Jan 17, 2001 at 12:33:09AM +0100
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 17, 2001 at 12:33:09AM +0100, Matthias Schniedermeyer wrote:
> #include <hallo.h>
> 
> 
> 
> I got a "Tyan Thunder HE-SL"-Mainboard today, which has a "Severworks
> ServerSet III HE"-Chipset. (2xPIII 933, 2x512MB PC133 ECC-Registered
> SDRAM)
> 
> And i have one problem and one question.
> 
> First the question. I have an uptime of phenomenal 29minutes and "cat
> /proc/interrupts" tells me this
> 
> NMI:     175819     175819
> LOC:     175829     175828
> 
> Should i be worried? Or can i ignore it. With my former Mainboard NMI was
> (AFAIR) always 0.
> 
> Now my problem.
> 
> The Graphic-Card is a Geforce 2, Xfree is 4.02 (compiled under 2.2.17).
> 
> When i start X, everything is fine. When i go back to text-console and
> wait "some time" and then switch back to X the computer locks solid and i
> have to press the Big-Red Button. (Switching back to X after a "short"
> periode of time, at the text-console, works "normaly")
> 
> If anyone needs more information, i will happily provide them.
> 

You could try booting with 'nmi_watchdog=0' and see what happens.
What you describe sounds like the problem I have seen on a few boxes, and
disabling the NMI watchdog makes the huge numbers of NMIs and the system
hang go away. Still unclear why this is happening.

Tim

-- 
Tim Wright - timw@splhi.com or timw@aracnet.com or twright@us.ibm.com
IBM Linux Technology Center, Beaverton, Oregon
Interested in Linux scalability ? Look at http://lse.sourceforge.net/
"Nobody ever said I was charming, they said "Rimmer, you're a git!"" RD VI
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
