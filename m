Return-Path: <linux-kernel-owner+willy=40w.ods.org-S1751549AbVLAD6v@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751549AbVLAD6v (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 30 Nov 2005 22:58:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751414AbVLAD6v
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 30 Nov 2005 22:58:51 -0500
Received: from smtpout.mac.com ([17.250.248.84]:40929 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S1751549AbVLAD6u (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 30 Nov 2005 22:58:50 -0500
In-Reply-To: <Pine.LNX.4.61.0512010118200.1609@scrub.home>
References: <1133395019.32542.443.camel@tglx.tec.linutronix.de> <Pine.LNX.4.61.0512010118200.1609@scrub.home>
Mime-Version: 1.0 (Apple Message framework v746.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <23CA09D3-4C11-4A4B-A5C6-3C38FA9C203D@mac.com>
Cc: Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org,
       akpm@osdl.org, mingo@elte.hu, george@mvista.com, johnstul@us.ibm.com
Content-Transfer-Encoding: 7bit
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: [patch 00/43] ktimer reworked
Date: Wed, 30 Nov 2005 22:57:02 -0500
To: Roman Zippel <zippel@linux-m68k.org>
X-Mailer: Apple Mail (2.746.2)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Nov 30, 2005, at 22:32, Roman Zippel wrote:
> On Thu, 1 Dec 2005, Thomas Gleixner wrote:
>> but what we'd like to achieve as an end-result is the clear  
>> separation of 'timer' vs. 'timeout' APIs. Our proposed end result  
>> would be to have 'struct ktimer' for timers, and 'struct ktimeout'  
>> for timeouts.
>
> Sorry, but calling it "ktimeout" would be completely wrong.
>
> "timeout" is a rather imprecise term, which can have different  
> meanings depending on the context, e.g. any timer usually has a  
> "timeout value", but what is meant here is a "timeout timer". So  
> basically this is supposed to be about "timer" vs "timeout timer".
> [snip lengthy discussion]

If I recall correctly, this whole naming mess has been discussed to  
death before, with the result that almost everybody but Roman thought  
the names were perfectly clear such that a timer is _expected_ to  
expire and a timeout is not, therefore timers should be optimized for  
add=>run=>expire and timeouts optimized for add=>run=>remove.

Cheers,
Kyle Moffett

-----BEGIN GEEK CODE BLOCK-----
Version: 3.12
GCM/CS/IT/E/U d- s++: a18 C++++>$ ULBX*++++(+++)>$ P++++(+++)>$ L++++ 
(+++)>$ !E- W+++(++) N+++(++) o? K? w--- O? M++ V? PS+() PE+(-) Y+ PGP 
+ t+(+++) 5 X R? !tv-(--) b++++(++) DI+(++) D+++ G e>++++$ h*(+)>++$ r 
%(--)  !y?-(--)
------END GEEK CODE BLOCK------



