Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S270685AbRHJX2b>; Fri, 10 Aug 2001 19:28:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S270687AbRHJX2V>; Fri, 10 Aug 2001 19:28:21 -0400
Received: from mailhst2.its.tudelft.nl ([130.161.34.250]:55058 "EHLO
	mailhst2.its.tudelft.nl") by vger.kernel.org with ESMTP
	id <S270686AbRHJX2E>; Fri, 10 Aug 2001 19:28:04 -0400
Date: Fri, 10 Aug 2001 19:24:18 -0400
From: Erik Mouw <J.A.K.Mouw@ITS.TUDelft.NL>
To: Raghava Raju <vraghava_raju@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: __asm__ usage ????
Message-ID: <20010810192418.M1004@arthur.ubicom.tudelft.nl>
In-Reply-To: <20010810195004.18859.qmail@web20008.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <20010810195004.18859.qmail@web20008.mail.yahoo.com>; from vraghava_raju@yahoo.com on Fri, Aug 10, 2001 at 12:50:04PM -0700
Organization: Eric Conspiracy Secret Labs
X-Eric-Conspiracy: There is no conspiracy!
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 10, 2001 at 12:50:04PM -0700, Raghava Raju wrote:

>    I want some basic insights into assembly level code
> emmbedded in C language. Following is the code of
> PowerPc ambedded in C languagge:
> 
> unsigned long old,mask, *p;
> 
> 	__asm__ __volatile__(SMP_WMB "\
> 1:	lwarx 	%0,0,%3
> 	andc  	%0,%0,%2
> 	stwcx 	%0,0,%3
> 	bne 	1b"
> 	SMP_MB
> 	: "=&r" (old), "=m" (*p)
> 	: "r" (mask), "r" (p), "m" (*p)
> 	: "cc");
> 
> 	1) what does these things denote: __volatile__,
> SMP_WMB, SMP_MB, "r","=&r","=m",
> "cc" and 1: .

>From http://www.kernelnewbies.org/links/ :

  http://www-106.ibm.com/developerworks/linux/library/l-ia.html
  http://www.uwsg.indiana.edu/hypermail/linux/kernel/9804.2/0953.html


Erik

-- 
J.A.K. (Erik) Mouw, Information and Communication Theory Group, Department
of Electrical Engineering, Faculty of Information Technology and Systems,
Delft University of Technology, PO BOX 5031,  2600 GA Delft, The Netherlands
Phone: +31-15-2783635  Fax: +31-15-2781843  Email: J.A.K.Mouw@its.tudelft.nl
WWW: http://www-ict.its.tudelft.nl/~erik/
