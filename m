Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1161229AbVIPSbQ@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161229AbVIPSbQ (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 16 Sep 2005 14:31:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161249AbVIPSbP
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 16 Sep 2005 14:31:15 -0400
Received: from smtpout.mac.com ([17.250.248.89]:52443 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1161228AbVIPSbN (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Fri, 16 Sep 2005 14:31:13 -0400
In-Reply-To: <Pine.LNX.4.61.0509161133410.2041@chaos.analogic.com>
References: <a5986103050915004846d05841@mail.gmail.com> <1e62d137050915010361d10139@mail.gmail.com> <a598610305091505184a8aa8fd@mail.gmail.com> <1e62d13705091508391832f897@mail.gmail.com> <87mzmduq1h.fsf@amaterasu.srvr.nix> <1126879660.3103.6.camel@localhost.localdomain> <87irx1ujc0.fsf@amaterasu.srvr.nix> <Pine.LNX.4.61.0509161133410.2041@chaos.analogic.com>
Mime-Version: 1.0 (Apple Message framework v734)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <5162CC44-37D0-4FEB-ADC6-887F6FC3C3BA@mac.com>
Cc: Nix <nix@esperi.org.uk>, arjanv@redhat.com, linux-kernel@vger.kernel.org,
       ivan.korzakow@gmail.com, fawadlateef@gmail.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: best way to access device driver functions
Date: Fri, 16 Sep 2005 14:30:39 -0400
To: "linux-os (Dick Johnson)" <linux-os@analogic.com>
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 16, 2005, at 12:02:59, linux-os (Dick Johnson) wrote:
> Somebody reported to me that there was some special "optimization"  
> in Linux that interpreted ioctl() function calls without regard to  
> the specific device that was open (gawd I hope not), and that if  
> you used "already-used" function numbers for your device-specific  
> ioctl(), then strange things would occur.

IIRC, that used to be the case, but isn't anymore.

> However, the kernel is now LOCKED during an ioctl() call. Older  
> Linux versions didn't lock the kernel. The upshotof this is that if  
> you have some ioctl() function that takes some time, like testing  
> the memory in your board, you will find the system unresponsive  
> during that test! You can unlock the kernel in your ioctl() if this  
> is a problem.

This is *completely* wrong.  The kernel used to lock_kernel() for  
*every* ioctl.  Recent changes added locked and unlocked ioctls, such  
that ioctls that do not need the BKL can ignore it completely.  You  
claimed to have read the code, given this typical Wrongbot statement,  
I guess I can say for sure that you didn't.

Cheers,
Kyle Moffett

--
Premature optimization is the root of all evil in programming
   -- C.A.R. Hoare

PS:  Use a different email service!  Your "I tried to kill it with  
the above dot" and bullshit apology is worth zilch.  A quick  
calculation shows that over the last month and a half, you have
sent 76 or so emails to the list, all of which have contained your  
useless 663-byte corporate message, meaning you have sent 50K of spam  
to the list over that time period, which has been distributed to  
several thousand accounts by vger, resulting in probably over 100MB  
of spam over that time period.  Fix it or use a different email account!

I am not the intended recipient for the following email text.  I will  
destroy all copies of this information, including further copies of  
it, because I am not the intended recipient of those either.  Plonk!
> .
> I apologize for the following. I tried to kill it with the above dot :
>
> ****************************************************************
> The information transmitted in this message is confidential and may  
> be privileged.  Any review, retransmission, dissemination, or other  
> use of this information by persons or entities other than the  
> intended recipient is prohibited.  If you are not the intended  
> recipient, please notify Analogic Corporation immediately - by  
> replying to this message or by sending an email to  
> DeliveryErrors@analogic.com - and destroy all copies of this  
> information, including any attachments, without reading or  
> disclosing them.
>
> Thank you.

