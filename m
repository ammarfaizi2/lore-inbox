Return-Path: <linux-kernel-owner+willy=40w.ods.org@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S266607AbUBDVm2 (ORCPT <rfc822;willy@w.ods.org>);
	Wed, 4 Feb 2004 16:42:28 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S266608AbUBDVjo
	(ORCPT <rfc822;linux-kernel-outgoing>);
	Wed, 4 Feb 2004 16:39:44 -0500
Received: from chaos.analogic.com ([204.178.40.224]:16768 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP id S266607AbUBDVi2
	(ORCPT <rfc822;linux-kernel@vger.kernel.org>);
	Wed, 4 Feb 2004 16:38:28 -0500
Date: Wed, 4 Feb 2004 16:39:07 -0500 (EST)
From: "Richard B. Johnson" <root@chaos.analogic.com>
X-X-Sender: root@chaos
Reply-To: root@chaos.analogic.com
To: "Randazzo, Michael" <RANDAZZO@ddc-web.com>
cc: "'Valdis.Kletnieks@vt.edu'" <Valdis.Kletnieks@vt.edu>,
       "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: RE: Kernel 2.x POSIX Compliance/Conformance... 
In-Reply-To: <89760D3F308BD41183B000508BAFAC4104B16F39@DDCNYNTD>
Message-ID: <Pine.LNX.4.53.0402041631470.3277@chaos>
References: <89760D3F308BD41183B000508BAFAC4104B16F39@DDCNYNTD>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 4 Feb 2004, Randazzo, Michael wrote:

> ok...I think I get it....
>
> I can't use any of the posix functions in
> device drivers (modules).....is this correct?
>
> M.

You cannot ever use any 'C' runtime library functions in your
modules. This means you cannot use open(), close(), read(),
write(), lseek(), etc. However, the kernel has some of its
own POSIX-compliant functions like memset(), memcpy(), strcpy(),
etc. You can look in ../linux-nn.nn/lib or look through the
headers to see what's available. There are semaphones and
other locking mechanisms available for use in the kernel
which, I recall, was your first inquiry.

Cheers,
Dick Johnson
Penguin : Linux version 2.4.24 on an i686 machine (797.90 BogoMips).
            Note 96.31% of all statistics are fiction.


