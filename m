Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S272187AbRHWC1o>; Wed, 22 Aug 2001 22:27:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S272195AbRHWC1f>; Wed, 22 Aug 2001 22:27:35 -0400
Received: from rj.sgi.com ([204.94.215.100]:31712 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S272187AbRHWC1P>;
	Wed, 22 Aug 2001 22:27:15 -0400
X-Mailer: exmh version 2.1.1 10/15/1999
From: Keith Owens <kaos@ocs.com.au>
To: Travis Shirk <travis@pobox.com>
cc: Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Kernel Locking Up 
In-Reply-To: Your message of "Wed, 22 Aug 2001 09:46:14 CST."
             <Pine.LNX.4.33.0108220938390.1152-100000@puddy.travisshirk.net> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Thu, 23 Aug 2001 12:27:25 +1000
Message-ID: <19757.998533645@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Aug 2001 09:46:14 -0600 (MDT), 
Travis Shirk <travis@pobox.com> wrote:
>Ever since I upgraded to the 2.4.x (currently running 2.4.8)
>kernels, my machine has been locking up every other day
>or so.  Does anyone have any hints/tips for figuring out
>what is going on.

Kernel Debugger + serial console.
ftp://oss.sgi.com/projects/kdb/download/ix86/.  man Documentation/kdb.mm.
Documentation/serial-console.txt.

Make sure that you enable the NMI watchdog, boot 2.4.x kernels with
"nmi_watchdog=1".  Unless the problem is a total hardware lockup, nmi
will trip after 5 seconds and drop into kdb.

