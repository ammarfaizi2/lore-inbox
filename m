Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264872AbSLGXI1>; Sat, 7 Dec 2002 18:08:27 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264875AbSLGXI1>; Sat, 7 Dec 2002 18:08:27 -0500
Received: from smtp08.iddeo.es ([62.81.186.18]:62101 "EHLO smtp08.retemail.es")
	by vger.kernel.org with ESMTP id <S264872AbSLGXI0>;
	Sat, 7 Dec 2002 18:08:26 -0500
Date: Sun, 8 Dec 2002 00:15:35 +0100
From: "J.A. Magallon" <jamagallon@able.es>
To: Z F <mail4me9999@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: CPU cache problem
Message-ID: <20021207231535.GA3183@werewolf.able.es>
References: <20021207184038.34687.qmail@web20421.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Disposition: inline
Content-Transfer-Encoding: 7BIT
In-Reply-To: <20021207184038.34687.qmail@web20421.mail.yahoo.com>; from mail4me9999@yahoo.com on Sat, Dec 07, 2002 at 19:40:38 +0100
X-Mailer: Balsa 1.4.1
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


On 2002.12.07 Z F wrote:
>Hello Manish and Mark
>
>The BIOS does not have any info about L2 cache accept for
>enable/disable
>switch.
>I noticed that after the POST message in the table of all installed
>devices it said CPU 1.7 GHz... Memory installed 256 M (RAM) and 
>CPU cache: NONE.
>
>I have upgraded the BIOS on the system and now it says 128K, as it
>should, according to CPU specifications.
>Mark tells that /proc/cpuinfo reports L1 cache size (which I assume is 
>8K+12 K in my case, even though I do not understand what that means)
>But how to check that L2 is operational?
>
>For windows I have ASUSprobe software, which after the BIOS upgrade
>started to report that CPU has L2 cache, but it reports it regardless
>of BIOS switch(enable/disable) as if program simply reads the CPU
>specifications. (Before BIOS upgrade it reported 0K L2 cache.)
>
>The question I have is: Is it possible to tell whether or not
>the kernel sees the L2 CPU cache and its size?
>

Supposing you have a recent kernel with cpuid support, try x86info,
at least it will tell you what processor-bios is reporting (ala your
ASUS utility).

To see what the kernel thinks about the processor, cat /proc/cpuinfo.
The cache reported there is L2.

Hope this helps.

-- 
J.A. Magallon <jamagallon@able.es>      \                 Software is like sex:
werewolf.able.es                         \           It's better when it's free
Mandrake Linux release 9.1 (Cooker) for i586
Linux 2.4.20-jam1 (gcc 3.2 (Mandrake Linux 9.1 3.2-4mdk))
