Return-Path: <linux-kernel-owner@vger.kernel.org>
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id <S129818AbQKZMf3>; Sun, 26 Nov 2000 07:35:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org
        id <S129819AbQKZMfU>; Sun, 26 Nov 2000 07:35:20 -0500
Received: from a203-167-249-89.reverse.clear.net.nz ([203.167.249.89]:8708
        "HELO metastasis.f00f.org") by vger.kernel.org with SMTP
        id <S129818AbQKZMfN>; Sun, 26 Nov 2000 07:35:13 -0500
Date: Mon, 27 Nov 2000 01:05:08 +1300
From: Chris Wedgwood <cw@f00f.org>
To: Jeff Garzik <jgarzik@mandrakesoft.com>
Cc: Andrew Park <apark@cdf.toronto.edu>,
        Linux-KERNEL <linux-kernel@vger.kernel.org>
Subject: Re: changing BIOS setting
Message-ID: <20001127010508.A1523@metastasis.f00f.org>
In-Reply-To: <Pine.LNX.4.21.0011241758500.12040-100000@blue.cdf.utoronto.ca> <3A1EF2D0.991EBFFB@mandrakesoft.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.2.5i
In-Reply-To: <3A1EF2D0.991EBFFB@mandrakesoft.com>; from jgarzik@mandrakesoft.com on Fri, Nov 24, 2000 at 05:59:28PM -0500
X-No-Archive: Yes
Sender: linux-kernel-owner@vger.kernel.org
X-Mailing-List: linux-kernel@vger.kernel.org

However , this won't change boot sequence at that is store in the
CMOS on your RTC chip... if you really wanted though; you could mess
with that via /dev/nvram or whatever it's called.

Not that I suggest this is a good idea, most likely you will corrupt
it and the BIOS will get a checksum error and reinitialize the nvram
to defaults.




  --cw

On Fri, Nov 24, 2000 at 05:59:28PM -0500, Jeff Garzik wrote:

    Andrew Park wrote:

    > Is there a way to change BIOS setting (like boot sequence) from
    > the kernel space?  Any pointers would be appreciated.
    
    Yes.  All the BIOS does is configure your hardware.  Get docs on
    your hardware, and you can do anything that BIOS does.  For
    example, if your parallel port is disabled in BIOS, and you have
    the datasheet for your southbridge, then you can "manually"
    enable the parallel port by writing certain values to certain PCI
    config registers.
-
To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
the body of a message to majordomo@vger.kernel.org
Please read the FAQ at http://www.tux.org/lkml/
