Return-Path: <linux-kernel-owner+akpm=40zip.com.au@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S316193AbSEKCWI>; Fri, 10 May 2002 22:22:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S316194AbSEKCWH>; Fri, 10 May 2002 22:22:07 -0400
Received: from mail.ocs.com.au ([203.34.97.2]:35078 "HELO mail.ocs.com.au")
	by vger.kernel.org with SMTP id <S316193AbSEKCWG>;
	Fri, 10 May 2002 22:22:06 -0400
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: linux-kernel@vger.kernel.org
Subject: Re: [PATCH] BUG() disassembly tweak 
In-Reply-To: Your message of "Sat, 11 May 2002 03:07:51 +0100."
             <Pine.LNX.4.21.0205110258480.2235-100000@localhost.localdomain> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Sat, 11 May 2002 12:21:55 +1000
Message-ID: <3622.1021083715@ocs3.intra.ocs.com.au>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 11 May 2002 03:07:51 +0100 (BST), 
Hugh Dickins <hugh@veritas.com> wrote:
>On Sat, 11 May 2002, Keith Owens wrote:
>> 
>> IMNSHO the instructions _after_ the oops are almost useless.
>
>Oh, I agree: I'd be perfectly happy for ksymoops to abandon trying
>to disassemble the instructions after the oops, and I don't think
>it need try to disassemble the instructions before the oops either.
>
>It is important that it show the bytes (preferably before and)
>after the oops, so that an investigator can locate that sequence
>of bytes in a built object; and it is important that we have some
>tool (objdump) which can disassemble the built object despite ud2
>and its accompanying data; but ksymoops does not need to do it.

ksymoops does more than decode the instructions.  It does all the work
required to build the dummy object ready for objdump to do the
decoding.  It also massages the objdump output to make it more readable
and does symbol lookup on the absolute addresses returned by objdump.

