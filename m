Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266347AbTBTRao>; Thu, 20 Feb 2003 12:30:44 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266356AbTBTRao>; Thu, 20 Feb 2003 12:30:44 -0500
Received: from havoc.daloft.com ([64.213.145.173]:21142 "EHLO havoc.gtf.org")
	by vger.kernel.org with ESMTP id <S266347AbTBTRan>;
	Thu, 20 Feb 2003 12:30:43 -0500
Date: Thu, 20 Feb 2003 12:40:43 -0500
From: Jeff Garzik <jgarzik@pobox.com>
To: Prasad <prasad_s@students.iiit.net>
Cc: lkml <linux-kernel@vger.kernel.org>
Subject: Re: Syscall from Kernel Space
Message-ID: <20030220174043.GI9800@gtf.org>
References: <Pine.LNX.4.44.0302202301350.12696-100000@students.iiit.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.44.0302202301350.12696-100000@students.iiit.net>
User-Agent: Mutt/1.3.28i
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 20, 2003 at 11:04:37PM +0530, Prasad wrote:
> 	Is there a way using which i could invoke a syscall in the kernel 
> space?  The syscall is to be run disguised as another process.  The actual 

Call sys_<syscall>.  Look at the kernel code for examples.

Note that typically you don't want to do this... and you _really_ don't
want to do this if the syscall is not one of the common file I/O
syscalls (read/write/open/close, etc.)

	Jeff




