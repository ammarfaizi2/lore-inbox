Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S262684AbRE3Jim>; Wed, 30 May 2001 05:38:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S262685AbRE3Jid>; Wed, 30 May 2001 05:38:33 -0400
Received: from ns.suse.de ([213.95.15.193]:63243 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S262684AbRE3JiT>;
	Wed, 30 May 2001 05:38:19 -0400
To: "David S. Miller" <davem@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [CHECKER] 4 security holes in 2.4.4-ac8
In-Reply-To: <15124.10785.10143.242660@pizda.ninka.net.suse.lists.linux.kernel> <200105292316.QAA00305@csl.Stanford.EDU.suse.lists.linux.kernel> <15124.12421.609194.476097@pizda.ninka.net.suse.lists.linux.kernel>
From: Andi Kleen <ak@suse.de>
Date: 30 May 2001 11:38:13 +0200
In-Reply-To: "David S. Miller"'s message of "30 May 2001 01:33:41 +0200"
Message-ID: <oupn17vp46y.fsf@pigdrop.muc.suse.de>
User-Agent: Gnus/5.0803 (Gnus v5.8.3) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

"David S. Miller" <davem@redhat.com> writes:

> Dawson Engler writes:
>  > Is there any way to automatically find these?  E.g., is any routine
>  > with "asmlinkage" callable from user space?
> 
> This is only universally done in generic and x86 specific code,
> other ports tend to forget asmlinkage simply because most ports
> don't need it.

Even i386 doesn't need it because the stack frame happens to have the
right order of the arguments at the right position. Just you can get into 
weird bugs when any function modifies their argument because it'll be still 
modified after syscall restart but only depending if the compiler used a 
temporary register or not.

-Andi
