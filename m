Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264930AbUAVUfp (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 22 Jan 2004 15:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265063AbUAVUfp
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 22 Jan 2004 15:35:45 -0500
Received: from saturn.opentools.org ([66.250.40.202]:63724 "EHLO
	www.princetongames.org") by vger.kernel.org with ESMTP
	id S264930AbUAVUfg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 22 Jan 2004 15:35:36 -0500
Date: Thu, 22 Jan 2004 15:35:27 -0500 (EST)
From: Aaron Mulder <ammulder@alumni.princeton.edu>
X-X-Sender: ammulder@www.princetongames.org
To: Zan Lynx <zlynx@acm.org>
cc: Brandon Ehle <azverkan@yahoo.com>,
       Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Strange pauses in 2.6.2-rc1 / AMD64
In-Reply-To: <1074801826.10610.3.camel@localhost.localdomain>
Message-ID: <Pine.LNX.4.44.0401221530471.29180-100000@www.princetongames.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

	This appears to be the issue.  If I load hw_random and run rngd, 
then the pauses go away.  I may have been confused about the keyboard 
-- I probably only typed a couple characters, which I guess wasn't 
enough input.

	Any idea why I wouldn't see this under 2.4?  Perhaps something I
missed moving from /etc/modules.conf to /etc/modprobe.conf?  I didn't see 
anything about random in there, and /dev/hwrandom didn't even exist (I 
had to mknod it).

Thanks,
	Aaron

On Thu, 22 Jan 2004, Zan Lynx wrote:
> jarsigner might be waiting on /dev/random for some cryptographically
> random bytes.  One source of randomness is mouse interrupts.
> 
> If that's the case though, I'm surprised that the keyboard doesn't work.
> 
> Does that motherboard have support for a random generator chip?  If so,
> try loading that module in.
> 

