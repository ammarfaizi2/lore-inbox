Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S135915AbRD0L2I>; Fri, 27 Apr 2001 07:28:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S135939AbRD0L17>; Fri, 27 Apr 2001 07:27:59 -0400
Received: from kullstam.ne.mediaone.net ([66.30.138.210]:63647 "HELO
	kullstam.ne.mediaone.net") by vger.kernel.org with SMTP
	id <S135915AbRD0L1o>; Fri, 27 Apr 2001 07:27:44 -0400
From: "Johan Kullstam" <kullstam@ne.mediaone.net>
To: linux-kernel@vger.kernel.org
Subject: Re: About rebuild 2.4.x kernel to support SMP.
In-Reply-To: <Pine.LNX.3.96.1010426120128.28828A-100000@kanga.kvack.org>
Organization: none
Date: 27 Apr 2001 07:27:31 -0400
In-Reply-To: <Pine.LNX.3.96.1010426120128.28828A-100000@kanga.kvack.org>
Message-ID: <m2u23ashuk.fsf@euler.axel.nom>
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

<kernel@kvack.org> writes:

> On Thu, 26 Apr 2001, Yiping Chen wrote:
> 
> > So, I have two question now, 
> > 1. how to determine whether your kernel support SMP?
> >     Somebody taugh me that you can type  "uname -r", but it seems not
> > correct.
> 
> No, it's correct: the Red Hat RPM is build from the kernel.spec file which
> adds the smp string to the version.

"uname -a" will show SMP status.

euler(jk)$ uname -a
Linux euler.axel.nom 2.4.4-pre5 #1 SMP Thu Apr 19 19:20:40 EDT 2001 i686 unknown

this is on a redhat system, but i think it will work on any linux
system.

> > 2. I remember in 2.2.x, when I rebuild the kernel which support SMP, the
> > compile
> >     argument will include -D__SMP__ , but this time, when I rebuild kernel
> > 2.4.2-2 , it didn't  appear.
> >     Why? 
> 
> Because you've made an assumption that holds no value.  2.4 kernels rely
> on CONFIG_SMP instead of __SMP__.

it's probably easiest to download the latest kernel (2.4.3 at the time
of this writing) from ftp.XX.kernel.org (XX being your country code).
then configure using "make xconfig" or "make menuconfig".  choose SMP
in one of the first menus.  there's a kernel-howto which explains this
stuff.  btw there is no problem running your own kernels on a redhat
system bypassing rpm.

in a source tree in which you've compiled SMP and want UP or
vice-versa, i think to do a "make distclean" in between switching.

-- 
J o h a n  K u l l s t a m
[kullstam@ne.mediaone.net]
Don't Fear the Penguin!
