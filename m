Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316569AbSHJBIR>; Fri, 9 Aug 2002 21:08:17 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316574AbSHJBHZ>; Fri, 9 Aug 2002 21:07:25 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:39432 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316569AbSHJBGK>;
	Fri, 9 Aug 2002 21:06:10 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: kernel BUG at /usr/src/linux-2.5.30/include/linux/dcache.h:261! 
In-reply-to: Your message of "Fri, 09 Aug 2002 14:00:37 MST."
             <3D542D75.7FEA9DDF@zip.com.au> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 10 Aug 2002 11:09:42 +1000
Message-ID: <8412.1028941782@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Aug 2002 14:00:37 -0700, 
Andrew Morton <akpm@zip.com.au> wrote:
>It would be much more useful if the oops code were to dump the
>text preceding the exception EIP rather than after it, actually.
>I think Keith said that ksymoops supports that.

Not only does ksymoops support it but some architectures already do
this.  Mind you, they are not consistent :(

Alpha:  Code: 44220001  f4200003  46520400 <a77d9c38> 6b9b4a40  a44803a8  42425401  42c10403  40603401
Arm:    Code: e7973108 e1a02423 (e5c42001) e5c43000 e1a02823

If any instruction in the code line is enclosed in <> or () then
ksymoops assumes that the first byte is EIP.  Otherwise the first byte
of the line is EIP.  Anybody want to update i386/ia64/mips/... oops code
to dump context around the failing instruction?  Maximum of 64 bytes in
the code line please.

