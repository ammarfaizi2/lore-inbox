Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262338AbTIAE2h (ORCPT <rfc822;willy@w.ods.org>);
	Mon, 1 Sep 2003 00:28:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262263AbTIAE2h
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Mon, 1 Sep 2003 00:28:37 -0400
Received: from willy.net1.nerim.net ([62.212.114.60]:26630 "EHLO
	www.home.local") by vger.kernel.org with ESMTP id S262338AbTIAE2e
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Mon, 1 Sep 2003 00:28:34 -0400
Date: Mon, 1 Sep 2003 06:20:35 +0200
From: Willy Tarreau <willy@w.ods.org>
To: Alan Cox <alan@lxorguk.ukuu.org.uk>
Cc: "Zach, Yoav" <yoav.zach@intel.com>, akpm@osdl.org, torvalds@osdl.org,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH]: non-readable binaries - binfmt_misc 2.6.0-test4
Message-ID: <20030901042035.GO734@alpha.home.local>
References: <2C83850C013A2540861D03054B478C0601CF64C8@hasmsx403.iil.intel.com> <1062370720.12058.14.camel@dhcp23.swansea.linux.org.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1062370720.12058.14.camel@dhcp23.swansea.linux.org.uk>
User-Agent: Mutt/1.4i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 31, 2003 at 11:58:40PM +0100, Alan Cox wrote:
 
> #3 The instant you pass control to the user space loader I can steal the
> handle via /proc
> 
> #4 The instant you pass control to the user space loader I can take it
> over via ptrace
> 
> #5 After you pass control I can core dump the app and recover the data
> using a signal
> 
> 3, 4 and 5 require you make the userspace loader undumpable in the case 
> where the fd being passed on is executable only. If you do this then it
> certainly fixes 4 (permission denied) and 5 (no dump) and I think it
> fixes #3

I confirm that it fixes #3 since I had a problem with /dev/fd/N not working
in my scripts, until I realized that it was because an exec only bash would
render /proc/self/fd/ unreadable.

Willy

