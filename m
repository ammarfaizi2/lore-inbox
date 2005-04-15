Return-Path: <linux-kernel-owner+willy=40w.ods.org-S261920AbVDOSlx@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261920AbVDOSlx (ORCPT <rfc822;willy@w.ods.org>);
	Fri, 15 Apr 2005 14:41:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261907AbVDOSk2
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Fri, 15 Apr 2005 14:40:28 -0400
Received: from perpugilliam.csclub.uwaterloo.ca ([129.97.134.31]:32659 "EHLO
	perpugilliam.csclub.uwaterloo.ca") by vger.kernel.org with ESMTP
	id S261893AbVDOShm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Fri, 15 Apr 2005 14:37:42 -0400
Date: Fri, 15 Apr 2005 14:37:38 -0400
To: Allison <fireflyblue@gmail.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Kernel Rootkits
Message-ID: <20050415183738.GR17865@csclub.uwaterloo.ca>
References: <17d79880504151115744c47bd@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <17d79880504151115744c47bd@mail.gmail.com>
User-Agent: Mutt/1.3.28i
From: lsorense@csclub.uwaterloo.ca (Lennart Sorensen)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2005 at 06:15:37PM +0000, Allison wrote:
> I got the terminology mixed up. I guess what I really want to know is,
> what are the different types of exploits by which rootkits
> (specifically the ones that modify the kernel) can get installed on
> your system.(other than buffer overflow and somebody stealing the root
> password)
> 
> I know that SucKIT is a rootkit that gets loaded as a kernel module
> and adds new system calls. Some other rootkits change machine
> instructions in several kernel functions.
> 
> Once these are loaded into the kernel, is there no way the kernel
> functions can be protected ?

Well you could build a monilithic kernel with module loading turned off
entirely, but that doesn't prevent replacing libc which most programs
use to make those system calls.  Could make the filesystem readonly,
that would prevent writing a module to load into the kernel, and
replacing libc as long as you make it imposible to remount the
filesystem at all.

Len Sorensen
