Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S266050AbRF1R24>; Thu, 28 Jun 2001 13:28:56 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S266047AbRF1R2p>; Thu, 28 Jun 2001 13:28:45 -0400
Received: from chaos.analogic.com ([204.178.40.224]:5762 "EHLO
	chaos.analogic.com") by vger.kernel.org with ESMTP
	id <S266050AbRF1R2o>; Thu, 28 Jun 2001 13:28:44 -0400
Date: Thu, 28 Jun 2001 13:28:35 -0400 (EDT)
From: "Richard B. Johnson" <root@chaos.analogic.com>
Reply-To: root@chaos.analogic.com
To: Michael J Clark <clarkmic@pobox.upenn.edu>
cc: linux-kernel@vger.kernel.org
Subject: Re: A system call in the kernel
In-Reply-To: <200106281714.f5SHEmJ14746@pobox.upenn.edu>
Message-ID: <Pine.LNX.3.95.1010628132417.30920A-100000@chaos.analogic.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jun 2001, Michael J Clark wrote:

> Any ideas on hot to easily call an outside program from the kernel (like 
> system(), exec()....)  Is this possible?  Thanks
> 
> Mike
> -

Look through the drivers and check upon "kernel_thread()". This shares
the process context of 'init' so you can do a lot of "user-mode" things
in the kernel. But.... beware.... User mode stuff should be done in
user-mode, not in the kernel.


Cheers,
Dick Johnson

Penguin : Linux version 2.4.1 on an i686 machine (799.53 BogoMips).

    I was going to compile a list of innovations that could be
    attributed to Microsoft. Once I realized that Ctrl-Alt-Del
    was handled in the BIOS, I found that there aren't any.


