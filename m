Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id <S267088AbRGJSvG>; Tue, 10 Jul 2001 14:51:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org
	id <S267089AbRGJSu4>; Tue, 10 Jul 2001 14:50:56 -0400
Received: from weta.f00f.org ([203.167.249.89]:49794 "HELO weta.f00f.org")
	by vger.kernel.org with SMTP id <S267088AbRGJSut>;
	Tue, 10 Jul 2001 14:50:49 -0400
Date: Wed, 11 Jul 2001 06:50:43 +1200
From: Chris Wedgwood <cw@f00f.org>
To: "C. Slater" <cslater@wcnet.org>
Cc: linux-kernel@vger.kernel.org
Subject: Re: Switching Kernels without Rebooting?
Message-ID: <20010711065043.G32421@weta.f00f.org>
In-Reply-To: <000b01c10970$096cd8c0$fe00000a@cslater>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <000b01c10970$096cd8c0$fe00000a@cslater>
User-Agent: Mutt/1.3.18i
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 10, 2001 at 02:42:12PM -0400, C. Slater wrote:

    Hi, i was just thinking about if it would be possible to switch
    kernels without haveing to restart the entire system.

Pre-solaris 8 sun were promising this

    Sort of a "Live kernel replacement". It sort of goes along with
    the hot-swap-everything ideas. I was thinking something like

    - Take all the structs related to userspace memory and processes
    - Save them to a reserved area of memory
    - Halt the kernel, mostly

what about timing critical things? you mention networking, but there
are others

    - Wipe kernel-space memory clean to avoid confusion
    - Load new kernel into memory

    - Replace all saved structures

what if the layout of these changes as it often does?

    - Start kernel running agin

    This seems like the easiest way to do it. The biggest problem is
    that there would be somewhere about 30 seconds where all processes
    would be frozen.

It seems like difficult to implement solution for little gain. Linux
can be booted _very_ quickly on modern machines, probably about 15s
for most hardware.  If you use burn linux into the rom of use a
flashdisk (or similar solution), you can have everything rebooted in
under five seconds.

The zflinux chips/machines probably boot in half that, maybe less (as
tested on a prototype many months ago).





  --cw
