Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S290119AbSAWVoe>; Wed, 23 Jan 2002 16:44:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S290125AbSAWVoY>; Wed, 23 Jan 2002 16:44:24 -0500
Received: from vasquez.zip.com.au ([203.12.97.41]:36359 "EHLO
	vasquez.zip.com.au") by vger.kernel.org with ESMTP
	id <S290119AbSAWVoI>; Wed, 23 Jan 2002 16:44:08 -0500
Message-ID: <3C4F2D18.5DC72FFE@zip.com.au>
Date: Wed, 23 Jan 2002 13:37:28 -0800
From: Andrew Morton <akpm@zip.com.au>
X-Mailer: Mozilla 4.77 [en] (X11; U; Linux 2.4.18-pre4 i686)
X-Accept-Language: en
MIME-Version: 1.0
To: Mauricio =?iso-8859-1?Q?Nu=F1ez?= <mnunez@maxmedia.cl>
CC: linux-kernel@vger.kernel.org
Subject: Re: Low latency for recent kernels
In-Reply-To: <20020123091643.A182@earthlink.net> <3C4F0DFA.50601@lexus.com> <3C4F10F9.87A3B2E@zip.com.au>,
		<3C4F10F9.87A3B2E@zip.com.au> <02012318041500.01883@mauricio.chile.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Mauricio Nuñez wrote:
> 
> Hi,
> 
> I'm sending some feedback !
> :-)

Is good.  Thanks.

> I'm trying this patch... (in 2.4.18-pre6)
> I'm feeling a improved performance ,as a desktop user.
> I'm working with KDE2, Netbeans and VMWare.
> Pentium III 666Mhz , 192M Ram, 10GB HD.

I'm a little surprised that desktop users do notice significant
benefits with all the latency/preempt patches.  If you actually
instrument the kernel's behaviour, the stalls are in fact
quite small and infrequent.  See the histograms in

 http://www.uwsg.iu.edu/hypermail/linux/kernel/0201.0/1624.html

Probably, poor interactivity on the desktop is more due to
waiting on disk reads - a combination of bad read latency
in the presence of write traffic and unfortunate page replacement
decisions.

Try http://www.zipworld.com.au/~akpm/linux/2.4/2.4.18-pre6/read-latency2.patch

> What are the tools to check this better performance?
> Or my impression is sufficient ?

The simplest tool to use is Mark Hahn's `realfeel' app.  See
http://www.zip.com.au/~akpm/linux/amlat.tar.gz

-
