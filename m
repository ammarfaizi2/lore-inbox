Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S315207AbSEUQvJ>; Tue, 21 May 2002 12:51:09 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S315212AbSEUQvI>; Tue, 21 May 2002 12:51:08 -0400
Received: from ns.suse.de ([213.95.15.193]:63502 "HELO Cantor.suse.de")
	by vger.kernel.org with SMTP id <S315207AbSEUQvH>;
	Tue, 21 May 2002 12:51:07 -0400
Date: Tue, 21 May 2002 18:51:07 +0200
From: Dave Jones <davej@suse.de>
To: Claude Lamy <clamy@sunrisetelecom.com>, linux-kernel@vger.kernel.org
Subject: Re: Fw: /usr/include/asm/system.h
Message-ID: <20020521185107.C15417@suse.de>
Mail-Followup-To: Dave Jones <davej@suse.de>,
	Claude Lamy <clamy@sunrisetelecom.com>, linux-kernel@vger.kernel.org
In-Reply-To: <000d01c200c4$4d0b9570$5132a8c0@AVANSUN.COM> <20020521144833.X15417@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 21, 2002 at 02:48:33PM +0200, Dave Jones wrote:
 >  > > > I am running a Mandrake 8.1 linux distribution with gcc 2.96.  In
 >  > > > the file /usr/include/asm/system.h, the function __cmpxchg uses a
 >  > > > parameter named "new" which is a reserved keyword in C++.
 > The function is wrapped in an #ifdef __KERNEL__
 > Kernel code isn't meant to be compiled with a c++ compiler

I was of course, completely wrong about this, that #ifdef doesn't cover
the whole of <asm/system.h>. 

Some of the stuff outside that ifdef will never work in a userspace
app anyway (like wbinvd). Looking at it, is there anything there at all
that we should let userspace be seeing, or should that #ifdef cover
the whole file ?

    Dave.

-- 
| Dave Jones.        http://www.codemonkey.org.uk
| SuSE Labs
