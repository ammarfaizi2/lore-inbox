Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S289218AbSANMdL>; Mon, 14 Jan 2002 07:33:11 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S289220AbSANMdC>; Mon, 14 Jan 2002 07:33:02 -0500
Received: from xsmtp.ethz.ch ([129.132.97.6]:62551 "EHLO xfe3.d.ethz.ch")
	by vger.kernel.org with ESMTP id <S289218AbSANMcv>;
	Mon, 14 Jan 2002 07:32:51 -0500
Message-ID: <3C42CF6E.30106@debian.org>
Date: Mon, 14 Jan 2002 13:30:38 +0100
From: Giacomo Catenazzi <cate@debian.org>
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.0; en-US; rv:0.9.4) Gecko/20011128 Netscape6/6.2.1
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: "Michael Lazarou (ETL)" <Michael.Lazarou@etl.ericsson.se>
CC: "'esr@thyrsus.com'" <esr@thyrsus.com>,
        Linux Kernel List <linux-kernel@vger.kernel.org>
Subject: Re: ISA hardware discovery -- the elegant solution
In-Reply-To: <fa.r42lgsv.1b5e3p9@ifi.uio.no>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-OriginalArrivalTime: 14 Jan 2002 12:32:49.0505 (UTC) FILETIME=[93E2BD10:01C19CF7]
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


Michael Lazarou (ETL) wrote:

>>
>>The kernel's device drivers have, of course, to include probe
>>routines, and those hard-compiled in typically log the presence of
>>their hardware to /var/log/mesg when it loads.  By scanning that
>>file, we in effect get to use those probes.
>>
> 
> Doesn't this mean that you would need a fully functional kernel
> before you get to run the autoconfigurator?


Not a problem. Autoconfiguration is made to help configuring
the kernel, before to compile it. So you need a linux working
machine (actually you can cross-compile).

Our task is to allow user to compile a kernel, with the
needed drivers, without the non used drivers.

If you want a good running kernel image:
   check the kernels in your distribution.
If you want to compile a general running kernel:
   use the kernel sources in your distribution (
   with your distribution's .config), or compile
   the std kernel with your distribution's .config

If you want a working kernel to boot Linux in your

   old/new/non-x86 machine: check the installation
   note of your distribution. Use special kernel (from
   your distribution,...)

 

You see: different task needs different tools.
Maybe we can merge some problems, but how? why?

[I still have a working version of autoconfigure in
shell, if some "boot-floppies" people need some
of our detection.]

But for old ISA cards (and some newer laptop) there is
only one method to find the right *kernel*:
boot and try (and changing kernels, parameters,...)
[check: installation document and internet resources].

We don't want a boot and retry for our configuration,
so let use the (incomplete) infos from kernel.

	giacomo

