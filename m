Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266564AbSLJFob>; Tue, 10 Dec 2002 00:44:31 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266565AbSLJFob>; Tue, 10 Dec 2002 00:44:31 -0500
Received: from deviant.impure.org.uk ([195.82.120.238]:16061 "EHLO
	deviant.impure.org.uk") by vger.kernel.org with ESMTP
	id <S266564AbSLJFoa>; Tue, 10 Dec 2002 00:44:30 -0500
Date: Tue, 10 Dec 2002 05:52:15 +0000
From: Dave Jones <davej@codemonkey.org.uk>
To: Joseph <jospehchan@yahoo.com.tw>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Why does C3 CPU downgrade in kernel 2.4.20?
Message-ID: <20021210055215.GA9124@suse.de>
Mail-Followup-To: Dave Jones <davej@codemonkey.org.uk>,
	Joseph <jospehchan@yahoo.com.tw>, linux-kernel@vger.kernel.org
References: <009f01c2a000$f38885d0$3716a8c0@taipei.via.com.tw>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <009f01c2a000$f38885d0$3716a8c0@taipei.via.com.tw>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 10, 2002 at 12:02:25PM +0800, Joseph wrote:
 > Hi all,
 >   I rebuilt the 2.4.20 kernel with C3 CPU and found it been downgraded to
 > i486.
 >   And I check the file, linux/arch/i386/Makefile, in both of 2.4.19 and
 > 2.4.20 kernels.
 >   In 2.4.19, the CFLAGS adds "-march=i586".
 >   But in 2.4.20, the CFLAGS adds
 > "-march=i486 -malign-functions=0 -malign-jumps=0 -malign-loops=0".
 >   Why do this? Could anybody explain this to me?

I believe someone (Jeff Garzik?) benchmarked gcc code generation,
and the C3 executed code scheduled for a 486 faster than it did for
-m586
I'm not sure about the alignment flags. I've been meaning to look
into that myself...

        Dave

