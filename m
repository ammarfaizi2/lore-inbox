Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S265722AbTFSBrS (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 18 Jun 2003 21:47:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S265731AbTFSBrR
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 18 Jun 2003 21:47:17 -0400
Received: from lightning.hereintown.net ([141.157.132.3]:10934 "EHLO
	lightning.hereintown.net") by vger.kernel.org with ESMTP
	id S265722AbTFSBrF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 18 Jun 2003 21:47:05 -0400
Message-ID: <3EF12031.8020709@hereintown.net>
Date: Wed, 18 Jun 2003 22:30:09 -0400
From: Chris Meadors <clubneon@hereintown.net>
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.3.1) Gecko/20030615
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: linux-kernel@vger.kernel.org
Subject: Re: glibc compiling with kernel 2.5.70-bk17
References: <3EF10F3E.1090308@cern.ch> <3EF11080.5060507@cox.net>
In-Reply-To: <3EF11080.5060507@cox.net>
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanner: exiscan for exim4 (http://duncanthrax.net/exiscan/) *19SojW-0007dY-14*weNKX8ZlKdw*
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Kevin P. Fleming wrote:
> 
> Yes, the kernel headers are currently borked for compiling userspace C 
> libraries. The fix is going to take either a large effort to get a 
> sanitized set of userspace kernel headers created, or someone to be 
> willing to accept patches that fix the problems with the existing 
> headers even though userspace is not supposed to be using them.

I did get glibc 2.3.2 compiled with gcc 3.3 against the 2.5.70 headers 
with only 3 changes made to the glibc source.

The result on the other hand wasn't pretty.  Most programs did run fine, 
"ls" was not one of them.  It would segfault.  (Note to self: If glibc's 
"make check" fails, don't install it.)

Your first comment is something I had wondered about for a while. A 
stable set of userspace kernel headers. That would be nice.  Of course 
changes could be made to reflect new kernel interfaces.  So they should 
still be distributed with the kernel source.  Then glibc could be 
compiled against those updates, and the headers installed as the system 
default.  But it wouldn't be so forbidden for userspace to touch them.

-- 
Chris

