Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S264113AbTEGQGm (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 7 May 2003 12:06:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S264114AbTEGQGm
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 7 May 2003 12:06:42 -0400
Received: from elin.scali.no ([62.70.89.10]:58528 "EHLO elin.scali.no")
	by vger.kernel.org with ESMTP id S264113AbTEGQGk (ORCPT
	<rfc822;linux-kernel@vger.kernel.org>);
	Wed, 7 May 2003 12:06:40 -0400
Date: Wed, 7 May 2003 18:18:56 +0200 (CEST)
From: Steffen Persvold <sp@scali.com>
X-X-Sender: sp@sp-laptop.isdn.scali.no
To: petter wahlman <petter@bluezone.no>
cc: linux-kernel@vger.kernel.org
Subject: Re: The disappearing sys_call_table export.
In-Reply-To: <1052321673.3727.737.camel@badeip>
Message-ID: <Pine.LNX.4.44.0305071807250.3573-100000@sp-laptop.isdn.scali.no>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On 7 May 2003, petter wahlman wrote:

>  
> It seems like nobody belives that there are any technically valid
> reasons for hooking system calls, but how should e.g anti virus
> on-access scanners intercept syscalls?
> Preloading libraries, ptracing init, patching g/libc, etc. are
> obviously not the way to go.
> 

Well, for a system wide system call hook, a kernel mechanism is necessary 
(and useful too IMHO). However for our usage (MPI) it is enough to know 
when the current process calls either sbrk(-n) or munmap glibc functions, 
thus it is sufficient to implement some kind of callback functionality for 
certain glibc functions, sort of like the malloc/free hooks but on a more 
general basis since some applications doesn't use malloc/free but 
implement their own alloc/free algorithms using the syscalls (one example 
is f90 apps).

Ideas anyone ?

Regards,
-- 
  Steffen Persvold   |       Scali AS      
 mailto:sp@scali.com |  http://www.scali.com
Tel: (+47) 2262 8950 |   Olaf Helsets vei 6
Fax: (+47) 2262 8951 |   N0621 Oslo, NORWAY

