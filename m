Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266363AbSKGFKi>; Thu, 7 Nov 2002 00:10:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266362AbSKGFKf>; Thu, 7 Nov 2002 00:10:35 -0500
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:36164 "EHLO
	frodo.biederman.org") by vger.kernel.org with ESMTP
	id <S266363AbSKGFKe>; Thu, 7 Nov 2002 00:10:34 -0500
To: Andy Pfiffer <andyp@osdl.org>
Cc: "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
       fastboot@osdl.org
Subject: Re: kexec for 2.5.46
References: <m14ravfbjj.fsf@frodo.biederman.org>
	<1036631471.10457.233.camel@andyp>
From: ebiederm@xmission.com (Eric W. Biederman)
Date: 06 Nov 2002 22:14:43 -0700
In-Reply-To: <1036631471.10457.233.camel@andyp>
Message-ID: <m1fzuedkqk.fsf@frodo.biederman.org>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.1
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Andy Pfiffer <andyp@osdl.org> writes:

> On Tue, 2002-11-05 at 22:38, Eric W. Biederman wrote:
> > Linus please apply,
> 
> 
> FYI: patch applied cleanly for me.
> 
> After fudging kexec-tools-1.4 to correct for the new syscall number:
>     <hang>
> 
> It does not make it to the "Interrupts enabled." print, so it is
> probably going wacko at the "sti."

Thanks for the report.  Linus has asked for some changes, but has
ok'd. the basic idea the thread topic on linux-kernel was: 
"Re: [lkcd-devel] Re: What's left over." 
I am going to focus on getting those changes made, and then I
concentrate on why things fail in strange ways for various people. 

The primary change is that the mcore people need a 2 stage kexec.  1
load the kernel.  2 later actually start it.  This allows the second
kernel to be started when the first kernel panics.  Allowing for
nice crash dumps and perhaps some other interesting debugging
techniques.

Talk to you later...

Eric
