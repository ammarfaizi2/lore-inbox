Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S263915AbTFJU5O (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 10 Jun 2003 16:57:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262569AbTFJUzy
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 10 Jun 2003 16:55:54 -0400
Received: from mailrelay2.lanl.gov ([128.165.4.103]:26071 "EHLO
	mailrelay2.lanl.gov") by vger.kernel.org with ESMTP id S263915AbTFJUz3
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Tue, 10 Jun 2003 16:55:29 -0400
Subject: Re: Wrong number of cpus detected/reported
From: Steven Cole <elenstev@mesatop.com>
To: Samuel Flory <sflory@rackable.com>
Cc: John Appleby <john@dnsworld.co.uk>, xyko_ig@ig.com.br,
       linux-kernel@vger.kernel.org
In-Reply-To: <3EE64161.5010102@rackable.com>
References: <434747C01D5AC443809D5FC540501131569E@bobcat.unickz.com>
	 <3EE64161.5010102@rackable.com>
Content-Type: text/plain
Organization: 
Message-Id: <1055279041.2270.42.camel@spc9.esa.lanl.gov>
Mime-Version: 1.0
X-Mailer: Ximian Evolution 1.2.4-1.1mdk 
Date: 10 Jun 2003 15:04:01 -0600
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2003-06-10 at 14:36, Samuel Flory wrote:
> John Appleby wrote:
> 
> >>After the upgrade the system is reporting that the machine has 8 cpu
> >>instead of 4. I have been looking for some kind of information on the
> >>Internet (www.google.com/linux) about that but I didn't have success.
> >>    
> >>
> >
> >I suspect that it is identifying 4 Xeon CPUs with Hyperthreading, which
> >will correctly double the amount of processors your kernel thinks you
> >have. Intel's Hyperthreading
> >
> >This ought to be a good thing... the only thing I don't quite understand
> >is that I thought Hyperthreading was added in 2.4.17.
> >
> >  
> >
> 
>   Red Hat enabled basic hyperthreading support in their 2.4.9 eratta 
> kernels some where along the line.  I just didn't think 1.4 Xeons did 
> HT.  (Maybe the MP Xeons are different from the DP xeons.)

His does. From his cpuinfo:

processor	: 7
vendor_id	: GenuineIntel
cpu family	: 15
model		: 1
model name	: Intel(R) Xeon(TM) CPU 1.40GHz
stepping	: 1
cpu MHz		: 1399.982
cache size	: 256 KB
fdiv_bug	: no
hlt_bug		: no
f00f_bug	: no
coma_bug	: no
fpu		: yes
fpu_exception	: yes
cpuid level	: 2
wp		: yes
flags		: fpu vme de pse tsc msr pae mce cx8 apic sep mtrr mca cmov pat pse36 clflush dts acpi mmx fxsr sse sse2 ss ht tm
bogomips	: 2798.38

See that ht flag near the end?

Don't know why he doesn't go with RH 9 or RH AS though.

Steven

