Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S277949AbRJOAmw>; Sun, 14 Oct 2001 20:42:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S277950AbRJOAml>; Sun, 14 Oct 2001 20:42:41 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:39178 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S277949AbRJOAmZ>;
	Sun, 14 Oct 2001 20:42:25 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: Andrew Morton <akpm@zip.com.au>, linux-kernel@vger.kernel.org
Subject: Re: Recursive deadlock on die_lock 
In-Reply-To: Your message of "14 Oct 2001 17:14:24 CST."
             <m1zo6tolv3.fsf@frodo.biederman.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Mon, 15 Oct 2001 10:42:36 +1000
Message-ID: <7104.1003106556@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 14 Oct 2001 17:14:24 -0600, 
ebiederm@xmission.com (Eric W. Biederman) wrote:
>Keith Owens <kaos@ocs.com.au> writes:
>> IA64 also has PAL code which is
>> called directly by the kernel, that PAL code has no unwind data so
>> failures in PAL code result in bad or incomplete back traces.
>
>PAL Ahh!!!!!
>
>Please tell me that we are not rely on the firmware to be correct
>after we have finished initializing the operating system.
>
>Please tell me it ain't so.  I have nightmares about that kind of setup.

Not only do we rely on it, it is mandated by the IA64 design.  Intel
IA64 System Abstraction Layer, 24535901.pdf.  The IA64 kernel calls SAL
all over the place.  grep -ir '\<[ps]al' include/asm-ia64/ arch/ia64/

