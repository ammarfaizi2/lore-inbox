Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932604AbVLFRmH@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932604AbVLFRmH (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 6 Dec 2005 12:42:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932605AbVLFRmH
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 6 Dec 2005 12:42:07 -0500
Received: from fsmlabs.com ([168.103.115.128]:24450 "EHLO spamalot.fsmlabs.com")
	by vger.kernel.org with ESMTP id S932604AbVLFRmG (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 6 Dec 2005 12:42:06 -0500
X-ASG-Debug-ID: 1133890918-5466-138-0
X-Barracuda-URL: http://10.0.1.244:8000/cgi-bin/mark.cgi
Date: Tue, 6 Dec 2005 09:47:34 -0800 (PST)
From: Zwane Mwaikambo <zwane@arm.linux.org.uk>
To: matthew-lkml@newtoncomputing.co.uk
cc: Linux Kernel <linux-kernel@vger.kernel.org>
X-ASG-Orig-Subj: Re: 2.4.27 crashed: any ideas?
Subject: Re: 2.4.27 crashed: any ideas?
In-Reply-To: <20051206111625.GA6542@newtoncomputing.co.uk>
Message-ID: <Pine.LNX.4.64.0512060944480.13220@montezuma.fsmlabs.com>
References: <20051206111625.GA6542@newtoncomputing.co.uk>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
X-Barracuda-Spam-Score: 0.00
X-Barracuda-Spam-Status: No, SCORE=0.00 using global scores of TAG_LEVEL=1000.0 QUARANTINE_LEVEL=5.0 KILL_LEVEL=5.0 tests=
X-Barracuda-Spam-Report: Code version 3.02, rules version 3.0.6002
	Rule breakdown below pts rule name              description
	---- ---------------------- --------------------------------------------------
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Dec 2005, matthew-lkml@newtoncomputing.co.uk wrote:

> Our main user-facing Linux machine at work crashed a couple of times over the
> last few days, both with the same error. It's been up and stable for the last
> 80ish days (from when it was upgraded to Debian sarge), and had no problems
> before that with the same kernel.
> 
> Machine is an HP DL740 with four Xeon 2Ghz CPUs and 4Gb RAM (5Gb RAID 5).
> 
> I've put both outputs that our console logger saved, and the result from running
> them through ksymoops, at http://www.le.ac.uk/cc/mcn4/problem/
> 
> I realise the kernel is tainted. It's a locally compiled Debian kernel. I think
> the non-free module is the qla SAN card driver, but I'm not sure (is there a way
> of finding out what exactly tainted the kernel?)
> 
> The strange thing is that both times it seemed to crash in cfi_probe, which
> looks like something to do with Compact Flash / MTDs. Something we don't use.

You're probably using a bad System.map, all we do know is that the oops is 
occuring in a module. Can you try rerunning ksymoops using the System.map 
in your kernel build directory? Or, cat /proc/modules before it oopses and 
then we can compare the faulting address.
