Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261262AbTEAN6J (ORCPT <rfc822;willy@w.ods.org>);
	Thu, 1 May 2003 09:58:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261265AbTEAN6J
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Thu, 1 May 2003 09:58:09 -0400
Received: from franka.aracnet.com ([216.99.193.44]:29379 "EHLO
	franka.aracnet.com") by vger.kernel.org with ESMTP id S261262AbTEAN6H
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Thu, 1 May 2003 09:58:07 -0400
Date: Thu, 01 May 2003 07:06:37 -0700
From: "Martin J. Bligh" <mbligh@aracnet.com>
To: Chuck Ebbert <76306.1226@compuserve.com>
cc: linux-kernel <linux-kernel@vger.kernel.org>
Subject: Re: Kernel source tree splitting
Message-ID: <11850000.1051797996@[10.10.2.4]>
In-Reply-To: <200305010756_MC3-1-36E1-623@compuserve.com>
References: <200305010756_MC3-1-36E1-623@compuserve.com>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

>>> So there are many edits that needed to be done in lots of
>>> Kconfig and Makefiles if one selectively pulls or omits certain
>>> sub-directories.
>> 
>> Indeed, I ran across the same thing a while back. Would be *really* nice
>> to fix, if only so some poor sod over a modem can download a smaller
>> tarball, or save some diskspace.
> 
>  I have seven source trees on disk right now.  Getting rid off all
> the archs but i386 would not only save tons of space, it would also
> make 'grep -r' go faster and stop spewing irrelevant hits for archs
> that I couldn't care less about.

Indeed. But whilst you're waiting, hardlink everything together, and 
patch the differences (patch knows how to break hardlinks). Make a 
script that cp -lR's the tree to another copy (normally takes < 1s), and
then remove the other arches. grep that.

cscope with prebuilt indeces on a filtered subset of the files may well do
better than grep, depending on exactly what you're doing (does 99% of it
for me). Don't use the cscope in Debian Woody, it's broken.

M.

