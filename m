Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264336AbRFLLjb>; Tue, 12 Jun 2001 07:39:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264334AbRFLLjV>; Tue, 12 Jun 2001 07:39:21 -0400
Received: from mailgw.prontomail.com ([216.163.180.10]:41253 "EHLO
	c0mailgw13.prontomail.com") by vger.kernel.org with ESMTP
	id <S264332AbRFLLjH> convert rfc822-to-8bit; Tue, 12 Jun 2001 07:39:07 -0400
Message-ID: <3B250C0A.79299E45@mvista.com>
Date: Mon, 11 Jun 2001 11:20:58 -0700
From: george anzinger <george@mvista.com>
Organization: Monta Vista Software
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.2.12-20b i686)
X-Accept-Language: en
MIME-Version: 1.0
To: =?iso-8859-15?Q?Mich=E8l?= Alexandre Salim <salimma1@yahoo.co.uk>
CC: linux-kernel@vger.kernel.org
Subject: Re: Clock drift on TransmetaCrusoe
In-Reply-To: <20010611150111.7747.qmail@web3505.mail.yahoo.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Michèl Alexandre Salim wrote:
> 
> Hello,
> 
> Searching through the mailing list I could not find a
> reference to this problem, hence this post.
> 
> Having ran various kernel and distribution
> combinations (SGI's 2.4.2-xfs bundled with their Red
> Hat installer, 2.4-xfs-1.0 and 2.4 CVS trees, Linux
> Mandrake with default kernel 2.4.3, and lastly
> 2.4.5-ac9), compiled for generic i386 and/or Transmeta
> Crusoe with APM off or on, one thing sticks out : a
> clock drift of a few minutes per day.
> 
> This problem might not be noticeable for most users
> since notebooks are not normally left running that
> long, but it is rather serious. I can choose not to
> sync the software and hardware clock on shutdown and
> re-read the hardware clock every hour or so but it is
> rather kludgy.
> 
> Anyone experienced this before or willing to try it
> out?
> 
This is most likely a bad "rock" (crystal) in the box.  There is a
"built in" drift of about .1445 seconds a day (runs too slow) due to the
fact that 1.193180Mhz can not be divided to 10 ms. but you are way over
this.  

Here is a bit of code to sync your system to the RTC:

http://www.linuxppc.org/software/index/linuxppc_stable/software/adjtimex-1.9-3.ppc.html

Of course, you best bet would be to use the xntpd code to sync to
another system.

George
