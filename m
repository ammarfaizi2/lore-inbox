Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S291463AbSBAAqr>; Thu, 31 Jan 2002 19:46:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S291464AbSBAAqh>; Thu, 31 Jan 2002 19:46:37 -0500
Received: from rj.sgi.com ([204.94.215.100]:6638 "EHLO rj.sgi.com")
	by vger.kernel.org with ESMTP id <S291463AbSBAAqT>;
	Thu, 31 Jan 2002 19:46:19 -0500
X-Mailer: exmh version 2.2 06/23/2000 with nmh-1.0.4
From: Keith Owens <kaos@ocs.com.au>
To: ebiederm@xmission.com (Eric W. Biederman)
Cc: linux-kernel@vger.kernel.org
Subject: Re: [RFC] x86 ELF bootable kernels/Linux booting Linux/LinuxBIOS 
In-Reply-To: Your message of "31 Jan 2002 16:36:27 PDT."
             <m1elk6t7no.fsf@frodo.biederman.org> 
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Date: Fri, 01 Feb 2002 11:46:09 +1100
Message-ID: <22967.1012524369@kao2.melbourne.sgi.com>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 31 Jan 2002 16:36:27 -0700, 
ebiederm@xmission.com (Eric W. Biederman) wrote:
>"Erik A. Hendriks" <hendriks@lanl.gov> writes:
>Sort of.  The assumptions change per architecture.  But I haven't
>heard of an architecture where some addresses are not safe.

NUMA boxes with discontiguous physical memory.  You may not boot off
node 0.  Whichever node you boot from may not be able to see all of
physical memory yet, the cross node directrories may not be set up.
The boot node may not even have physical address 0.  I don't say that
these boxes exist yet but they are possible with discontiguous memory
architectures.

>Dynamic linking with relocation is nasty.  

I have some code in insmod that you can use ...  Nasty is an
understatement.

