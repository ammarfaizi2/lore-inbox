Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266403AbUBFD2S (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 5 Feb 2004 22:28:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266414AbUBFD2R
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 5 Feb 2004 22:28:17 -0500
Received: from fw.osdl.org ([65.172.181.6]:54216 "EHLO mail.osdl.org")
	by vger.kernel.org with ESMTP id S266403AbUBFD2O (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Thu, 5 Feb 2004 22:28:14 -0500
Date: Thu, 5 Feb 2004 19:30:08 -0800
From: Andrew Morton <akpm@osdl.org>
To: Andi Kleen <ak@suse.de>
Cc: linux-kernel@vger.kernel.org, kenneth.w.chen@intel.com, lord@xfs.org
Subject: Re: Limit hash table size
Message-Id: <20040205193008.25bd922b.akpm@osdl.org>
In-Reply-To: <20040206031834.GA24890@wotan.suse.de>
References: <B05667366EE6204181EABE9C1B1C0EB5802441@scsmsx401.sc.intel.com.suse.lists.linux.kernel>
	<20040205155813.726041bd.akpm@osdl.org.suse.lists.linux.kernel>
	<p73isilkm4x.fsf@verdi.suse.de>
	<20040205190904.0cacd513.akpm@osdl.org>
	<20040206031834.GA24890@wotan.suse.de>
X-Mailer: Sylpheed version 0.9.4 (GTK+ 1.2.10; i686-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen <ak@suse.de> wrote:
>
> > But I've been telling poeple for a year that they should set
>  > /proc/sys/vm/swappiness to zero during the updatedb run and afaik nobody has
>  > bothered to try it...
> 
>  I do not think such hacks are the right way to do. If updatedb does not
>  do that backup will or maybe your nightly tripwire run or some other
>  random application that walks file systems. Hacking all of them is just not 
>  realistic.

You need some way of not slowing down real-world applications by a factor
of 1000.  That is unacceptable, and the problems which updatedb and friends
cause (just once per day!) pale in comparison.


