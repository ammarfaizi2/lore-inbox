Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S263991AbSLLQKV>; Thu, 12 Dec 2002 11:10:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S264622AbSLLQKV>; Thu, 12 Dec 2002 11:10:21 -0500
Received: from hellcat.admin.navo.hpc.mil ([204.222.179.34]:51425 "EHLO
	hellcat.admin.navo.hpc.mil") by vger.kernel.org with ESMTP
	id <S263991AbSLLQKU> convert rfc822-to-8bit; Thu, 12 Dec 2002 11:10:20 -0500
Content-Type: text/plain; charset=US-ASCII
From: Jesse Pollard <pollard@admin.navo.hpc.mil>
To: "Alexandre Pires" <linux_kernel_br@yahoo.com.br>,
       <linux-kernel@vger.kernel.org>
Subject: Re: Modules and dll
Date: Thu, 12 Dec 2002 10:17:56 -0600
User-Agent: KMail/1.4.1
References: <03d501c2a1fe$7b371dd0$6400a8c0@sawamu>
In-Reply-To: <03d501c2a1fe$7b371dd0$6400a8c0@sawamu>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Message-Id: <200212121017.56923.pollard@admin.navo.hpc.mil>
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thursday 12 December 2002 10:49 am, Alexandre Pires wrote:
> Hi,
>
>     We could compare the modules programs of linux with dlls of Windows ?
> Exist many differences between them (in relation to the functioning) ?

no. Windows DLLs are more like shared libraries. They are easily replaced (if
inactive), and do not directly destroy the system if missing.

DLLs are connected to applications via subroutine calls (Win DLL and shared 
libraries), modules are usually accessed via special files, or system calls. 
There is no direct linking (by memory mapping the module code to the user 
mode application). Shared libraries are done this way.

Modules are closer to the device drivers in windows, which is what most
modules support. They can also support extending the OS by adding
additional capabilities - TCP/IP, IPv4, and IPv6 come to mind as some of the
most used, followed by the loadable binary interpretation (elf vs a.out).

Another difference is the way they are used - modules are loaded into
kernel mapping either by a kernel resident loader, or a userspace tool that
does the same. Shared libraries and DLLs are just put on disk where the
applications have been linked to expect them (or use an environment
variable to provide a search list of places to look when the application is
run.

-- 
-------------------------------------------------------------------------
Jesse I Pollard, II
Email: pollard@navo.hpc.mil

Any opinions expressed are solely my own.
