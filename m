Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S265803AbRGFDQw>; Thu, 5 Jul 2001 23:16:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S265844AbRGFDQm>; Thu, 5 Jul 2001 23:16:42 -0400
Received: from water.CC.McGill.CA ([132.206.27.29]:31718 "EHLO
	water.cc.mcgill.ca") by vger.kernel.org with ESMTP
	id <S265803AbRGFDQX>; Thu, 5 Jul 2001 23:16:23 -0400
Date: Thu, 5 Jul 2001 16:47:37 -0400 (EDT)
From: Felix Braun <Felix.Braun@McGill.ca>
To: <linux-kernel@vger.kernel.org>
Subject: Re: Random lockups with kernels 2.4.6-pre8+
In-Reply-To: <Pine.LNX.4.33L2.0107042038190.1073-100000@eressea.in-berlin.de>
Message-ID: <Pine.LNX.4.33L2.0107051621170.888-100000@eressea.in-berlin.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

Hi again,

I have been able to reproduce the locking-up behaviour! It occurs every
time I start Mozilla (0.9.2) or gtkEmbed. Other memory intensive programs
(GIMP) don't have that behaviour.

Strangely enough, the system remains mostly functional: I can switch
consoles, X and Enlightenment remain responsive, I can even execute some
programs. But programs that deal with mozillas /proc entries just hang. top
and ps hang; also if I cd into /proc/<mozilla's pid> and do an ls *block*;
you can't even kill it with CTRL-C. Listing other subdirs works fine though.
Other things that hang are w and xdm-greeter.

Considering these symptoms, it seems to be more of an issue with mozilla
than with the kernel. Still, I don't know why the ls /proc/mozilla should
block. Also things work perfectly with kernel 2.4.6-pre5.

Can anybody reproduce the symptoms, tell me whether this is a problem with
the kernel, mozilla or both, or provide me with other insight? I'd
appreciate it very much!

Bye
Felix

