Return-Path: <linux-kernel-owner+willy=40w.ods.org-S932339AbVIMGLw@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932339AbVIMGLw (ORCPT <rfc822;willy@w.ods.org>);
	Tue, 13 Sep 2005 02:11:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932343AbVIMGLv
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Tue, 13 Sep 2005 02:11:51 -0400
Received: from smtpout.mac.com ([17.250.248.88]:31695 "EHLO smtpout.mac.com")
	by vger.kernel.org with ESMTP id S932339AbVIMGLv (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Tue, 13 Sep 2005 02:11:51 -0400
Mime-Version: 1.0 (Apple Message framework v734)
Content-Transfer-Encoding: 7bit
Message-Id: <6789B04A-198A-4C08-9F95-BFDBCD2C0660@mac.com>
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
To: LKML Kernel <linux-kernel@vger.kernel.org>
From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Kernel ABI headers step #1: Gathering information
Date: Tue, 13 Sep 2005 02:11:28 -0400
X-Mailer: Apple Mail (2.734)
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

As part of the kernel ABI headers project, I need to gather  
information on what
GCC provides on a variety of architectures and configurations.  I am  
looking for
people with a variety of architectures and distributions to run the  
script below
and (privately, please, no need to flood the list!) email me the  
output.  I'm
only interested in archs supported by linux, obviously :-D.  This  
should help me
to see if there are any global CPP features that can be relied upon  
across the
whole spectrum.  If you have any especially obtuse GCC/platform  
combination, I
would really appreciate it if you could do this, as otherwise I'm  
unlikely to
be able to locate all of said GCC combinations.  (The reason I get  
the kernel
version is so I'm able to tie GCC archs to kernel archs).  Once I've  
got a
decent database of per-arch features/macros/etc, I'll try to post it  
online
somewhere for all to access.  Thanks for all your help!

Cheers,
Kyle Moffett

--
There are two ways of constructing a software design. One way is to  
make it so
simple that there are obviously no deficiencies. And the other way is  
to make
it so complicated that there are no obvious deficiencies.  The first  
method is
far more difficult.
   -- C.A.R. Hoare



#! /bin/sh

echo "Linux kernel version:"
uname -a
echo
echo
echo "GCC version:"
gcc -v
echo
echo
echo "GCC predefined macros:"
echo | gcc -E - -dM | sort


