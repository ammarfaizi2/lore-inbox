Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264748AbTAJJIN>; Fri, 10 Jan 2003 04:08:13 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264749AbTAJJGg>; Fri, 10 Jan 2003 04:06:36 -0500
Received: from 169.imtp.Ilyichevsk.Odessa.UA ([195.66.192.169]:61188 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S264745AbTAJJGO>; Fri, 10 Jan 2003 04:06:14 -0500
Message-Id: <200301100908.h0A98ks15321@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: Anthony Lau <anthony@greyweasel.com>, linux-kernel@vger.kernel.org
Subject: Re: Kernel Oops with HIMEM+VM in 2.4.19,20
Date: Fri, 10 Jan 2003 11:08:39 +0200
X-Mailer: KMail [version 1.3.2]
References: <20030110083714.GA702@kimagure>
In-Reply-To: <20030110083714.GA702@kimagure>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 10 January 2003 10:37, Anthony Lau wrote:
> Hello,
>
> I am getting reproducible kernel oops and random segmentation
> faults whenever the kernel starts using VM. Without any VM pages
> being used, the system is stable.
>
> I have tested kernels compiled with and without HIMEM support
> (all other kernel config options identical). Without HIMEM 4GB
> support, the system is stable for weeks. With HIMEM 4GB support,
> the system starts oops'ing and seg. faulting when VM starts
> being used.

You mean when your system starts to swap? Details?
(How much/how heavy it swaps before oops? vmstat output?)

> My system info:
>
> 1.5GB physical RAM (MemTest86 run for 2 times, no errors)
> 2.0GB VM on a partition
> Aopen AX34u with Via Apollo Pro 133T chipset
>
> Sample Oops from logs:
[snipped]
>
> Because of the symptoms, I think that there could be some
> incompatibility between Himem and the VM subsystem. Of course
> I may have just configured my kernel incorrectly.
>
> Any help is appreciated and I will gladly supply more logs
> if I knew which ones would be useful.

Kernel version and .config?
Arrange klogd to be started with -x. Process oopses with ksymoops.
Then contact VM people (listed in no particular order):

William Irwin <wli@holomorphy.com> [02 jul 2002]
	Send bug reports and/or feature requests related to many tasks,
	rmap, space consumption, or allocators to me. I'm involved in
	* rmap
	* memory allocators
	* reducing space consumed by data structures (e.g. struct page)
	* issues arising in workloads with many tasks
	* kernel janitoring
	See also:
	Rik van Riel <riel@surriel.com>
	Andrea Arcangeli <andrea@suse.de>
	Martin Bligh <Martin.Bligh@us.ibm.com>
	Andrew Morton <akpm@digeo.com>

Andrea Arcangeli <andrea@suse.de> [28 mar 2002]
	Send VM related bug reports and patches to me.
	I'm especially interested in VM issues with:
	* lots of RAM and CPUs
	* NUMA
	* heavy swap scenarios
	* performance of I/O intensive workloads (in particular
	  with lots of async buffer flushing involved)
	See also Martin J. Bligh <Martin.Bligh@us.ibm.com> entry
	Mail also:
	Arjan van de Ven <arjanv@redhat.com>

Martin J. Bligh <Martin.Bligh@us.ibm.com> [28 mar 2002]
	I'm interested in VM issues with lots (>4G for i386)
	of RAM, lots of CPUs, NUMA

Rik van Riel <riel@conectiva.com.br> [07 feb 2002]
	Send me VM related stuff, please CC to linux-mm@kvack.org
--
vda
