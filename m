Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S264940AbSLXSRp>; Tue, 24 Dec 2002 13:17:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265608AbSLXSRp>; Tue, 24 Dec 2002 13:17:45 -0500
Received: from holomorphy.com ([66.224.33.161]:35029 "EHLO holomorphy")
	by vger.kernel.org with ESMTP id <S264940AbSLXSRo>;
	Tue, 24 Dec 2002 13:17:44 -0500
Date: Tue, 24 Dec 2002 10:24:58 -0800
From: William Lee Irwin III <wli@holomorphy.com>
To: "Martin J. Bligh" <fletch@aracnet.com>
Cc: Andrew Morton <akpm@zip.com.au>,
       linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] Fix 4 compile time warnings in 2.5.53
Message-ID: <20021224182458.GL9704@holomorphy.com>
Mail-Followup-To: William Lee Irwin III <wli@holomorphy.com>,
	"Martin J. Bligh" <fletch@aracnet.com>,
	Andrew Morton <akpm@zip.com.au>,
	linux-kernel <linux-kernel@vger.kernel.org>
References: <48180000.1040751403@titus>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <48180000.1040751403@titus>
User-Agent: Mutt/1.3.25i
Organization: The Domain of Holomorphy
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 24, 2002 at 09:36:43AM -0800, Martin J. Bligh wrote:
> Fix the following warnings:
> drivers/serial/core.c: In function `uart_get_divisor':
> drivers/serial/core.c:390: warning: `quot' might be used uninitialized in 
> this function

This is a (harmless) toolchain problem. Upgrading compilers (or patching
your current compiler) fixes it. I've posted a "fix" for this before.


On Tue, Dec 24, 2002 at 09:36:43AM -0800, Martin J. Bligh wrote:
> net/ipv4/route.c: In function `rt_cache_seq_stop':
> net/ipv4/route.c:279: warning: unused variable `st'

Fair enough.


On Tue, Dec 24, 2002 at 09:36:43AM -0800, Martin J. Bligh wrote:
> drivers/net/starfire.c: In function `netdev_close':
> drivers/net/starfire.c:1851: warning: unsigned int format, different type 
> arg (arg 2)
> drivers/net/starfire.c:1858: warning: unsigned int format, different type 
> arg (arg 2)

Hmm, I thought I got this one into jgarzik's tree. I posted a fix for this
one too.


On Tue, Dec 24, 2002 at 09:36:43AM -0800, Martin J. Bligh wrote:
> arch/i386/kernel/smpboot.c:691: warning: `wakeup_secondary_via_INIT' 
> defined but not used
> My build is now eerily quiet.

This one's all you. =)


Bill
