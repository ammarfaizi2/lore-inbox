Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932109AbVJIRFk@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109AbVJIRFk (ORCPT <rfc822;willy@w.ods.org>);
	Sun, 9 Oct 2005 13:05:40 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932116AbVJIRFk
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sun, 9 Oct 2005 13:05:40 -0400
Received: from mail.servus.at ([193.170.194.20]:61962 "EHLO mail.servus.at")
	by vger.kernel.org with ESMTP id S932109AbVJIRFj (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sun, 9 Oct 2005 13:05:39 -0400
Message-ID: <43494E2D.4050902@oberhumer.com>
Date: Sun, 09 Oct 2005 19:06:53 +0200
From: "Markus F.X.J. Oberhumer" <markus@oberhumer.com>
Organization: oberhumer.com
User-Agent: Mozilla Thunderbird 1.0.7-1.4.1.centos4 (X11/20051007)
X-Accept-Language: en-us, en
MIME-Version: 1.0
To: Andi Kleen <ak@suse.de>
CC: Linus Torvalds <torvalds@osdl.org>, Daniel Jacobowitz <dan@debian.org>,
       linux-kernel@vger.kernel.org
Subject: Re: [PATCH] i386: fix stack alignment for signal handlers
References: <43273CB3.7090200@oberhumer.com> <20050914154425.GM11338@wotan.suse.de> <43494B3F.5070303@oberhumer.com> <200510091857.11566.ak@suse.de>
In-Reply-To: <200510091857.11566.ak@suse.de>
X-no-Archive: yes
X-Oberhumer-Conspiracy: There is no conspiracy. Trust us.
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andi Kleen wrote:
> On Sunday 09 October 2005 18:54, Markus F.X.J. Oberhumer wrote:
> 
> 
>>Here is a somewhat simplified version of my previous patch with
>>updated comments.
>>
>>Attached is also a new small user-space test program which does not
>>depend on any special gcc features and should trigger the problem on all
>>machines.
> 
> 
> I already have a version of the patch in my queue, but it's not a strict 
> bugfix so it's only for after 2.6.14.

I see, many thanks.

Please note that your current version could waste 16-bytes for unneeded 
alignment, while my new version does not. Not a real problem, but still 
things like these should be done right.

~Markus

> 
> -Andi
> 
> ftp://ftp.firstfloor.org/pub/ak/x86_64/quilt-current/patches/sigframe-alignment
> 
> 

-- 
Markus Oberhumer, <markus@oberhumer.com>, http://www.oberhumer.com/
