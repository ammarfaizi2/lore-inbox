Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266034AbUAQM7q (ORCPT <rfc822;willy@w.ods.org>);
	Sat, 17 Jan 2004 07:59:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266036AbUAQM7q
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Sat, 17 Jan 2004 07:59:46 -0500
Received: from kluizenaar.xs4all.nl ([213.84.184.247]:25153 "EHLO samwel.tk")
	by vger.kernel.org with ESMTP id S266034AbUAQM7p (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Sat, 17 Jan 2004 07:59:45 -0500
From: Bart Samwel <bart@samwel.tk>
To: root@chaos.analogic.com, Ashish sddf <buff_boulder@yahoo.com>
Subject: Re: Compiling C++ kernel module + Makefile
Date: Sat, 17 Jan 2004 13:59:20 +0100
User-Agent: KMail/1.5.4
Cc: linux-kernel@vger.kernel.org
References: <20040116210924.61545.qmail@web12008.mail.yahoo.com> <Pine.LNX.4.53.0401161659470.31455@chaos>
In-Reply-To: <Pine.LNX.4.53.0401161659470.31455@chaos>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Message-Id: <200401171359.20381.bart@samwel.tk>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Friday 16 January 2004 23:07, Richard B. Johnson wrote:
> If somebody actually got a module, written in C++, to compile and
> work on linux-2.4.nn, as you state, it works only by fiat, i.e., was
> declared to work. There is no C++ runtime support in the kernel for
> C++. Are you sure this is a module and not an application? Many
> network processes (daemons) are applications and they don't require
> any knowledge of kernel internals except what's provided by the
> normal C/C++ include-files.

Rest assured, ;) this is definitely a module. It includes a kernel patch that 
makes it possible to include a lot of the kernel headers into C++, stuff like 
changing asm :: to asm : : (note the space, :: is an operator in C++) and 
renaming "struct namespace" to something containing less C++ keywords. The 
module also includes rudimentary C++ runtime support code, so that the C++ 
code will run inside the kernel. I'm afraid that the task of compiling it for 
2.6 is going to be pretty tough -- the kernel needs loads of patches to make 
it work within a C++ extern "C" clause, and it probably completely different 
patches from those needed by 2.4. Getting the build system to work is the 
least of the concerns.

-- Bart
