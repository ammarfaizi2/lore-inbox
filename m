Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S312842AbSDFVgi>; Sat, 6 Apr 2002 16:36:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S312843AbSDFVgh>; Sat, 6 Apr 2002 16:36:37 -0500
Received: from mail3.aracnet.com ([216.99.193.38]:38320 "EHLO
	mail3.aracnet.com") by vger.kernel.org with ESMTP
	id <S312842AbSDFVgg>; Sat, 6 Apr 2002 16:36:36 -0500
Date: Sat, 06 Apr 2002 13:37:17 -0800
From: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
Reply-To: "Martin J. Bligh" <Martin.Bligh@us.ibm.com>
To: Byron Stanoszek <gandalf@winds.org>, Jeremy Jackson <jerj@coplanar.net>
cc: linux-kernel@vger.kernel.org, ebiederm@xmission.com
Subject: Re: Faster reboots - calling _start?
Message-ID: <1745393533.1018100235@[10.10.2.3]>
In-Reply-To: <Pine.LNX.4.44.0204061201281.7190-100000@winds.org>
X-Mailer: Mulberry/2.1.2 (Win32)
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

> Wouldn't it be easier to just ljmp to the start address of the kernel in
> memory (the address after the bootloader has done its thing), effectively
> restarting the kernel from line 1? Or is tehre an issue with some
> hardware being in an invalid state when doing this?

Two issues with that:

1. I want to be able to boot a different kernel on reboot - this
is a development machine.

2. I believe we free all the __init stuff around the end of
start_kernel, so the initial functions and data just aren't 
there any more ... of course that could be changed, but it's
both a more major change than I really want to do, and it still
doesn't solve (1) ;-)

M.

