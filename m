Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S287658AbSAXMVF>; Thu, 24 Jan 2002 07:21:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S287657AbSAXMU4>; Thu, 24 Jan 2002 07:20:56 -0500
Received: from [195.66.192.167] ([195.66.192.167]:7953 "EHLO
	Port.imtp.ilyichevsk.odessa.ua") by vger.kernel.org with ESMTP
	id <S287658AbSAXMUq>; Thu, 24 Jan 2002 07:20:46 -0500
Message-Id: <200201241215.g0OCFSE10537@Port.imtp.ilyichevsk.odessa.ua>
Content-Type: text/plain; charset=US-ASCII
From: Denis Vlasenko <vda@port.imtp.ilyichevsk.odessa.ua>
Reply-To: vda@port.imtp.ilyichevsk.odessa.ua
To: William Lee Irwin III <wli@holomorphy.com>,
        "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Subject: Re: Can linux support ccNUMA machine now?
Date: Thu, 24 Jan 2002 14:15:30 -0200
X-Mailer: KMail [version 1.3.2]
Cc: Barry Wu <wqb123@yahoo.com>, linux-kernel@vger.kernel.org
In-Reply-To: <20020123003530.60778.qmail@web13903.mail.yahoo.com> <74750000.1011782724@flay> <20020123200405.D899@holomorphy.com>
In-Reply-To: <20020123200405.D899@holomorphy.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> With some simple calculations for various things, I predict ZONE_NORMAL
> will get filled by large boot-time allocations on x86 with PAE and 64GB
> of RAM. I'm not entirely sure what other sorts of pathologies arise
> while these beasts still function; but without enough ZONE_NORMAL to
> satisfy all the combined boot-time allocation requests, the kernel
> will surely panic.
...
> P.S.: Blame it on struct page.

Looks like running x86 with more than 16GB RAM is not a good idea.
If you need it, you need 64bit arch.

This limit can be raised substantially by reducing low 4GB memory 
requirements, but don't you feel it's like running 16-bit DOS
on 686 class CPU? HIMEM.SYS, EMM, horde of DOS extenders - sounds familiar?

However, CPU vendors war over common 64-bit arch is still ahead...
--
vda
