Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315721AbSHITVO>; Fri, 9 Aug 2002 15:21:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315734AbSHITVN>; Fri, 9 Aug 2002 15:21:13 -0400
Received: from e1.ny.us.ibm.com ([32.97.182.101]:25292 "EHLO e1.ny.us.ibm.com")
	by vger.kernel.org with ESMTP id <S315721AbSHITVN>;
	Fri, 9 Aug 2002 15:21:13 -0400
Date: Fri, 09 Aug 2002 14:24:09 -0500
From: Dave McCracken <dmccr@us.ibm.com>
To: trond.myklebust@fys.uio.no
cc: Linux Kernel <linux-kernel@vger.kernel.org>
Subject: [PATCH 2.5.30+] Fourth attempt at a shared credentials patch
Message-ID: <55560000.1028921049@baldur.austin.ibm.com>
In-Reply-To: <15698.59577.788998.300262@charged.uio.no>
References: <23130000.1028818693@baldur.austin.ibm.com>
 <shsofcdfjt6.fsf@charged.uio.no><44050000.1028823650@baldur.austin.ibm.com>
 <15698.41542.250846.334946@charged.uio.no>
 <52960000.1028829902@baldur.austin.ibm.com>
 <15698.52455.437254.428402@charged.uio.no>
 <81390000.1028837464@baldur.austin.ibm.com>
 <15698.59577.788998.300262@charged.uio.no>
X-Mailer: Mulberry/2.2.1 (Linux/x86)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org


--On Thursday, August 08, 2002 11:55:05 PM +0200 Trond Myklebust
<trond.myklebust@fys.uio.no> wrote:

> What if one thread is doing an RPC call while the other is changing
> the 'groups' entry?

Gah.  Good point.  Ok, I've added locking to the cred structure to handle
this.  Here's my new patch with those changes made:

http://www.ibm.com/linux/ltc/patches/misc/cred-2.5.30-5.diff.gz

I've gone through all the code again, and don't see any other places where
locking is really necessary.  Feel free to point them out to me if you see
any.

Dave McCracken

======================================================================
Dave McCracken          IBM Linux Base Kernel Team      1-512-838-3059
dmccr@us.ibm.com                                        T/L   678-3059

