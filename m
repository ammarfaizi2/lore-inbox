Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S283001AbRLWADW>; Sat, 22 Dec 2001 19:03:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S283002AbRLWADN>; Sat, 22 Dec 2001 19:03:13 -0500
Received: from mail.ocs.com.au ([203.34.97.2]:15881 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S283001AbRLWADJ>;
	Sat, 22 Dec 2001 19:03:09 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@sgi.com>
To: Benjamin LaHaise <bcrl@redhat.com>
Cc: linux-kernel@vger.kernel.org
Subject: Re: [patch] Assigning syscall numbers for testing 
In-Reply-To: Your message of "Sat, 22 Dec 2001 18:25:57 CDT."
             <20011222182556.A19700@redhat.com> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sun, 23 Dec 2001 11:02:56 +1100
Message-ID: <17686.1009065776@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 22 Dec 2001 18:25:57 -0500, 
Benjamin LaHaise <bcrl@redhat.com> wrote:
>On Sun, Dec 23, 2001 at 10:18:26AM +1100, Keith Owens wrote:
>> You did not read my mail all the way through, did you?  I said -
>> 
>> If the [user space] code cannot open /proc/dynamic_syscalls or cannot
>> find the desired syscall name, fall back to the assigned syscall number
>> (if any) or fail if there is no assigned syscall number.  By falling
>> back to the assigned syscall number, new versions of the user space
>> code are backwards compatible, on older kernels it will use the dynamic
>> syscall number, on newer kernels it will use the assigned number.
>
>No, that's not the case I'm talking about: what happens when a vendor 
>starts shipping this patch and Linus decides to add a new syscall that 
>uses a syscall number that the old kernel used for dynamic syscalls?

That is why the dynamic syscall range starts well above the currently
allocated range.  If you are looking at my first mail then the patch is
wrong, in my second mail with the correct patch (first patch line is
17.1/kernel/Makefile) the dynamic range starts at 240.

