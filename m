Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S310533AbSCPTml>; Sat, 16 Mar 2002 14:42:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S310534AbSCPTmb>; Sat, 16 Mar 2002 14:42:31 -0500
Received: from ns.suse.de ([213.95.15.193]:55559 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S310533AbSCPTm3>;
	Sat, 16 Mar 2002 14:42:29 -0500
Date: Sat, 16 Mar 2002 20:42:28 +0100
From: Dave Jones <davej@suse.de>
To: S W <egberts@yahoo.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: 2.4.19-pre2 Cyrix III SEGFAULT (Cyrix II redux?)
Message-ID: <20020316204228.B15296@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	S W <egberts@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020316180705.34916.qmail@web10506.mail.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20020316180705.34916.qmail@web10506.mail.yahoo.com>
User-Agent: Mutt/1.3.22.1i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 16, 2002 at 10:07:05AM -0800, S W wrote:
 > But I recalled Linux 2.2 having a bug fix for broken
 > L2 cache in Cyrix II.
 
 The cache itself isn't broken. Reporting of the size of it is.
 
 > So, it got me thinking again...
 > (did Cyrix fix this L2 cache in certain subsequential
 > core?)

 The bug is potentially in all cores with cpuid 670->68F
 If you have it, and you're not running a kernel with the
 fix you'll see you have a 16MB cache. If you run a kernel
 with the fix, you'll have the correct size (64KB)
 
 > Does anyone recall where exactly are the Cyrix II L2
 > cache bug fix in the kernelso that I can experiement
 > them toward the Cyrix III?

 arch/i386/kernel/setup.c display_cacheinfo()

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
